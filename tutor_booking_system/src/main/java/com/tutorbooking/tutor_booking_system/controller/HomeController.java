package com.tutorbooking.tutor_booking_system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        // Redirect to student login by default or a landing page
        return "redirect:/student/login";
    }
}
