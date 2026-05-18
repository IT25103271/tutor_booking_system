package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.service.EmailService;
import com.tutorbooking.tutor_booking_system.service.OtpService;
import com.tutorbooking.tutor_booking_system.service.TutorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/tutor")
public class ForgotPasswordController {

    @Autowired
    private TutorService tutorService;

    @Autowired
    private OtpService otpService;

    @Autowired
    private EmailService emailService;

    // ══════════════════════════════════════════════════════════
    //  STEP 1: ENTER EMAIL
    // ══════════════════════════════════════════════════════════

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "tutor/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String sendResetOtp(@RequestParam String email,
                               HttpSession session,
                               RedirectAttributes ra) {

        // Normalize email
        email = email.trim().toLowerCase();

        // Check if email exists
        Tutor tutor = tutorService.getTutorByEmail(email);
        if (tutor == null) {
            // Don't reveal if email exists or not (security)
            ra.addFlashAttribute("success", "If this email is registered, a reset code has been sent.");
            return "redirect:/tutor/forgot-password";
        }

        // Generate and send OTP
        otpService.generateAndSendPasswordResetOtp(email, tutor.getName());

        // Store email in session for next steps
        session.setAttribute("resetEmail", email);
        session.setAttribute("resetTutorName", tutor.getName());

        ra.addFlashAttribute("success", "Reset code sent to " + email);
        return "redirect:/tutor/verify-reset-otp";
    }

    // ══════════════════════════════════════════════════════════
    //  STEP 2: VERIFY OTP
    // ══════════════════════════════════════════════════════════

    @GetMapping("/verify-reset-otp")
    public String verifyResetOtpPage(HttpSession session, Model model, RedirectAttributes ra) {
        String resetEmail = (String) session.getAttribute("resetEmail");

        if (resetEmail == null) {
            ra.addFlashAttribute("error", "Please start the password reset process first.");
            return "redirect:/tutor/forgot-password";
        }

        model.addAttribute("email", resetEmail);
        return "tutor/verify-reset-otp";
    }

    @PostMapping("/verify-reset-otp")
    public String verifyResetOtp(@RequestParam String otpCode,
                                 HttpSession session,
                                 RedirectAttributes ra) {

        String resetEmail = (String) session.getAttribute("resetEmail");

        if (resetEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/tutor/forgot-password";
        }

        boolean valid = otpService.validateOtp(resetEmail, otpCode);

        if (!valid) {
            ra.addFlashAttribute("error", "Invalid or expired verification code.");
            return "redirect:/tutor/verify-reset-otp";
        }

        // OTP verified - allow password reset
        session.setAttribute("otpVerified", true);
        ra.addFlashAttribute("success", "Code verified! Enter your new password.");
        return "redirect:/tutor/reset-password";
    }

    @PostMapping("/resend-reset-otp")
    public String resendResetOtp(HttpSession session, RedirectAttributes ra) {
        String resetEmail = (String) session.getAttribute("resetEmail");
        String resetTutorName = (String) session.getAttribute("resetTutorName");

        if (resetEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/tutor/forgot-password";
        }

        if (!otpService.canResendOtp(resetEmail)) {
            ra.addFlashAttribute("error", "Please wait before requesting a new code.");
            return "redirect:/tutor/verify-reset-otp";
        }

        otpService.generateAndSendPasswordResetOtp(resetEmail, resetTutorName);
        ra.addFlashAttribute("success", "New reset code sent!");
        return "redirect:/tutor/verify-reset-otp";
    }

    // ══════════════════════════════════════════════════════════
    //  STEP 3: RESET PASSWORD
    // ══════════════════════════════════════════════════════════

    @GetMapping("/reset-password")
    public String resetPasswordPage(HttpSession session, RedirectAttributes ra) {
        String resetEmail = (String) session.getAttribute("resetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            ra.addFlashAttribute("error", "Unauthorized access. Please verify your email first.");
            return "redirect:/tutor/forgot-password";
        }

        return "tutor/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes ra) {

        String resetEmail = (String) session.getAttribute("resetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/tutor/forgot-password";
        }

        // Validate passwords match
        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("error", "Passwords do not match.");
            return "redirect:/tutor/reset-password";
        }

        // Validate password length
        if (newPassword.length() < 8) {
            ra.addFlashAttribute("error", "Password must be at least 8 characters.");
            return "redirect:/tutor/reset-password";
        }

        // Update password
        boolean updated = tutorService.resetPassword(resetEmail, newPassword);

        if (!updated) {
            ra.addFlashAttribute("error", "Failed to reset password. Please try again.");
            return "redirect:/tutor/reset-password";
        }

        // Send confirmation email
        String tutorName = (String) session.getAttribute("resetTutorName");
        emailService.sendPasswordChangedConfirmation(resetEmail, tutorName);

        // Clear session
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetTutorName");
        session.removeAttribute("otpVerified");

        ra.addFlashAttribute("success", "Password reset successfully! Please login with your new password.");
        return "redirect:/tutor/login";
    }
}