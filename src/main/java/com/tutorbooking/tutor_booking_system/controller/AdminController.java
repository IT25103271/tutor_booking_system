package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.*;
import com.tutorbooking.tutor_booking_system.repository.*;
import com.tutorbooking.tutor_booking_system.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminService adminService;
    @Autowired private TutorRepository tutorRepository;
    @Autowired private StudentRepository studentRepository;
    @Autowired private ReviewRepository reviewRepository;
    @Autowired private BookingRepository bookingRepository;

    // ── LOGIN ─────────────────────────────────────────────────────
    @GetMapping("/login")
    public String loginPage() { return "admin/login"; }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes ra) {
        Admin admin = adminService.loginAdmin(email, password);
        if (admin == null) {
            ra.addFlashAttribute("error", "Invalid email or password.");
            return "redirect:/admin/login";
        }
        session.setAttribute("adminId", admin.getId());
        session.setAttribute("adminName", admin.getName());
        session.setAttribute("adminEmail", admin.getEmail());
        return "redirect:/admin/dashboard";
    }

    // ── LOGOUT ────────────────────────────────────────────────────
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    // ── DASHBOARD ─────────────────────────────────────────────────
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";

        Long adminId = Long.valueOf(session.getAttribute("adminId").toString());
        Admin admin = adminService.getAdminById(adminId);

        // Stats
        List<Tutor> tutors = tutorRepository.findAll();
        List<Student> students = studentRepository.findAll();
        List<Review> reviews = reviewRepository.findAll();
        List<Booking> bookings = bookingRepository.findAll();
        List<Tutor> pendingTutors = tutorRepository.findByVerified(false);

        model.addAttribute("admin", admin);
        model.addAttribute("tutors", tutors);
        model.addAttribute("students", students);
        model.addAttribute("reviews", reviews);
        model.addAttribute("bookings", bookings);
        model.addAttribute("totalTutors", tutors.size());
        model.addAttribute("totalStudents", students.size());
        model.addAttribute("totalReviews", reviews.size());
        model.addAttribute("totalBookings", bookings.size());
        model.addAttribute("pendingTutors", pendingTutors.size());
        return "admin/dashboard";
    }

    // ── VERIFY TUTOR ──────────────────────────────────────────────
    @PostMapping("/tutors/{id}/verify")
    public String verifyTutor(@PathVariable Long id,
                              HttpSession session,
                              RedirectAttributes ra) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";
        Tutor tutor = tutorRepository.findById(id).orElse(null);
        if (tutor != null) {
            tutor.setVerified(true);
            tutorRepository.save(tutor);
            ra.addFlashAttribute("success", "Tutor verified successfully!");
        }
        return "redirect:/admin/dashboard";
    }

    // ── DELETE REVIEW ─────────────────────────────────────────────
    @PostMapping("/reviews/{id}/delete")
    public String deleteReview(@PathVariable Long id,
                               HttpSession session,
                               RedirectAttributes ra) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";
        reviewRepository.deleteById(id);
        ra.addFlashAttribute("success", "Review deleted successfully!");
        return "redirect:/admin/dashboard";
    }

    // ── EDIT OWN PROFILE ──────────────────────────────────────────
    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";
        Long adminId = Long.valueOf(session.getAttribute("adminId").toString());
        model.addAttribute("admin", adminService.getAdminById(adminId));
        return "admin/edit";
    }

    @PostMapping("/edit")
    public String update(@RequestParam String name,
                         @RequestParam String email,
                         @RequestParam String phone,
                         @RequestParam String password,
                         HttpSession session,
                         RedirectAttributes ra) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";
        Long adminId = Long.valueOf(session.getAttribute("adminId").toString());
        Admin admin = adminService.getAdminById(adminId);
        admin.setName(name);
        admin.setEmail(email);
        admin.setPhone(phone);
        admin.setPassword(password);
        adminService.updateAdmin(admin);
        session.setAttribute("adminName", name);
        session.setAttribute("adminEmail", email);
        ra.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/admin/dashboard";
    }

    // ── DELETE OWN ACCOUNT ────────────────────────────────────────
    @PostMapping("/delete")
    public String delete(HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("adminId") == null) return "redirect:/admin/login";
        Long adminId = Long.valueOf(session.getAttribute("adminId").toString());
        adminService.deleteAdmin(adminId);
        session.invalidate();
        ra.addFlashAttribute("success", "Your account has been deleted.");
        return "redirect:/admin/login";
    }
}