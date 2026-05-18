package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.service.EmailService;
import com.tutorbooking.tutor_booking_system.service.OtpService;
import com.tutorbooking.tutor_booking_system.service.StudentService;
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
@RequestMapping("/student")
public class StudentForgotPasswordController {

    private static final Logger logger = LoggerFactory.getLogger(StudentForgotPasswordController.class);

    @Autowired
    private StudentService studentService;

    @Autowired
    private OtpService otpService;

    @Autowired
    private EmailService emailService;

    // STEP 1: Enter email
    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        logger.info("GET /student/forgot-password");
        return "student/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String sendResetOtp(@RequestParam String email,
                               HttpSession session,
                               RedirectAttributes ra) {

        logger.info("POST /student/forgot-password - email: {}", email);
        email = email.trim().toLowerCase();

        Student student = studentService.getStudentByEmail(email);
        if (student == null) {
            logger.warn("Student not found for email: {}", email);
            ra.addFlashAttribute("success", "If this email is registered, a reset code has been sent.");
            return "redirect:/student/forgot-password";
        }

        logger.info("Student found: {}, sending OTP", student.getName());

        try {
            String otpCode = otpService.generateAndSendPasswordResetOtp(email, student.getName());
            logger.info("OTP sent successfully to: {}, code: {}", email, otpCode);
        } catch (Exception e) {
            logger.error("Failed to send OTP to: {}", email, e);
            ra.addFlashAttribute("error", "Failed to send OTP. Please try again.");
            return "redirect:/student/forgot-password";
        }

        session.setAttribute("studentResetEmail", email);
        session.setAttribute("studentResetName", student.getName());

        logger.info("Session set - studentResetEmail: {}", session.getAttribute("studentResetEmail"));
        logger.info("Redirecting to /student/verify-reset-otp");

        ra.addFlashAttribute("success", "Reset code sent to " + email + ". Please check your inbox.");
        return "redirect:/student/verify-reset-otp";
    }

    // STEP 2: Verify OTP
    @GetMapping("/verify-reset-otp")
    public String verifyResetOtpPage(HttpSession session, Model model, RedirectAttributes ra) {
        logger.info("GET /student/verify-reset-otp");
        logger.info("Session ID: {}", session.getId());
        logger.info("Session studentResetEmail: {}", session.getAttribute("studentResetEmail"));

        String resetEmail = (String) session.getAttribute("studentResetEmail");
        if (resetEmail == null) {
            logger.warn("No studentResetEmail in session!");
            ra.addFlashAttribute("error", "Please start the password reset process first.");
            return "redirect:/student/forgot-password";
        }

        model.addAttribute("email", resetEmail);
        logger.info("Returning view: student/verify-reset-otp for email: {}", resetEmail);
        return "student/verify-reset-otp";
    }

    @PostMapping("/verify-reset-otp")
    public String verifyResetOtp(@RequestParam String otpCode,
                                 HttpSession session,
                                 RedirectAttributes ra) {

        logger.info("POST /student/verify-reset-otp - code: {}", otpCode);
        String resetEmail = (String) session.getAttribute("studentResetEmail");
        if (resetEmail == null) {
            logger.warn("Session expired - no studentResetEmail found");
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/student/forgot-password";
        }

        boolean valid = otpService.validateOtp(resetEmail, otpCode);
        logger.info("OTP validation result: {}", valid);

        if (!valid) {
            ra.addFlashAttribute("error", "Invalid or expired verification code.");
            return "redirect:/student/verify-reset-otp";
        }

        session.setAttribute("studentOtpVerified", true);
        logger.info("OTP verified, redirecting to reset-password");
        ra.addFlashAttribute("success", "Code verified! Enter your new password.");
        return "redirect:/student/reset-password";
    }

    @PostMapping("/resend-reset-otp")
    public String resendResetOtp(HttpSession session, RedirectAttributes ra) {
        logger.info("POST /student/resend-reset-otp");
        String resetEmail = (String) session.getAttribute("studentResetEmail");
        String resetName = (String) session.getAttribute("studentResetName");

        if (resetEmail == null) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/student/forgot-password";
        }

        if (!otpService.canResendOtp(resetEmail)) {
            ra.addFlashAttribute("error", "Please wait before requesting a new code.");
            return "redirect:/student/verify-reset-otp";
        }

        otpService.generateAndSendPasswordResetOtp(resetEmail, resetName);
        ra.addFlashAttribute("success", "New reset code sent!");
        return "redirect:/student/verify-reset-otp";
    }

    // STEP 3: Reset password
    @GetMapping("/reset-password")
    public String resetPasswordPage(HttpSession session, RedirectAttributes ra) {
        logger.info("GET /student/reset-password");
        String resetEmail = (String) session.getAttribute("studentResetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("studentOtpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            logger.warn("Unauthorized access to reset-password");
            ra.addFlashAttribute("error", "Unauthorized access. Please verify your email first.");
            return "redirect:/student/forgot-password";
        }
        return "student/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes ra) {

        logger.info("POST /student/reset-password");
        String resetEmail = (String) session.getAttribute("studentResetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("studentOtpVerified");

        if (resetEmail == null || otpVerified == null || !otpVerified) {
            ra.addFlashAttribute("error", "Session expired. Please start again.");
            return "redirect:/student/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("error", "Passwords do not match.");
            return "redirect:/student/reset-password";
        }

        if (newPassword.length() < 8) {
            ra.addFlashAttribute("error", "Password must be at least 8 characters.");
            return "redirect:/student/reset-password";
        }

        Student student = studentService.getStudentByEmail(resetEmail);
        if (student == null) {
            ra.addFlashAttribute("error", "Student not found.");
            return "redirect:/student/forgot-password";
        }

        student.setPassword(newPassword);
        studentService.updateStudent(student);

        String studentName = (String) session.getAttribute("studentResetName");
        emailService.sendPasswordChangedConfirmation(resetEmail, studentName);

        session.removeAttribute("studentResetEmail");
        session.removeAttribute("studentResetName");
        session.removeAttribute("studentOtpVerified");

        ra.addFlashAttribute("success", "Password reset successfully! Please login with your new password.");
        return "redirect:/student/login";
    }
}