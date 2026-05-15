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

    public long getBookingCountByStatus(Student student, String status) {
        return bookingRepository.countByStudentAndStatus(student, status);
    }

    public List<Booking> getBookingsByStudentAndStatus(Student student, String status) {
        return bookingRepository.findByStudentAndStatus(student, status);
    }
    
    public void saveBooking(Booking booking) {
        bookingRepository.save(booking);
    }
}
