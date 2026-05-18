package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.*;
import com.tutorbooking.tutor_booking_system.repository.SubjectRepository;
import com.tutorbooking.tutor_booking_system.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * TutorController
 *
 * Handles:
 *   /tutor/**          — Tutor self-service (auth, dashboard, profile, schedule, bookings, reviews)
 *   /admin/tutors/**   — Admin tutor management (list, verify, delete)
 *
 * Forgot-password flow → ForgotPasswordController
 */
@Controller
public class TutorController {

    @Autowired private TutorService      tutorService;
    @Autowired private ScheduleService   scheduleService;
    @Autowired private BookingService    bookingService;
    @Autowired private ReviewService     reviewService;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private OtpService        otpService;
    @Autowired private EmailService      emailService;

    // ── helpers ──────────────────────────────────────────────

    private boolean isTutorLoggedIn(HttpSession session) {
        return session.getAttribute("tutorId") != null;
    }

    private Long getTutorId(HttpSession session) {
        return (Long) session.getAttribute("tutorId");
    }

    private boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    // ══════════════════════════════════════════════════════════
    //  TUTOR AUTH — LOGIN / LOGOUT / REGISTER / OTP
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/login")
    public String loginPage(HttpSession session) {
        if (isTutorLoggedIn(session)) return "redirect:/tutor/dashboard";
        return "tutor/login";
    }

    @PostMapping("/tutor/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes ra) {
        Tutor tutor = tutorService.loginTutor(email, password);
        if (tutor != null) {
            session.setAttribute("tutorId",   tutor.getId());
            session.setAttribute("tutorName", tutor.getName());
            return "redirect:/tutor/dashboard";
        }
        ra.addFlashAttribute("error", "Invalid email or password.");
        return "redirect:/tutor/login";
    }

    @GetMapping("/tutor/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/tutor/login";
    }

    @GetMapping("/tutor/register")
    public String registerPage(Model model) {
        List<Subject> subjects = subjectRepository.findAll();
        model.addAttribute("subjects", subjects);
        model.addAttribute("tutor", new Tutor());
        return "tutor/register";
    }

    @PostMapping("/tutor/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam(required = false) String phone,
                           @RequestParam String subject,
                           @RequestParam(required = false) String qualification,
                           @RequestParam(required = false) String location,
                           @RequestParam BigDecimal hourlyRate,
                           @RequestParam(required = false) String bio,
                           HttpSession session,
                           RedirectAttributes ra) {

        email = email.trim().toLowerCase();

        if (!isValidEmail(email)) {
            ra.addFlashAttribute("error", "Invalid email format.");
            return "redirect:/tutor/register";
        }
        if (tutorService.emailExists(email)) {
            ra.addFlashAttribute("error", "Email already registered.");
            return "redirect:/tutor/register";
        }

        session.setAttribute("pendingName",          name);
        session.setAttribute("pendingEmail",         email);
        session.setAttribute("pendingPassword",      password);
        session.setAttribute("pendingPhone",         phone);
        session.setAttribute("pendingSubject",       subject);
        session.setAttribute("pendingQualification", qualification);
        session.setAttribute("pendingLocation",      location);
        session.setAttribute("pendingHourlyRate",    hourlyRate);
        session.setAttribute("pendingBio",           bio);

        otpService.generateAndSendOtp(email, name);

        ra.addFlashAttribute("success", "Verification code sent to " + email + ". Please check your inbox.");
        return "redirect:/tutor/verify-otp";
    }

