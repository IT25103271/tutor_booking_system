package com.tutorbooking.tutor_booking_system.scheduler;

import com.tutorbooking.tutor_booking_system.service.OtpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class OtpCleanupTask {

    @Autowired
    private OtpService otpService;

    // Run every hour to clean expired OTPs
    @Scheduled(fixedRate = 3600000)
    public void cleanupExpiredOtps() {
        otpService.cleanupExpiredOtps();
    }
}