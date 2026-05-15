package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.util.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TutorService {
    private final FileService fileService;

    @Autowired
    public TutorService(FileService fileService) {
        this.fileService = fileService;
    }

    public boolean registerTutor(Tutor tutor) {
        // Prevent duplicate email
        List<Tutor> allTutors = fileService.getAllTutors();
        if (allTutors.stream().anyMatch(t -> t.getEmail().equalsIgnoreCase(tutor.getEmail()))) {
            return false;
        }
        tutor.setTutorId(IDGenerator.generateTutorID());
        fileService.saveTutor(tutor);
        return true;
    }

    public Optional<Tutor> login(String email, String password) {
        return fileService.getAllTutors().stream()
                .filter(t -> t.getEmail().equalsIgnoreCase(email) && t.getPassword().equals(password))
                .findFirst();
    }

    public Tutor getTutorById(String tutorId) {
        return fileService.getAllTutors().stream()
                .filter(t -> t.getTutorId().equals(tutorId))
                .findFirst()
                .orElse(null);
    }

    public void updateTutorProfile(Tutor tutor) {
        fileService.updateTutor(tutor);
    }

    public void deleteTutorAccount(String tutorId) {
        fileService.deleteTutor(tutorId);
    }
}
