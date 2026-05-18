package com.tutorbooking.tutor_booking_system.util;

import java.util.UUID;

public class IDGenerator {

    public static String generateScheduleID() {
        return "SCH-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    public static String generateBookingID() {
        return "BKG-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    public static String generateReviewID() {
        return "REV-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}