package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.model.Schedule;
import com.tutorbooking.tutor_booking_system.service.TutorService;
import com.tutorbooking.tutor_booking_system.service.ScheduleService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class TutorController {

    private final TutorService tutorService;
    private final ScheduleService scheduleService;

    @Autowired
    public TutorController(TutorService tutorService, ScheduleService scheduleService) {
        this.tutorService = tutorService;
        this.scheduleService = scheduleService;
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    // --- Authentication ---

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        return tutorService.login(email, password)
                .map(tutor -> {
                    session.setAttribute("loggedInTutor", tutor);
                    return "redirect:/tutor/dashboard";
                })
                .orElseGet(() -> {
                    model.addAttribute("error", "Invalid email or password");
                    return "login";
                });
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Tutor tutor, @RequestParam String confirmPassword, Model model) {
        if (!tutor.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }

        if (tutorService.registerTutor(tutor)) {
            return "redirect:/login?registered=true";
        } else {
            model.addAttribute("error", "Email already exists");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // --- Dashboard & Profile ---

    @GetMapping("/tutor/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor == null) return "redirect:/login";

        // Refresh tutor data from "db"
        tutor = tutorService.getTutorById(tutor.getTutorId());
        session.setAttribute("loggedInTutor", tutor);

        List<Schedule> schedules = scheduleService.getSchedulesByTutor(tutor.getTutorId());
        model.addAttribute("tutor", tutor);
        model.addAttribute("schedules", schedules);
        return "tutor/dashboard";
    }

    @GetMapping("/tutor/profile")
    public String showProfile(HttpSession session, Model model) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor == null) return "redirect:/login";
        
        model.addAttribute("tutor", tutorService.getTutorById(tutor.getTutorId()));
        return "tutor/profile";
    }

    @GetMapping("/tutor/editProfile")
    public String showEditProfile(HttpSession session, Model model) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor == null) return "redirect:/login";

        model.addAttribute("tutor", tutorService.getTutorById(tutor.getTutorId()));
        return "tutor/editProfile";
    }

    @PostMapping("/tutor/updateProfile")
    public String updateProfile(@ModelAttribute Tutor tutor, HttpSession session) {
        Tutor loggedInTutor = (Tutor) session.getAttribute("loggedInTutor");
        if (loggedInTutor == null) return "redirect:/login";

        tutor.setTutorId(loggedInTutor.getTutorId());
        tutor.setEmail(loggedInTutor.getEmail()); // Email cannot be changed for simplicity
        
        tutorService.updateTutorProfile(tutor);
        session.setAttribute("loggedInTutor", tutor);
        return "redirect:/tutor/profile?updated=true";
    }

    // --- Schedule Management ---

    @GetMapping("/tutor/schedule")
    public String showSchedule(HttpSession session, Model model) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor == null) return "redirect:/login";

        model.addAttribute("schedules", scheduleService.getSchedulesByTutor(tutor.getTutorId()));
        return "tutor/schedule";
    }

    @PostMapping("/tutor/addSchedule")
    public String addSchedule(@ModelAttribute Schedule schedule, HttpSession session, Model model) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor == null) return "redirect:/login";

        schedule.setTutor(tutor);
        if (scheduleService.addSchedule(schedule)) {
            return "redirect:/tutor/schedule?added=true";
        } else {
            model.addAttribute("error", "Time slot already exists");
            model.addAttribute("schedules", scheduleService.getSchedulesByTutor(tutor.getTutorId()));
            return "tutor/schedule";
        }
    }

    @PostMapping("/tutor/deleteSchedule")
    public String deleteSchedule(@RequestParam String scheduleId, HttpSession session) {
        if (session.getAttribute("loggedInTutor") == null) return "redirect:/login";
        scheduleService.deleteSchedule(scheduleId);
        return "redirect:/tutor/schedule?deleted=true";
    }

    // --- Settings ---

    @GetMapping("/tutor/settings")
    public String showSettings(HttpSession session) {
        if (session.getAttribute("loggedInTutor") == null) return "redirect:/login";
        return "tutor/settings";
    }

    @PostMapping("/tutor/deleteAccount")
    public String deleteAccount(HttpSession session) {
        Tutor tutor = (Tutor) session.getAttribute("loggedInTutor");
        if (tutor != null) {
            tutorService.deleteTutorAccount(tutor.getTutorId());
            session.invalidate();
        }
        return "redirect:/login?deleted=true";
    }
}
