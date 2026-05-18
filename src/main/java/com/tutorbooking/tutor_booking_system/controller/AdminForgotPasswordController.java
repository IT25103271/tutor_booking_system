package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Admin;
import com.tutorbooking.tutor_booking_system.service.AdminService;
import com.tutorbooking.tutor_booking_system.service.EmailService;
import com.tutorbooking.tutor_booking_system.service.OtpService;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminForgotPasswordController {

    private static final Logger logger = LoggerFactory.getLogger(AdminForgotPasswordController.class);

    @Autowired
    private AdminService adminService;

    @Autowired
    private OtpService otpService;

    @Autowired
    private EmailService emailService;

    // STEP 1: Enter email
    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        logger.info("GET /admin/forgot-password");
        return "admin/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String sendResetOtp(@RequestParam String email,
                               HttpSession session,
                               RedirectAttributes ra) {

        logger.info("POST /admin/forgot-password - email: {}", email);
        email = email.trim().toLowerCase();

        Admin admin = adminService.getAdminByEmail(email);
        if (admin == null) {
            logger.warn("Admin not found for email: {}", email);
            ra.addFlashAttribute("success", "If this email is registered, a reset code has been sent.");
            return "redirect:/admin/forgot-password";
        }

        logger.info("Admin found: {}, sending OTP", admin.getName());

        try {
            String otpCode = otpService.generateAndSendPasswordResetOtp(email, admin.getName());
            logger.info("OTP sent successfully to: {}, code: {}", email, otpCode);
        } catch (Exception e) {
            logger.error("Failed to send OTP to: {}", email, e);
            ra.addFlashAttribute("error", "Failed to send OTP. Please try again.");
            return "redirect:/admin/forgot-password";
        }

        session.setAttribute("adminResetEmail", email);
        session.setAttribute("adminResetName", admin.getName());

        logger.info("Session set - adminResetEmail: {}", session.getAttribute("adminResetEmail"));
        logger.info("Redirecting to /admin/verify-reset-otp");

        ra.addFlashAttribute("success", "Reset code sent to " + email + ". Please check your inbox.");
        return "redirect:/admin/verify-reset-otp";
    }

    // STEP 2: Verify OTP
    @GetMapping("/verify-reset-otp")
    public String verifyResetOtpPage(HttpSession session, Model model, RedirectAttributes ra) {
        logger.info("GET /admin/verify-reset-otp");
        logger.info("Session ID: {}", session.getId());
        logger.info("Session adminResetEmail: {}", session.getAttribute("adminResetEmail"));

        String resetEmail = (String) session.getAttribute("adminResetEmail");
        if (resetEmail == null) {
            logger.warn("No adminResetEmail in session!");
            ra.addFlashAttribute("error", "Please start the password reset process first.");
            return "redirect:/admin/forgot-password";
        }

        model.addAttribute("email", resetEmail);
        logger.info("Returning view: admin/verify-reset-otp for email: {}", resetEmail);
        return "admin/verify-reset-otp";
    }

    @PostMapping("/verify-reset-otp")
    public String verifyResetOtp(@RequestParam String otpCode,
                                 HttpSession session,
                                 RedirectAttributes ra) {

        logger.info("POST /admin/verify-reset-otp - code: {}", otpCode);
        String resetEmail = (String) session.getAttribute("adminResetEmail");
        if (resetEmail == null) {
            logger.warn("Session expired - no adminResetEmail found");
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/admin/forgot-password";
        }

        boolean valid = otpService.validateOtp(resetEmail, otpCode);
        logger.info("OTP validation result: {}", valid);

        if (!valid) {
            ra.addFlashAttribute("error", "Invalid or expired verification code.");
            return "redirect:/admin/verify-reset-otp";
        }

        session.setAttribute("adminOtpVerified", true);
        logger.info("OTP verified, redirecting to reset-password");
        ra.addFlashAttribute("success", "Code verified! Enter your new password.");
        return "redirect:/admin/reset-password";
    }

    @PostMapping("/resend-reset-otp")
    public String resendResetOtp(HttpSession session, RedirectAttributes ra) {
        logger.info("POST /admin/resend-reset-otp");
        String resetEmail = (String) session.getAttribute("adminResetEmail");
        String resetName = (String) session.getAttribute("adminResetName");

        if (resetEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/admin/forgot-password";
        }

        if (!otpService.canResendOtp(resetEmail)) {
            ra.addFlashAttribute("error", "Please wait before requesting a new code.");
            return "redirect:/admin/verify-reset-otp";
        }

        otpService.generateAndSendPasswordResetOtp(resetEmail, resetName);
        ra.addFlashAttribute("success", "New reset code sent!");
        return "redirect:/admin/verify-reset-otp";
    }

    // STEP 3: Reset password
    @GetMapping("/reset-password")
    public String resetPasswordPage(HttpSession session, RedirectAttributes ra) {
        logger.info("GET /admin/reset-password");
        String resetEmail = (String) session.getAttribute("adminResetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("adminOtpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            logger.warn("Unauthorized access to reset-password");
            ra.addFlashAttribute("error", "Unauthorized access. Please verify your email first.");
            return "redirect:/admin/forgot-password";
        }
        return "admin/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes ra) {

        logger.info("POST /admin/reset-password");
        String resetEmail = (String) session.getAttribute("adminResetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("adminOtpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/admin/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("error", "Passwords do not match.");
            return "redirect:/admin/reset-password";
        }

        if (newPassword.length() < 8) {
            ra.addFlashAttribute("error", "Password must be at least 8 characters.");
            return "redirect:/admin/reset-password";
        }

        Admin admin = adminService.getAdminByEmail(resetEmail);
        if (admin == null) {
            ra.addFlashAttribute("error", "Admin not found.");
            return "redirect:/admin/forgot-password";
        }

        admin.setPassword(newPassword);
        adminService.updateAdmin(admin);

        String adminName = (String) session.getAttribute("adminResetName");
        emailService.sendPasswordChangedConfirmation(resetEmail, adminName);

        // Clean up OTP record
        otpService.deleteOtp(resetEmail);

        session.removeAttribute("adminResetEmail");
        session.removeAttribute("adminResetName");
        session.removeAttribute("adminOtpVerified");

        ra.addFlashAttribute("success", "Password reset successfully! Please login with your new password.");
        return "redirect:/admin/login";
    }
}