package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Admin;
import com.tutorbooking.tutor_booking_system.model.Booking;
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

        // Chart: bookings over time (real data)
        List<Object[]> bookingData   = bookingService.getMonthlyBookingCounts();
        List<String>   bookingLabels = new ArrayList<>();
        List<Long>     bookingValues = new ArrayList<>();
        for (Object[] row : bookingData) {
            bookingLabels.add((String) row[0]);
            bookingValues.add((Long)   row[1]);
        }
        // Fallback placeholder if no bookings yet
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

        // Chart: membership breakdown
        List<Object[]> memData   = studentService.getMembershipCounts();
        List<String>   memLabels = new ArrayList<>();
        List<Long>     memValues = new ArrayList<>();
        for (Object[] row : memData) {
            memLabels.add(row[0].toString());
            memValues.add((Long) row[1]);
        }
        model.addAttribute("membershipChartLabels", memLabels);
        model.addAttribute("membershipChartValues", memValues);

        return "admin/dashboard";
    }

    // ══════════════════════════════════════════════════════════
    //  TUTORS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutors")
    public String tutors(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("tutors", tutorService.getAllTutors());
        return "admin/tutors";
    }

    @PostMapping("/tutors/{id}/verify")
    public String verifyTutor(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        var t = tutorService.verifyTutor(id);
        if (t != null) ra.addFlashAttribute("success", t.getName() + " has been verified.");
        else           ra.addFlashAttribute("error",   "Tutor not found.");
        return "redirect:/admin/tutors";
    }

    @PostMapping("/tutors/{id}/delete")
    public String deleteTutor(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";

        try {
            tutorService.deleteTutor(id);
            ra.addFlashAttribute("success", "Tutor deleted successfully.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete tutor: They may have active bookings or reviews.");
        }

        return "redirect:/admin/tutors"; // Matches your list view URL
    }


    // ══════════════════════════════════════════════════════════
    //  STUDENTS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/students")
    public String students(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("students", studentService.getAllStudents());
        return "admin/students";
    }

    @PostMapping("/students/{id}/delete")
    public String deleteStudent(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";

        try {
            studentService.deleteStudent(id);
            ra.addFlashAttribute("success", "Student deleted successfully.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete student: They may have active bookings or reviews.");
        }

        return "redirect:/admin/students"; // Matches your list view URL
    }


    // ══════════════════════════════════════════════════════════
    //  BOOKINGS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/bookings")
    public String bookings(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("bookings", bookingService.getAllBookings());
        return "admin/bookings";
    }

    @PostMapping("/bookings/{id}/cancel")
    public String cancelBooking(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        bookingService.updateStatus(id, Booking.Status.CANCELLED);
        ra.addFlashAttribute("success", "Booking #" + id + " has been cancelled.");
        return "redirect:/admin/bookings";
    }

    @PostMapping("/bookings/{id}/delete")
    public String deleteBooking(@PathVariable Long id,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        bookingService.deleteBooking(id);
        ra.addFlashAttribute("success", "Booking deleted.");
        return "redirect:/admin/bookings";
    }

    // ══════════════════════════════════════════════════════════
    //  REVIEWS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/reviews")
    public String reviews(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("reviews", reviewService.getAllReviews());
        return "admin/reviews";
    }

    @PostMapping("/reviews/{id}/delete")
    public String deleteReview(@PathVariable Long id,
                               HttpSession session,
                               RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        reviewService.deleteReview(id);
        ra.addFlashAttribute("success", "Review deleted.");
        return "redirect:/admin/reviews";
    }

    // ══════════════════════════════════════════════════════════
    //  PROFILE — EDIT / DELETE
    // ══════════════════════════════════════════════════════════

    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id     = (Long) session.getAttribute("adminId");
        Admin admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);
        return "admin/edit";
    }

    @PostMapping("/edit")
    public String editSubmit(@ModelAttribute Admin formAdmin,
                             HttpSession session,
                             RedirectAttributes ra) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id     = (Long) session.getAttribute("adminId");
        Admin admin = adminService.getAdminById(id);
        admin.setName(formAdmin.getName());
        admin.setPhone(formAdmin.getPhone());
        if (formAdmin.getPassword() != null && !formAdmin.getPassword().isBlank()) {
            admin.setPassword(formAdmin.getPassword());
        }
        adminService.updateAdmin(admin);
        session.setAttribute("adminName", admin.getName());
        ra.addFlashAttribute("success", "Profile updated successfully.");
        return "redirect:/admin/edit";
    }

    @GetMapping("/delete")
    public String deleteAccount(HttpSession session) {
        if (!isLoggedIn(session)) return "redirect:/admin/login";
        Long id = (Long) session.getAttribute("adminId");
        adminService.deleteAdmin(id);
        session.invalidate();
        return "redirect:/admin/login";
    }
}