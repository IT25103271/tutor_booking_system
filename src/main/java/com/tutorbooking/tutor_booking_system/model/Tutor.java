package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "tutors")
public class Tutor extends User {
    private String subject;
    private double ratePerHour;
    private String availability;

    public Tutor() {
        super();
        this.setRole("TUTOR");
    }

    public Tutor(String name, String email, String phone, String password, String subject, double ratePerHour, String availability) {
        super(name, email, phone, password, "TUTOR");
        this.subject = subject;
        this.ratePerHour = ratePerHour;
        this.availability = availability;
    }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public double getRatePerHour() { return ratePerHour; }
    public void setRatePerHour(double ratePerHour) { this.ratePerHour = ratePerHour; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
}
