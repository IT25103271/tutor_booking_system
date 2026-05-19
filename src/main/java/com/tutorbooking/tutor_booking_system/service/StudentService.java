package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.repository.BookingRepository;
import com.tutorbooking.tutor_booking_system.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private BookingRepository bookingRepository;

    public Student registerStudent(Student student) {
        return studentRepository.save(student);
    }

    public Student loginStudent(String email, String password) {
        Student student = studentRepository.findByEmail(email);
        if (student != null && student.getPassword().equals(password)) {
            return student;
        }
        return null;
    }

    public boolean verifyPassword(Student student, String rawPassword) {
        return rawPassword.equals(student.getPassword());
    }

    public void updatePassword(Student student, String newRawPassword) {
        student.setPassword(newRawPassword);
        studentRepository.save(student);
    }

    public Student getStudentById(Long id) {
        return studentRepository.findById(id).orElse(null);
    }



    @Transactional
    public void deleteStudent(Long id) {
        // Step 1: Delete all bookings for this student
        List<Booking> bookings = bookingRepository.findByStudent_Id(id);
        for (Booking booking : bookings) {
            bookingRepository.delete(booking);
        }

        // Step 2: Delete the student (no FK error now)
        studentRepository.deleteById(id);
    }

    public boolean emailExists(String email) {
        return studentRepository.existsByEmail(email);
    }

    public long getStudentCount() {
        return studentRepository.count();
    }

    public long countAll() {
        return studentRepository.count();
    }
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }
    public void updateStudent(Student student) {
        Student existing = studentRepository.findById(student.getId()).orElse(null);
        if (existing != null) {
            // Only update fields that were actually sent from the form
            if (student.getName() != null && !student.getName().isEmpty()) {
                existing.setName(student.getName());
            }
            if (student.getPhone() != null && !student.getPhone().isEmpty()) {
                existing.setPhone(student.getPhone());
            }
            if (student.getAddress() != null && !student.getAddress().isEmpty()) {
                existing.setAddress(student.getAddress());
            }
            // Don't touch email, password, or other fields


            studentRepository.save(existing);
        }
    }
    public Student getStudentByEmail(String email) {
        return studentRepository.findByEmail(email);
    }


}