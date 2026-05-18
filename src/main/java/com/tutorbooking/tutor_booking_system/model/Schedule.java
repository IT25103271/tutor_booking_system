package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.time.LocalDate;

@Entity
public class Schedule {
    @Id
    private String scheduleId;

    private String tutorId;

    private LocalDate availableDate;  // Changed from String to LocalDate

    private String timeSlot;

    public Schedule() {}

    public Schedule(String scheduleId, String tutorId, LocalDate availableDate, String timeSlot) {
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

    public LocalDate getAvailableDate() { return availableDate; }
    public void setAvailableDate(LocalDate availableDate) { this.availableDate = availableDate; }

    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
}