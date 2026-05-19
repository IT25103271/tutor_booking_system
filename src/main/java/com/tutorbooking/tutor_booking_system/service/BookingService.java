package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.model.Booking.Status;
import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.repository.BookingRepository;
import com.tutorbooking.tutor_booking_system.repository.ReviewRepository;
import com.tutorbooking.tutor_booking_system.repository.StudentRepository;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private TutorRepository tutorRepository;
    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired

    private StudentRepository studentRepository;

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id).orElse(null);
    }

    public List<Booking> getBookingsByStatus(Status status) {
        return bookingRepository.findByStatus(status);
    }

    public List<Booking> getBookingsByStudent(Student student) {
        if (student == null || student.getId() == null) {
            return java.util.Collections.emptyList();
        }
        return bookingRepository.findByStudent_Id(student.getId());
    }

    public List<Booking> getBookingsByStudentAndStatus(Student student, String statusStr) {
        if (student == null || student.getId() == null) {
            return java.util.Collections.emptyList();
        }
        try {
            Status status = Status.valueOf(statusStr.toUpperCase());
            return bookingRepository.findByStudentAndStatus(student, status);
        } catch (Exception e) {
            return bookingRepository.findByStudent_Id(student.getId());
        }
    }

    // Add inside BookingService class, after existing methods:

    /**
     * Deletes all bookings associated with a specific tutor.
     */
    @Transactional
    public void deleteBookingsByTutorId(Long tutorId) {
        bookingRepository.deleteByTutorId(tutorId);
    }

    public int getBookingCountByStatus(Student student, String status) {
        if (student == null) return 0;

        List<Booking> bookings = getBookingsByStudent(student);
        if (bookings == null) return 0;

        return (int) bookings.stream()
                .filter(b -> b.getStatus() != null
                        && b.getStatus().name().equalsIgnoreCase(status))
                .count();
    }



    // NEW: Create booking from student page
    public Booking createBooking(Long tutorId, Long studentId, Long subjectId,
                                 LocalDate sessionDate, String timeSlot,
                                 String notes) {
        Booking booking = new Booking();

        Tutor tutor = tutorRepository.findById(tutorId).orElse(null);
        Student student = studentRepository.findById(studentId).orElse(null);

        if (tutor == null || student == null) return null;

        booking.setTutor(tutor);
        booking.setStudent(student);
        booking.setSubjectId(subjectId);
        booking.setSessionDate(sessionDate);
        booking.setTimeSlot(timeSlot);
        booking.setNotes(notes);
        booking.setTotalAmount(tutor.getHourlyRate());
        booking.setStatus(Status.PENDING);
        booking.setPaymentStatus(Booking.PaymentStatus.UNPAID);

        return bookingRepository.save(booking);
    }

    public Booking saveBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    public long countAll() {
        return bookingRepository.count();
    }

    public long countByStatus(Status status) {
        return bookingRepository.countByStatus(status);
    }

    public List<Object[]> getMonthlyBookingCounts() {
        return bookingRepository.countByMonth();
    }

    public Booking updateStatus(Long id, Status status) {
        Booking booking = bookingRepository.findById(id).orElse(null);
        if (booking != null) {
            booking.setStatus(status);
            return bookingRepository.save(booking);
        }
        return null;
    }

    public void deleteBooking(Long id) {

        reviewRepository.deleteByBookingId(id);
        bookingRepository.deleteById(id);
    }
}