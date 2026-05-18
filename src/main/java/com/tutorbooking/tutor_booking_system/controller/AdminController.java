package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Admin;
import com.tutorbooking.tutor_booking_system.service.AdminService;
import com.tutorbooking.tutor_booking_system.service.BookingService;
import com.tutorbooking.tutor_booking_system.service.ReviewService;
import com.tutorbooking.tutor_booking_system.service.StudentService;
import com.tutorbooking.tutor_booking_system.service.TutorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * AdminController
 *
 * Handles: Admin authentication, dashboard stats/charts, and admin profile management.
 *
 * Tutor management   → TutorController  (/admin/tutors/...)
 * Student management → StudentController (/admin/students/...)
 * Booking management → BookingController (/admin/bookings/...)
 * Review management  → ReviewController  (/admin/reviews/...)
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminService   adminService;
    @Autowired private TutorService   tutorService;
    @Autowired private StudentService studentService;
    @Autowired private ReviewService  reviewService;
    @Autowired private BookingService bookingService;

    private boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    // ══════════════════════════════════════════════════════════
    //  LOGIN / LOGOUT
    // ══════════════════════════════════════════════════════════

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        if (isLoggedIn(session)) return "redirect:/admin/dashboard";
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes ra) {
        Admin admin = adminService.loginAdmin(email, password);
        if (admin != null) {
            session.setAttribute("adminId",   admin.getId());
            session.setAttribute("adminName", admin.getName());
            return "redirect:/admin/dashboard";
        }
        ra.addFlashAttribute("error", "Invalid email or password.");
        return "redirect:/admin/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    // ══════════════════════════════════════════════════════════
    //  DASHBOARD
    // ══════════════════════════════════════════════════════════

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";

        // Stat cards
        model.addAttribute("totalTutors",   tutorService.countAll());
        model.addAttribute("pendingTutors", tutorService.countPending());
        model.addAttribute("totalStudents", studentService.countAll());
        model.addAttribute("totalBookings", bookingService.countAll());
        model.addAttribute("totalReviews",  reviewService.countAll());

        // Chart: tutors by subject
        List<Object[]> subjectData   = tutorService.getSubjectCounts();
        List<String>   subjectLabels = new ArrayList<>();
        List<Long>     subjectValues = new ArrayList<>();
        for (Object[] row : subjectData) {
            subjectLabels.add((String) row[0]);
            subjectValues.add((Long)   row[1]);
        }
        model.addAttribute("subjectChartLabels", subjectLabels);
        model.addAttribute("subjectChartValues", subjectValues);

        // Chart: bookings over time
        List<Object[]> bookingData   = bookingService.getMonthlyBookingCounts();
        List<String>   bookingLabels = new ArrayList<>();
        List<Long>     bookingValues = new ArrayList<>();
        for (Object[] row : bookingData) {
            bookingLabels.add((String) row[0]);
            bookingValues.add((Long)   row[1]);
        }
        if (bookingLabels.isEmpty()) {
            bookingLabels = List.of("Jan","Feb","Mar","Apr","May","Jun");
            bookingValues = List.of(0L,0L,0L,0L,0L,0L);
        }
        model.addAttribute("bookingChartLabels", bookingLabels);
        model.addAttribute("bookingChartValues", bookingValues);

        // Chart: ratings distribution
        List<Object[]> ratingData = reviewService.getRatingCounts();
        long[] ratingArr = new long[]{0,0,0,0,0};
        for (Object[] row : ratingData) {
            int idx = ((Number) row[0]).intValue() - 1;
            if (idx >= 0 && idx < 5) ratingArr[idx] = (Long) row[1];
        }
        List<Long> ratingValues = new ArrayList<>();
        for (long v : ratingArr) ratingValues.add(v);
        model.addAttribute("ratingChartValues", ratingValues);

        return "admin/dashboard";
    }

    // ══════════════════════════════════════════════════════════
    //  PROFILE — VIEW / EDIT / CHANGE PASSWORD / DELETE ACCOUNT
    // ══════════════════════════════════════════════════════════

    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id = (Long) session.getAttribute("adminId");
        model.addAttribute("admin", adminService.getAdminById(id));
        return "admin/profile";
    }

    @GetMapping("/edit")
    public String editPage(HttpSession session) {
        return "redirect:/admin/profile";
    }

    @PostMapping("/edit")
    public String editSubmit(@RequestParam String name,
                             @RequestParam String email,
                             @RequestParam(required = false) String phone,
                             HttpSession session,
                             RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id     = (Long) session.getAttribute("adminId");
        Admin admin = adminService.getAdminById(id);
        admin.setName(name);
        admin.setEmail(email);
        admin.setPhone(phone);
        adminService.updateAdmin(admin);
        session.setAttribute("adminName", admin.getName());
        ra.addFlashAttribute("success", "Profile updated successfully.");
        return "redirect:/admin/profile";
    }

    @PostMapping("/profile/changePassword")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";

        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("pwError", "New passwords do not match.");
            return "redirect:/admin/profile";
        }
        if (newPassword.length() < 8) {
            ra.addFlashAttribute("pwError", "New password must be at least 8 characters.");
            return "redirect:/admin/profile";
        }

        Long id = (Long) session.getAttribute("adminId");
        boolean changed = adminService.changePassword(id, currentPassword, newPassword);

        if (changed) {
            ra.addFlashAttribute("pwSuccess", "Password updated successfully.");
        } else {
            ra.addFlashAttribute("pwError", "Current password is incorrect.");
        }
        return "redirect:/admin/profile";
    }

    @PostMapping("/delete")
    public String deleteAccount(@RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id     = (Long) session.getAttribute("adminId");
        Admin admin = adminService.getAdminById(id);

        if (admin == null) {
            session.invalidate();
            return "redirect:/admin/login";
        }
        if (!admin.getPassword().equals(confirmPassword)) {
            ra.addFlashAttribute("deleteError", "Incorrect password. Account was not deleted.");
            return "redirect:/admin/profile";
        }

        adminService.deleteAdmin(id);
        session.invalidate();
        return "redirect:/admin/login?deleted=true";
    }
}
