package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.*;
import com.tutorbooking.tutor_booking_system.repository.ScheduleRepository;
import com.tutorbooking.tutor_booking_system.repository.SubjectRepository;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import com.tutorbooking.tutor_booking_system.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * StudentController
 *
 * Handles:
 *   /student/**         — Student self-service (auth, dashboard, profile, bookings, reviews)
 *   /admin/students/**  — Admin student management (list, delete)
 *
 * Forgot-password flow → StudentForgotPasswordController
 */
@Controller
public class StudentController {

    @Autowired private OtpService        otpService;
    @Autowired private EmailService      emailService;
    @Autowired private StudentService    studentService;
    @Autowired private BookingService    bookingService;
    @Autowired private ReviewService     reviewService;
    @Autowired private ScheduleService   scheduleService;
    @Autowired private TutorRepository   tutorRepository;
    @Autowired private SubjectRepository subjectRepository;
    @Autowired private ScheduleRepository scheduleRepository;

    // ── helpers ──────────────────────────────────────────────

    private boolean isStudentLoggedIn(HttpSession session) {
        return session.getAttribute("studentId") != null;
    }

    private boolean isAdminLoggedIn(HttpSession session) {
        return session.getAttribute("adminId") != null;
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT AUTH — REGISTER / OTP / LOGIN / LOGOUT
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/register")
    public String registerPage(Model model) {
        return "student/register";
    }

    @PostMapping("/student/register")
    public String register(@ModelAttribute Student student,
                           HttpSession session,
                           RedirectAttributes ra) {
        if (studentService.emailExists(student.getEmail())) {
            ra.addFlashAttribute("error", "Email already registered!");
            return "redirect:/student/register";
        }

        String otpCode = otpService.generateAndSendOtp(student.getEmail(), student.getName());

        session.setAttribute("pendingStudent",   student);
        session.setAttribute("studentOtpEmail",  student.getEmail());

        ra.addFlashAttribute("success", "Verification code sent to " + student.getEmail());
        return "redirect:/student/verify-otp";
    }

    @GetMapping("/student/verify-otp")
    public String verifyOtpPage(HttpSession session, Model model, RedirectAttributes ra) {
        String email = (String) session.getAttribute("studentOtpEmail");
        if (email == null) {
            ra.addFlashAttribute("error", "Please register first.");
            return "redirect:/student/register";
        }
        model.addAttribute("email", email);
        return "student/verify-otp";
    }

    @PostMapping("/student/verify-otp")
    public String verifyOtp(@RequestParam String otpCode,
                            HttpSession session,
                            RedirectAttributes ra) {
        String  email          = (String)  session.getAttribute("studentOtpEmail");
        Student pendingStudent = (Student) session.getAttribute("pendingStudent");

        if (email == null || pendingStudent == null) {
            ra.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/student/register";
        }

        boolean valid = otpService.validateOtp(email, otpCode);
        if (!valid) {
            ra.addFlashAttribute("error", "Invalid or expired verification code.");
            return "redirect:/student/verify-otp";
        }

        studentService.registerStudent(pendingStudent);

        session.removeAttribute("pendingStudent");
        session.removeAttribute("studentOtpEmail");

        ra.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/student/login";
    }

    @PostMapping("/student/resend-otp")
    public String resendOtp(HttpSession session, RedirectAttributes ra) {
        String  email          = (String)  session.getAttribute("studentOtpEmail");
        Student pendingStudent = (Student) session.getAttribute("pendingStudent");

        if (email == null || pendingStudent == null) {
            ra.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/student/register";
        }
        if (!otpService.canResendOtp(email)) {
            ra.addFlashAttribute("error", "Please wait before requesting a new code.");
            return "redirect:/student/verify-otp";
        }

        otpService.generateAndSendOtp(email, pendingStudent.getName());
        ra.addFlashAttribute("success", "New verification code sent!");
        return "redirect:/student/verify-otp";
    }

    @GetMapping("/student/login")
    public String loginPage() {
        return "student/login";
    }

    @PostMapping("/student/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes ra) {
        Student student = studentService.loginStudent(email, password);
        if (student == null) {
            ra.addFlashAttribute("error", "Invalid email or password.");
            return "redirect:/student/login";
        }

        session.setAttribute("studentId",   student.getId());
        session.setAttribute("studentName", student.getName());

        if (student.getLastLogin() != null) {
            session.setAttribute("lastLoginTime", student.getLastLogin());
        }
        student.setLastLogin(java.time.LocalDateTime.now());
        studentService.updateStudent(student);

        return "redirect:/student/dashboard";
    }

    @GetMapping("/student/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/student/login";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT DASHBOARD
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student student = studentService.getStudentById(studentId);

        int pending   = bookingService.getBookingCountByStatus(student, "Pending");
        int confirmed = bookingService.getBookingCountByStatus(student, "Confirmed");
        int completed = bookingService.getBookingCountByStatus(student, "Completed");
        int cancelled = bookingService.getBookingCountByStatus(student, "Cancelled");

        model.addAttribute("student",       student);
        model.addAttribute("totalBookings", pending + confirmed + completed + cancelled);
        model.addAttribute("pendingCount",  pending);
        model.addAttribute("confirmedCount",confirmed);
        model.addAttribute("completedCount",completed);
        model.addAttribute("cancelledCount",cancelled);

        List<Booking> recentBookings = bookingService.getBookingsByStudent(student);
        if (recentBookings != null && recentBookings.size() > 5) {
            recentBookings = recentBookings.subList(0, 5);
        }
        model.addAttribute("recentBookings", recentBookings);
        return "student/dashboard";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT PROFILE
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/profile")
    public String profilePage(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student student = studentService.getStudentById(studentId);
        model.addAttribute("student", student);
        return "student/profile";
    }
    @GetMapping("/student/edit-profile")
    public String editProfilePage(HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";
        model.addAttribute("student", studentService.getStudentById(studentId));
        return "student/edit-profile";
    }

    @PostMapping("/student/edit-profile")
    public String updateProfile(@ModelAttribute Student student,
                                HttpSession session,
                                RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        student.setId(studentId);
        studentService.updateStudent(student);

        Student updated = studentService.getStudentById(studentId);
        session.setAttribute("studentName", updated.getName());

        ra.addFlashAttribute("success", "Profile updated successfully!");
        return "redirect:/student/profile";
    }

    @PostMapping("/student/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        if (!newPassword.equals(confirmPassword)) {
            ra.addFlashAttribute("pwError", "New passwords do not match.");
            return "redirect:/student/profile";
        }
        if (newPassword.length() < 8) {
            ra.addFlashAttribute("pwError", "New password must be at least 8 characters.");
            return "redirect:/student/profile";
        }

        Student student = studentService.getStudentById(studentId);
        if (!studentService.verifyPassword(student, currentPassword)) {
            ra.addFlashAttribute("pwError", "Current password is incorrect.");
            return "redirect:/student/profile";
        }

        studentService.updatePassword(student, newPassword);
        ra.addFlashAttribute("pwSuccess", "Password updated successfully!");
        return "redirect:/student/profile";
    }

    @PostMapping("/student/delete")
    public String deleteAccount(@RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student student = studentService.getStudentById(studentId);
        if (!studentService.verifyPassword(student, confirmPassword)) {
            ra.addFlashAttribute("deleteError", "Password is incorrect. Account not deleted.");
            return "redirect:/student/profile";
        }

        studentService.deleteStudent(studentId);
        session.invalidate();
        ra.addFlashAttribute("success", "Account deleted successfully.");
        return "redirect:/student/login";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT — VIEW SUBJECTS & TUTORS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/view-subjects")
    public String viewSubjects(Model model, HttpSession session) {
        if (!isStudentLoggedIn(session)) return "redirect:/student/login";
        model.addAttribute("subjects", subjectRepository.findAll());
        return "subject/view-subjects";
    }

    @GetMapping("/student/view-tutors")
    public String viewTutors(@RequestParam(required = false) String subject,
                             Model model, HttpSession session) {
        if (!isStudentLoggedIn(session)) return "redirect:/student/login";

        List<Tutor>   tutors          = null;
        Subject       selectedSubject = null;

        if (subject != null && !subject.isEmpty()) {
            tutors = tutorRepository.findBySubjectAndVerifiedTrue(subject);
            List<Subject> subjects = subjectRepository.findAll();
            selectedSubject = subjects.stream()
                    .filter(s -> s.getSubjectName().equalsIgnoreCase(subject))
                    .findFirst()
                    .orElse(null);
        } else {
            tutors = tutorRepository.findByVerified(true);
        }

        model.addAttribute("tutors",          tutors);
        model.addAttribute("selectedSubject", selectedSubject);
        return "tutor/view-tutors";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT — BOOK TUTOR
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/book-tutor")
    public String bookTutor(@RequestParam Long id,
                            @RequestParam(required = false) Long subjectId,
                            HttpSession session, Model model) {
        if (!isStudentLoggedIn(session)) return "redirect:/student/login";

        Tutor tutor = tutorRepository.findById(id).orElse(null);
        if (tutor == null) return "redirect:/student/view-tutors";

        List<Schedule> schedules = scheduleRepository.findByTutorIdAndAvailableDateGreaterThanEqual(
                String.valueOf(id), LocalDate.now());

        Subject subject = null;
        if (subjectId != null) {
            subject = subjectRepository.findById(subjectId).orElse(null);
        }

        model.addAttribute("tutor",     tutor);
        model.addAttribute("schedules", schedules);
        model.addAttribute("subject",   subject);
        return "booking/book-tutor";
    }

    @PostMapping("/student/book-tutor")
    public String submitBooking(@RequestParam Long tutorId,
                                @RequestParam(required = false) Long subjectId,
                                @RequestParam String scheduleId,
                                @RequestParam(required = false) String notes,
                                HttpSession session,
                                RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Schedule schedule = scheduleRepository.findById(scheduleId).orElse(null);
        if (schedule == null) {
            ra.addFlashAttribute("error", "Selected time slot is no longer available.");
            return "redirect:/student/book-tutor?id=" + tutorId;
        }

        Booking booking = bookingService.createBooking(
                tutorId, studentId, subjectId,
                schedule.getAvailableDate(), schedule.getTimeSlot(), notes
        );
        if (booking == null) {
            ra.addFlashAttribute("error", "Failed to create booking. Please try again.");
            return "redirect:/student/book-tutor?id=" + tutorId;
        }

        scheduleRepository.deleteById(scheduleId);
        ra.addFlashAttribute("success", "Booking request sent! Waiting for tutor confirmation.");
        return "redirect:/student/my-bookings";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT — MY BOOKINGS
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/my-bookings")
    public String myBookings(Model model, HttpSession session) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Student       student  = studentService.getStudentById(studentId);
        List<Booking> bookings = bookingService.getBookingsByStudent(student);

        model.addAttribute("bookings", bookings);
        model.addAttribute("student",  student);
        return "booking/my-bookings";
    }

    @PostMapping("/student/cancel-booking")
    public String cancelBooking(@RequestParam Long bookingId,
                                HttpSession session,
                                RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null || !booking.getStudent().getId().equals(studentId)) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/student/my-bookings";
        }
        if (booking.getStatus() == Booking.Status.COMPLETED) {
            ra.addFlashAttribute("error", "Cannot cancel a completed booking.");
            return "redirect:/student/my-bookings";
        }

        bookingService.updateStatus(bookingId, Booking.Status.CANCELLED);
        ra.addFlashAttribute("success", "Booking cancelled successfully.");
        return "redirect:/student/my-bookings";
    }

    // ══════════════════════════════════════════════════════════
    //  STUDENT — ADD REVIEW
    // ══════════════════════════════════════════════════════════

    @GetMapping("/student/add-review")
    public String addReviewPage(@RequestParam Long bookingId,
                                HttpSession session, Model model,
                                RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null || !booking.getStudent().getId().equals(studentId)) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/student/my-bookings";
        }
        if (booking.getStatus() != Booking.Status.COMPLETED) {
            ra.addFlashAttribute("error", "You can only review completed bookings.");
            return "redirect:/student/my-bookings";
        }
        if (reviewService.hasStudentReviewedBooking(studentId, bookingId)) {
            ra.addFlashAttribute("error", "You have already reviewed this booking.");
            return "redirect:/student/my-bookings";
        }

