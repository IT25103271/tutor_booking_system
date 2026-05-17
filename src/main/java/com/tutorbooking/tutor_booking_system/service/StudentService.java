package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

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

    public Student getStudentById(Long id) {
        return studentRepository.findById(id).orElse(null);
    }

    public Student updateStudent(Student student) {
        return studentRepository.save(student);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    public boolean emailExists(String email) {
        return studentRepository.existsByEmail(email);
    }

    public long countAll() {
        return studentRepository.count();
    }

    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    public long getStudentCount() {
        return studentRepository.count();
    }
}
