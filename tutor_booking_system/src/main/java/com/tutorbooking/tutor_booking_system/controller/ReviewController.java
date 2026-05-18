package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * ReviewController
 *
 * Handles admin review management: /admin/reviews/**
 *
 * Student-side review submission → StudentController
 * Tutor-side review viewing      → TutorController
 */
@Controller
@RequestMapping("/admin/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    private boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    // ── LIST ──────────────────────────────────────────────────

    @GetMapping
    public String list(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("reviews", reviewService.getAllReviews());
        return "review/admin_reviews";
    }

    // ── DELETE ───────────────────────────────────────────────

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id,
                         HttpSession session,
                         RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        reviewService.deleteReview(id);
        ra.addFlashAttribute("success", "Review deleted.");
        return "redirect:/admin/reviews";
    }
}
