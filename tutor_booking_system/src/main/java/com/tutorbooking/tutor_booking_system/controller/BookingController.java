package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.service.BookingService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * BookingController
 *
 * Handles admin booking management: /admin/bookings/**
 *
 * Tutor-side booking actions (accept/complete/cancel) → TutorController
 * Student-side booking actions (cancel)               → StudentController
 */
@Controller
@RequestMapping("/admin/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    private boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    // ── LIST ──────────────────────────────────────────────────

    @GetMapping
    public String list(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("bookings", bookingService.getAllBookings());
        return "booking/admin_bookings";
    }

    // ── CANCEL ───────────────────────────────────────────────

    @PostMapping("/{id}/cancel")
    public String cancel(@PathVariable Long id,
                         HttpSession session,
                         RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        bookingService.updateStatus(id, Booking.Status.CANCELLED);
        ra.addFlashAttribute("success", "Booking #" + id + " has been cancelled.");
        return "redirect:/admin/bookings";
    }

    // ── DELETE ───────────────────────────────────────────────

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id,
                         HttpSession session,
                         RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        bookingService.deleteBooking(id);
        ra.addFlashAttribute("success", "Booking deleted.");
        return "redirect:/admin/bookings";
    }
}
