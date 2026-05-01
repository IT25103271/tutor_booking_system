package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    public Booking saveBooking(Booking booking) {
        return bookingRepository.save(booking);
    }

    public List<Booking> getBookingsByStudent(Student student) {
        return bookingRepository.findByStudent(student);
    }

    public void cancelBooking(Long id) {
        bookingRepository.deleteById(id);
    }

    public long getBookingCountByStatus(Student student, String status) {
        return bookingRepository.countByStudentAndStatus(student, status);
    }
}
