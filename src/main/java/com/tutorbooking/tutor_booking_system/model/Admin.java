package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.*;

@Entity
@Table(name = "admins")
public class Admin extends User {

    public Admin(String name, String email, String password, String phone, String role) {
        super(name, email, phone, password, role);
    }

    public Admin() {
        super();
        this.setRole("ADMIN");
    }
}
