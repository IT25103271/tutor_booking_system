package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.service.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @GetMapping("/register")
    public String registerPage() {
        return "student/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Student student, RedirectAttributes ra) {
        if (studentService.emailExists(student.getEmail())) {
            ra.addFlashAttribute("error", "Email already registered!");
            return "redirect:/student/register";
        }
        studentService.registerStudent(student);
        ra.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/student/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "student/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, RedirectAttributes ra) {
        Student student = studentService.loginStudent(email, password);
        if (student == null) {
            ra.addFlashAttribute("error", "Invalid email or password.");
            return "redirect:/student/login";
        }
        session.setAttribute("studentId", student.getId());
        session.setAttribute("studentName", student.getName());
        return "redirect:/student/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) {
            return "redirect:/student/login";
        }
        Student student = studentService.getStudentById(studentId);
        model.addAttribute("student", student);
        return "student/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/student/login";
    }

    @PostMapping("/delete")
    public String deleteAccount(HttpSession session, RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId != null) {
            studentService.deleteStudent(studentId);
            session.invalidate();
            ra.addFlashAttribute("success", "Account deleted successfully.");
        }
        return "redirect:/student/login";
    }
}
