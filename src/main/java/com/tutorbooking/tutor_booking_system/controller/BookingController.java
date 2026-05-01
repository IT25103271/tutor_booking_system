package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.service.BookingService;
import com.tutorbooking.tutor_booking_system.service.StudentService;
import com.tutorbooking.tutor_booking_system.service.TutorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/student")
public class BookingController {

    @Autowired
    private BookingService bookingService;
    @Autowired
    private TutorService tutorService;
    @Autowired
    private StudentService studentService;

    @GetMapping("/view-tutors")
    public String viewTutors(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) return "redirect:/student/login";
        model.addAttribute("tutors", tutorService.getAllTutors());
        return "student/view-tutors";
    }

    @GetMapping("/book/{tutorId}")
    public String bookPage(@PathVariable Long tutorId, HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";
        
        Student student = studentService.getStudentById(studentId);
        Tutor tutor = tutorService.getTutorById(tutorId);
        
        model.addAttribute("student", student);
        model.addAttribute("tutor", tutor);
        return "student/book-tutor";
    }

    @PostMapping("/book")
    public String bookTutor(@RequestParam Long tutorId, @RequestParam String date, 
                           @RequestParam String timeSlot, @RequestParam String subject, 
                           @RequestParam String notes, HttpSession session, RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student student = studentService.getStudentById(studentId);
        Tutor tutor = tutorService.getTutorById(tutorId);

        Booking booking = new Booking(student, tutor, date, timeSlot, subject, notes, "Pending");
        bookingService.saveBooking(booking);

        ra.addFlashAttribute("success", "Booking request sent successfully!");
        return "redirect:/student/my-bookings";
    }

    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student student = studentService.getStudentById(studentId);
        List<Booking> bookings = bookingService.getBookingsByStudent(student);
        model.addAttribute("bookings", bookings);
        return "student/my-bookings";
    }

    @PostMapping("/cancel-booking")
    public String cancelBooking(@RequestParam Long bookingId, HttpSession session, RedirectAttributes ra) {
        if (session.getAttribute("studentId") == null) return "redirect:/student/login";
        bookingService.cancelBooking(bookingId);
        ra.addFlashAttribute("success", "Booking cancelled successfully.");
        return "redirect:/student/my-bookings";
    }
}
