package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import com.tutorbooking.tutor_booking_system.util.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TutorService {
    private final TutorRepository tutorRepository;

    @Autowired
    public TutorService(TutorRepository tutorRepository) {
        this.tutorRepository = tutorRepository;
    }

    public boolean registerTutor(Tutor tutor) {
        // Prevent duplicate email
        if (tutorRepository.findByEmail(tutor.getEmail()).isPresent()) {
            return false;
        }
        tutor.setTutorId(IDGenerator.generateTutorID());
        tutorRepository.save(tutor);
        return true;
    }

    public Optional<Tutor> login(String email, String password) {
        return tutorRepository.findByEmailAndPassword(email, password);
    }

    public Tutor getTutorById(String tutorId) {
        return tutorRepository.findById(tutorId).orElse(null);
    }

    public void updateTutorProfile(Tutor tutor) {
        tutorRepository.save(tutor);
    }

    public void deleteTutorAccount(String tutorId) {
        tutorRepository.deleteById(tutorId);
    }
}
