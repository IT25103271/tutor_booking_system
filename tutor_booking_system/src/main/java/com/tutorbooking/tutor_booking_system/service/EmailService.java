package com.tutorbooking.tutor_booking_system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Async
    public void sendOtpEmail(String toEmail, String otpCode, String name) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setSubject("TutorBooking - Email Verification Code");

        String emailBody = String.format(
                "Hello %s,\n\n" +
                        "Thank you for registering with TutorBooking!\n\n" +
                        "Your verification code is: %s\n\n" +
                        "This code will expire in 10 minutes.\n" +
                        "If you didn't request this, please ignore this email.\n\n" +
                        "Best regards,\nTutorBooking Team",
                name, otpCode
        );

        message.setText(emailBody);
        mailSender.send(message);
    }

    @Async
    public void sendWelcomeEmail(String toEmail, String name) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setSubject("Welcome to TutorBooking!");

        String emailBody = String.format(
                "Hello %s,\n\n" +
                        "Your email has been verified successfully!\n" +
                        "You can now log in and start managing your tutoring profile.\n\n" +
                        "Welcome aboard!\n\n" +
                        "Best regards,\nTutorBooking Team",
                name
        );

        message.setText(emailBody);
        mailSender.send(message);
    }

    @Async
    public void sendPasswordResetEmail(String toEmail, String otpCode, String name) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setSubject("TutorBooking - Password Reset Code");

        String emailBody = String.format(
                "Hello %s,\n\n" +
                        "You requested a password reset for your TutorBooking account.\n\n" +
                        "Your password reset code is: %s\n\n" +
                        "This code will expire in 5 minutes.\n" +
                        "If you didn't request this, please ignore this email and secure your account.\n\n" +
                        "Best regards,\nTutorBooking Team",
                name, otpCode
        );

        message.setText(emailBody);
        mailSender.send(message);
    }

    @Async
    public void sendPasswordChangedConfirmation(String toEmail, String name) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setSubject("TutorBooking - Password Changed Successfully");

        String emailBody = String.format(
                "Hello %s,\n\n" +
                        "Your TutorBooking password has been successfully changed.\n\n" +
                        "If you didn't make this change, please contact support immediately.\n\n" +
                        "Best regards,\nTutorBooking Team",
                name
        );

        message.setText(emailBody);
        mailSender.send(message);
    }
}