    // ── CHANGE PASSWORD (PLAIN TEXT) ──
    @PostMapping("/tutor/profile/changePassword")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("pwError", "New passwords do not match.");
            return "redirect:/tutor/profile";
        }
        if (newPassword.length() < 8) {
            ra.addFlashAttribute("pwError", "New password must be at least 8 characters.");
            return "redirect:/tutor/profile";
        }

        Long id = (Long) session.getAttribute("tutorId");
        boolean changed = tutorService.changePassword(id, currentPassword, newPassword);

        if (changed) {
            ra.addFlashAttribute("pwSuccess", "Password updated successfully.");
        } else {
            ra.addFlashAttribute("pwError", "Current password is incorrect.");
        }
        return "redirect:/tutor/profile";
    }
    @GetMapping("/tutor/verify-otp")
    public String verifyOtpPage(HttpSession session, Model model, RedirectAttributes ra) {
        String pendingEmail = (String) session.getAttribute("pendingEmail");
        if (pendingEmail == null) {
            ra.addFlashAttribute("error", "Please register first.");
            return "redirect:/tutor/register";
        }
        model.addAttribute("email", pendingEmail);
        return "tutor/verify-otp";
    }

    @PostMapping("/tutor/verify-otp")
    public String verifyOtp(@RequestParam String otpCode,
                            HttpSession session,
                            RedirectAttributes ra) {

        String pendingEmail = (String) session.getAttribute("pendingEmail");
        if (pendingEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/tutor/register";
        }

        boolean valid = otpService.validateOtp(pendingEmail, otpCode);
        if (!valid) {
            ra.addFlashAttribute("error", "Invalid or expired verification code. Please try again.");
            return "redirect:/tutor/verify-otp";
        }

        // Build and save tutor
        String     name          = (String)     session.getAttribute("pendingName");
        String     password      = (String)     session.getAttribute("pendingPassword");
        String     phone         = (String)     session.getAttribute("pendingPhone");
        String     subject       = (String)     session.getAttribute("pendingSubject");
        String     qualification = (String)     session.getAttribute("pendingQualification");
        String     location      = (String)     session.getAttribute("pendingLocation");
        BigDecimal hourlyRate    = (BigDecimal) session.getAttribute("pendingHourlyRate");
        String     bio           = (String)     session.getAttribute("pendingBio");

        Tutor tutor = new Tutor(name, pendingEmail, password, phone, subject,
                qualification, location, hourlyRate, bio);
        tutorService.registerTutor(tutor);

        // Clean up the verified OTP record so it doesn't block future registrations
        otpService.deleteOtp(pendingEmail);

        emailService.sendWelcomeEmail(pendingEmail, name);

        session.removeAttribute("pendingName");
        session.removeAttribute("pendingEmail");
        session.removeAttribute("pendingPassword");
        session.removeAttribute("pendingPhone");
        session.removeAttribute("pendingSubject");
        session.removeAttribute("pendingQualification");
        session.removeAttribute("pendingLocation");
        session.removeAttribute("pendingHourlyRate");
        session.removeAttribute("pendingBio");

        ra.addFlashAttribute("success", "Email verified! Registration successful. Please login.");
        return "redirect:/tutor/login";
    }

    @PostMapping("/tutor/resend-otp")
    public String resendOtp(HttpSession session, RedirectAttributes ra) {
        String pendingEmail = (String) session.getAttribute("pendingEmail");
        String pendingName  = (String) session.getAttribute("pendingName");

        if (pendingEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/tutor/register";
        }
        if (!otpService.canResendOtp(pendingEmail)) {
            ra.addFlashAttribute("error", "Please wait before requesting a new code.");
            return "redirect:/tutor/verify-otp";
        }

        otpService.generateAndSendOtp(pendingEmail, pendingName);
        ra.addFlashAttribute("success", "New verification code sent!");
        return "redirect:/tutor/verify-otp";
    }

    // ══════════════════════════════════════════════════════════
    //  TUTOR DASHBOARD
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        model.addAttribute("tutor", tutor);

        List<Booking> allBookings = bookingService.getAllBookings().stream()
                .filter(b -> b.getTutor() != null && b.getTutor().getId().equals(tutorId))
                .collect(Collectors.toList());

        model.addAttribute("totalBookings",   allBookings.size());
        model.addAttribute("pendingCount",    allBookings.stream().filter(b -> b.getStatus() == Booking.Status.PENDING).count());
        model.addAttribute("confirmedCount",  allBookings.stream().filter(b -> b.getStatus() == Booking.Status.CONFIRMED).count());
        model.addAttribute("completedCount",  allBookings.stream().filter(b -> b.getStatus() == Booking.Status.COMPLETED).count());
        model.addAttribute("cancelledCount",  allBookings.stream().filter(b -> b.getStatus() == Booking.Status.CANCELLED).count());

        List<Booking> recentBookings = allBookings.stream()
                .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                .limit(5)
                .collect(Collectors.toList());
        model.addAttribute("recentBookings", recentBookings);
        model.addAttribute("reviews", reviewService.getReviewsByTutor(tutorId));

        return "tutor/dashboard";
    }

    // ══════════════════════════════════════════════════════════
    //  TUTOR PROFILE
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/profile")
    public String profile(HttpSession session, Model model) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";
        Long  tutorId  = getTutorId(session);
        Tutor tutor    = tutorService.getTutorById(tutorId);
        List<Subject> subjects = subjectRepository.findAll();
        model.addAttribute("subjects", subjects);
        model.addAttribute("tutor", tutor);
        return "tutor/profile";
    }

    @PostMapping("/tutor/profile/update")
    public String updateProfile(@RequestParam String name,
                                @RequestParam(required = false) String phone,
                                @RequestParam String subject,
                                @RequestParam(required = false) String qualification,
                                @RequestParam(required = false) String location,
                                @RequestParam BigDecimal hourlyRate,
                                @RequestParam(required = false) String bio,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        if (tutor != null) {
            tutor.setName(name);
            tutor.setPhone(phone);
            tutor.setSubject(subject);
            tutor.setQualification(qualification);
            tutor.setLocation(location);
            tutor.setHourlyRate(hourlyRate);
            tutor.setBio(bio);
            tutorService.updateTutor(tutor);
            session.setAttribute("tutorName", name);
            ra.addFlashAttribute("success", "Profile updated successfully.");
        }
        return "redirect:/tutor/profile";
    }

    @PostMapping("/tutor/profile/delete")
    public String deleteTutorAccount(@RequestParam String confirmPassword,
                                     HttpSession session,
                                     RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);

        if (tutor == null) {
            session.invalidate();
            return "redirect:/tutor/login";
        }
        if (!tutor.getPasswordHash().equals(confirmPassword)) {
            ra.addFlashAttribute("deleteError", "Incorrect password. Account deletion failed.");
            return "redirect:/tutor/profile";
        }

        tutorService.deleteTutor(tutorId);
        session.invalidate();
        ra.addFlashAttribute("success", "Your account and all associated data have been permanently deleted.");
        return "redirect:/tutor/login";
    }

    // ══════════════════════════════════════════════════════════
    //  TUTOR SCHEDULE
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/schedule")
    public String schedulePage(Model model, HttpSession session) {
        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        if (tutor == null) return "redirect:/tutor/login";

        List<Schedule> schedules = scheduleService.getSchedulesByTutor(String.valueOf(tutor.getId()));
        model.addAttribute("schedules", schedules);
        model.addAttribute("tutor", tutor);
        return "tutor/schedule";
    }

    @PostMapping("/tutor/addSchedule")
    public String addSchedule(@RequestParam String availableDate,
                              @RequestParam String timeSlot,
                              HttpSession session,
                              RedirectAttributes ra) {
        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        if (tutor == null) return "redirect:/tutor/login";

        Schedule schedule = new Schedule();
        schedule.setTutorId(String.valueOf(tutor.getId()));
        schedule.setAvailableDate(LocalDate.parse(availableDate));
        schedule.setTimeSlot(timeSlot);

        boolean added = scheduleService.addSchedule(schedule);
        if (!added) {
            ra.addFlashAttribute("error", "This time slot already exists for the selected date.");
            return "redirect:/tutor/schedule";
        }
        return "redirect:/tutor/schedule?added=true";
    }

    @PostMapping("/tutor/deleteSchedule")
    public String deleteSchedule(@RequestParam String scheduleId) {
        scheduleService.deleteSchedule(scheduleId);
        return "redirect:/tutor/schedule?deleted=true";
    }


    // ══════════════════════════════════════════════════════════
    //  TUTOR BOOKINGS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/bookings")
    public String bookings(@RequestParam(required = false) String status,
                           HttpSession session, Model model) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        model.addAttribute("tutor", tutor);

        List<Booking> bookings = bookingService.getAllBookings().stream()
                .filter(b -> b.getTutor() != null && b.getTutor().getId().equals(tutorId))
                .collect(Collectors.toList());

        if (status != null && !status.isEmpty()) {
            try {
                Booking.Status filterStatus = Booking.Status.valueOf(status);
                bookings = bookings.stream()
                        .filter(b -> b.getStatus() == filterStatus)
                        .collect(Collectors.toList());
                model.addAttribute("selectedStatus", status);
            } catch (IllegalArgumentException ignored) { }
        }

        model.addAttribute("bookings", bookings);
        return "booking/tutor_bookings";
    }

    @PostMapping("/tutor/bookings/{id}/accept")
    public String acceptBooking(@PathVariable Long id, HttpSession session, RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/tutor/bookings";
        }
        if (booking.getStatus() != Booking.Status.PENDING) {
            ra.addFlashAttribute("error", "Only pending bookings can be accepted.");
            return "redirect:/tutor/bookings";
        }
        bookingService.updateStatus(id, Booking.Status.CONFIRMED);
        ra.addFlashAttribute("success", "Booking accepted and confirmed.");
        return "redirect:/tutor/bookings";
    }

    @PostMapping("/tutor/bookings/{id}/complete")
    public String completeBooking(@PathVariable Long id, HttpSession session, RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/tutor/bookings";
        }
        if (booking.getStatus() != Booking.Status.CONFIRMED) {
            ra.addFlashAttribute("error", "Only confirmed bookings can be marked as completed.");
            return "redirect:/tutor/bookings";
        }
        bookingService.updateStatus(id, Booking.Status.COMPLETED);
        ra.addFlashAttribute("success", "Booking marked as completed.");
        return "redirect:/tutor/bookings";
    }

    @PostMapping("/tutor/bookings/{id}/cancel")
    public String cancelBooking(@PathVariable Long id, HttpSession session, RedirectAttributes ra) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/tutor/bookings";
        }
        if (booking.getStatus() != Booking.Status.PENDING && booking.getStatus() != Booking.Status.CONFIRMED) {
            ra.addFlashAttribute("error", "Cannot cancel a completed or already cancelled booking.");
            return "redirect:/tutor/bookings";
        }
        bookingService.updateStatus(id, Booking.Status.CANCELLED);
        ra.addFlashAttribute("success", "Booking cancelled successfully.");
        return "redirect:/tutor/bookings";
    }

    // ══════════════════════════════════════════════════════════
    //  TUTOR REVIEWS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/tutor/reviews")
    public String tutorReviews(Model model, HttpSession session) {
        if (!isTutorLoggedIn(session)) return "redirect:/tutor/login";

        Long  tutorId = getTutorId(session);
        Tutor tutor   = tutorService.getTutorById(tutorId);
        if (tutor == null) return "redirect:/tutor/login";

        List<Review> reviews = reviewService.getReviewsByTutor(tutorId);

        int[] ratingCounts = new int[6];
        for (Review r : reviews) {
            if (r.getRating() != null && r.getRating() >= 1 && r.getRating() <= 5) {
                ratingCounts[r.getRating()]++;
            }
        }

        model.addAttribute("tutor",        tutor);
        model.addAttribute("reviews",      reviews);
        model.addAttribute("ratingCounts", ratingCounts);
        model.addAttribute("reviewCount",  reviews.size());
        return "review/tutor_reviews";
    }

    // ══════════════════════════════════════════════════════════
    //  ADMIN — TUTOR MANAGEMENT  (/admin/tutors/...)
    // ══════════════════════════════════════════════════════════

    @GetMapping("/admin/tutors")
    public String adminListTutors(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("tutors", tutorService.getAllTutors());
        return "tutor/tutors";
    }

    @PostMapping("/admin/tutors/{id}/verify")
    public String adminVerifyTutor(@PathVariable Long id,
                                   HttpSession session,
                                   RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        var t = tutorService.verifyTutor(id);
        if (t != null) ra.addFlashAttribute("success", t.getName() + " has been verified.");
        else           ra.addFlashAttribute("error",   "Tutor not found.");
        return "redirect:/admin/tutors";
    }

    @PostMapping("/admin/tutors/{id}/delete")
    public String adminDeleteTutor(@PathVariable Long id,
                                   HttpSession session,
                                   RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        try {
            tutorService.deleteTutor(id);
            ra.addFlashAttribute("success", "Tutor deleted successfully.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete tutor: They may have active bookings or reviews.");
        }
        return "redirect:/admin/tutors";
    }

    // ── private helper ───────────────────────────────────────

    private boolean isValidEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email != null && email.matches(regex);
    }
}