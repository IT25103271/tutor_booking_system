package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "students")
public class Student extends User {
    private String address;

    public Student() {
        super();
        this.setRole("STUDENT");
    }

    public Student(String name, String email, String phone, String password, String address) {
        super(name, email, phone, password, "STUDENT");
        this.address = address;
    }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}