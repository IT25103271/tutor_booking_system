package com.tutorbooking.tutor_booking_system;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.model.Subject;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import com.tutorbooking.tutor_booking_system.repository.SubjectRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Component
public class DataInitializer {

    @Autowired
    private TutorRepository tutorRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    @PostConstruct
    public void init() {
        if (tutorRepository.count() == 0) {
            Tutor t1 = new Tutor("Dr. Sarah Smith", "sarah@example.com", "12345678", "pass123", "Mathematics", 50.0, "Mon-Fri (4PM-8PM)");
            Tutor t2 = new Tutor("Prof. James Wilson", "james@example.com", "87654321", "pass123", "Physics", 60.0, "Tue-Sat (2PM-6PM)");
            Tutor t3 = new Tutor("Ms. Emily Brown", "emily@example.com", "11223344", "pass123", "English Literature", 40.0, "Weekends (10AM-4PM)");
            
            tutorRepository.saveAll(Arrays.asList(t1, t2, t3));
        }

        if (subjectRepository.count() == 0) {
            Subject s1 = new Subject("Advanced Mathematics", "Mathematics", "A/L", "Calculus, Trigonometry and Statistics", "Active");
            Subject s2 = new Subject("Physics", "Science", "A/L", "Mechanics, Waves and Thermal Physics", "Active");
            Subject s3 = new Subject("Chemistry", "Science", "A/L", "Organic, Inorganic and Physical Chemistry", "Active");
            Subject s4 = new Subject("English Literature", "Languages", "O/L", "Classical and Modern Literature", "Active");
            
            subjectRepository.saveAll(Arrays.asList(s1, s2, s3, s4));
        }
    }
}
