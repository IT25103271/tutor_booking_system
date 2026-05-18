package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.OtpVerification;
import com.tutorbooking.tutor_booking_system.repository.OtpVerificationRepository;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class OtpService {

    @Autowired
    private OtpVerificationRepository otpRepository;

    @Autowired
    private EmailService emailService;

    @Value("${app.otp.expiry-minutes:10}")
    private int otpExpiryMinutes;

    @Value("${app.otp.length:6}")
    private int otpLength;

    @Transactional
    public String generateAndSendOtp(String email, String name) {
        // Delete ALL existing OTP records for this email first
        otpRepository.deleteAllByEmail(email);

        String otpCode = RandomStringUtils.randomNumeric(otpLength);
        OtpVerification otp = new OtpVerification(email, otpCode, otpExpiryMinutes);
        otpRepository.save(otp);
        emailService.sendOtpEmail(email, otpCode, name);
        return otpCode;
    }

    @Transactional
    public String generateAndSendPasswordResetOtp(String email, String name) {
        // Delete ALL existing OTP records for this email first
        otpRepository.deleteAllByEmail(email);

        String otpCode = RandomStringUtils.randomNumeric(otpLength);
        // Shorter expiry for password reset: 5 minutes
        OtpVerification otp = new OtpVerification(email, otpCode, 5);
        otpRepository.save(otp);
        emailService.sendPasswordResetEmail(email, otpCode, name);
        return otpCode;
    }

    @Transactional
    public boolean validateOtp(String email, String otpCode) {
        Optional<OtpVerification> otpOpt = otpRepository.findByEmail(email);

        if (otpOpt.isEmpty()) return false;

        OtpVerification otp = otpOpt.get();
        if (otp.isVerified()) return false;
        if (otp.isExpired()) return false;
        if (!otp.canRetry()) return false;

        otp.incrementAttempts();
        otpRepository.save(otp);

        if (!otp.getOtpCode().equals(otpCode)) return false;

        otp.setVerified(true);
        otpRepository.save(otp);
        return true;
    }

    public boolean isEmailVerified(String email) {
        return otpRepository.existsByEmailAndVerifiedTrue(email);
    }

    @Transactional
    public void cleanupExpiredOtps() {
        otpRepository.deleteByExpiryTimeBefore(LocalDateTime.now());
    }

    public boolean canResendOtp(String email) {
        Optional<OtpVerification> otpOpt = otpRepository.findByEmail(email);
        if (otpOpt.isEmpty()) return true;
        OtpVerification otp = otpOpt.get();
        return otp.isExpired() || otp.getCreatedAt().plusSeconds(60).isBefore(LocalDateTime.now());
    }
}