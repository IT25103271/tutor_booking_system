package com.tutorbooking.tutor_booking_system.model;

public class Schedule {
    private String scheduleId;
    private String tutorId;
    private String availableDate;
    private String timeSlot;

    public Schedule() {}

    public Schedule(String scheduleId, String tutorId, String availableDate, String timeSlot) {
        this.scheduleId = scheduleId;
        this.tutorId = tutorId;
        this.availableDate = availableDate;
        this.timeSlot = timeSlot;
    }

    // Getters and Setters
    public String getScheduleId() { return scheduleId; }
    public void setScheduleId(String scheduleId) { this.scheduleId = scheduleId; }

    public String getTutorId() { return tutorId; }
    public void setTutorId(String tutorId) { this.tutorId = tutorId; }

    public String getAvailableDate() { return availableDate; }
    public void setAvailableDate(String availableDate) { this.availableDate = availableDate; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }

    @Override
    public String toString() {
        return scheduleId + "|" + tutorId + "|" + availableDate + "|" + timeSlot;
    }

    public static Schedule fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length < 4) return null;
        return new Schedule(parts[0], parts[1], parts[2], parts[3]);
    }
}
