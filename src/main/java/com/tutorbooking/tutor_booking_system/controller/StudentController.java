package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.repository.SubjectRepository;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import com.tutorbooking.tutor_booking_system.service.BookingService;
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

    @Autowired
    private BookingService bookingService;

    @Autowired
    private TutorRepository tutorRepository;

    @Autowired
    private SubjectRepository subjectRepository;

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
        
        // Handle Last Login
        if (student.getLastLogin() != null) {
            session.setAttribute("lastLoginTime", student.getLastLogin());
        }
        student.setLastLogin(java.time.LocalDateTime.now());
        studentService.updateStudent(student);
        
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
        
        model.addAttribute("confirmedCount", bookingService.getBookingCountByStatus(student, "Confirmed"));
        model.addAttribute("pendingCount", bookingService.getBookingCountByStatus(student, "Pending"));
        model.addAttribute("cancelledCount", bookingService.getBookingCountByStatus(student, "Cancelled"));
        
        return "student/dashboard";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) {
            return "redirect:/student/login";
        }
        Student student = studentService.getStudentById(studentId);
        model.addAttribute("student", student);
        
        model.addAttribute("confirmedCount", bookingService.getBookingCountByStatus(student, "Confirmed"));
        model.addAttribute("pendingCount", bookingService.getBookingCountByStatus(student, "Pending"));
        model.addAttribute("cancelledCount", bookingService.getBookingCountByStatus(student, "Cancelled"));
        
        return "student/profile";
    }

    @GetMapping("/edit-profile")
    public String editProfilePage(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) {
            return "redirect:/student/login";
        }
        Student student = studentService.getStudentById(studentId);
        model.addAttribute("student", student);
        return "student/edit-profile";
    }

    @PostMapping("/edit-profile")
    public String updateProfile(@ModelAttribute Student student, HttpSession session, RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) {
            return "redirect:/student/login";
        }
        student.setId(studentId); // Ensure the ID is set correctly
        studentService.updateStudent(student);
        session.setAttribute("studentName", student.getName());
        ra.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/student/profile";
    }

    @GetMapping("/view-tutors")
    public String viewTutors(Model model, HttpSession session) {
        if (session.getAttribute("studentId") == null) return "redirect:/student/login";
        model.addAttribute("tutors", tutorRepository.findAll());
        return "student/view-tutors";
    }

    @GetMapping("/my-bookings")
    public String myBookings(Model model, HttpSession session) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";
        Student student = studentService.getStudentById(studentId);
        model.addAttribute("bookings", bookingService.getBookingsByStudentAndStatus(student, "Confirmed"));
        return "student/my-bookings";
    }

    @GetMapping("/view-subjects")
    public String viewSubjects(Model model, HttpSession session) {
        if (session.getAttribute("studentId") == null) return "redirect:/student/login";
        model.addAttribute("subjects", subjectRepository.findAll());
        return "student/view-subjects";
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

    @GetMapping("/book-tutor")
    public String bookTutor(@RequestParam Long id, HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) {
            return "redirect:/student/login";
        }
        Tutor tutor = tutorRepository.findById(id).orElse(null);
        model.addAttribute("tutor", tutor);
        return "student/book-tutor";
    }
}