        model.addAttribute("booking", booking);
        model.addAttribute("tutor",   booking.getTutor());
        return "review/add-review";
    }

    @PostMapping("/student/add-review")
    public String submitReview(@RequestParam Long bookingId,
                               @RequestParam Integer rating,
                               @RequestParam String comment,
                               HttpSession session,
                               RedirectAttributes ra) {
        Long studentId = (Long) session.getAttribute("studentId");
        if (studentId == null) return "redirect:/student/login";

        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null || !booking.getStudent().getId().equals(studentId)) {
            ra.addFlashAttribute("error", "Booking not found.");
            return "redirect:/student/my-bookings";
        }
        if (reviewService.hasStudentReviewedBooking(studentId, bookingId)) {
            ra.addFlashAttribute("error", "You have already reviewed this booking.");
            return "redirect:/student/my-bookings";
        }

        Review review = reviewService.createReview(
                booking.getTutor().getId(), studentId, bookingId, rating, comment
        );
        if (review == null) {
            ra.addFlashAttribute("error", "Failed to submit review. You may have already reviewed this booking.");
            return "redirect:/student/add-review?bookingId=" + bookingId;
        }

        ra.addFlashAttribute("success", "Review submitted successfully!");
        return "redirect:/student/my-bookings";
    }

    // ══════════════════════════════════════════════════════════
    //  ADMIN — STUDENT MANAGEMENT  (/admin/students/...)
    // ══════════════════════════════════════════════════════════

    @GetMapping("/admin/students")
    public String adminListStudents(HttpSession session, Model model) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        model.addAttribute("students", studentService.getAllStudents());
        return "student/students";
    }

    @PostMapping("/admin/students/{id}/delete")
    public String adminDeleteStudent(@PathVariable Long id,
                                     HttpSession session,
                                     RedirectAttributes ra) {
        if (!isAdminLoggedIn(session)) return "redirect:/admin/login";
        try {
            studentService.deleteStudent(id);
            ra.addFlashAttribute("success", "Student deleted successfully.");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete student: They may have active bookings or reviews.");
        }
        return "redirect:/admin/students";
    }
}
