package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TutorService {

    @Autowired
    private TutorRepository tutorRepository;

    public Tutor registerTutor(Tutor tutor) {
        return tutorRepository.save(tutor);
    }

    public Tutor loginTutor(String email, String password) {
        Tutor tutor = tutorRepository.findByEmail(email);
        if (tutor != null && tutor.getPasswordHash().equals(password)) {
            return tutor;
        }
        return null;
    }

    // ── PASSWORD CHANGE (PLAIN TEXT) ──
    @Transactional
    public boolean changePassword(Long tutorId, String currentPassword, String newPassword) {
        Tutor tutor = tutorRepository.findById(tutorId).orElse(null);
        if (tutor == null) {
            return false;
        }
        // Plain text comparison
        if (!tutor.getPasswordHash().equals(currentPassword)) {
            return false;
        }
        tutor.setPasswordHash(newPassword);
        tutorRepository.save(tutor);
        return true;
    }

    public Tutor getTutorById(Long id) {
        return tutorRepository.findById(id).orElse(null);
    }

    public List<Tutor> getAllTutors() {
        return tutorRepository.findAll();
    }

    public List<Tutor> getPendingTutors() {
        return tutorRepository.findByVerified(false);
    }

    public Tutor verifyTutor(Long id) {
        Tutor tutor = getTutorById(id);
        if (tutor != null) {
            tutor.setVerified(true);
            return tutorRepository.save(tutor);
        }
        return null;
    }
// REPLACE the existing deleteTutor method with this:

    @Autowired
    private ScheduleService scheduleService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private BookingService bookingService;
    // UPDATED: Cascade delete — removes schedules, reviews, bookings, then tutor
    @Transactional
    public void deleteTutor(Long id) {
        // 1. Delete all schedules for this tutor
        scheduleService.deleteSchedulesByTutorId(id);

        // 2. Delete all reviews for this tutor
        reviewService.deleteReviewsByTutorId(id);

        // 3. Delete all bookings for this tutor
        bookingService.deleteBookingsByTutorId(id);

        // 4. Finally delete the tutor
        tutorRepository.deleteById(id);
    }


    public Tutor updateTutor(Tutor tutor) {
        return tutorRepository.save(tutor);
    }

    /**
     * Changes the tutor's password after verifying the current password.
     *
     * @return true  – password updated successfully
     *         false – current password was wrong or tutor not found
     */


    public boolean emailExists(String email) {
        return tutorRepository.existsByEmail(email);
    }

    public long countAll() {
        return tutorRepository.count();
    }

    public long countPending() {
        return tutorRepository.countPending();
    }
    public Tutor getTutorByEmail(String email) {
        return tutorRepository.findByEmail(email);
    }

    public boolean resetPassword(String email, String newPassword) {
        Tutor tutor = tutorRepository.findByEmail(email);
        if (tutor == null) return false;

        tutor.setPasswordHash(newPassword);
        tutorRepository.save(tutor);
        return true;
    }

    public List<Object[]> getSubjectCounts() {
        return tutorRepository.countBySubject();
    }
}