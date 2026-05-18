package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Review;
import com.tutorbooking.tutor_booking_system.model.Student;
import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.repository.ReviewRepository;
import com.tutorbooking.tutor_booking_system.repository.StudentRepository;
import com.tutorbooking.tutor_booking_system.repository.TutorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private TutorRepository tutorRepository;

    @Autowired
    private StudentRepository studentRepository;

    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
    }

    // NEW: Delete all reviews for a specific tutor (used in cascade delete)
    @Transactional
    public void deleteReviewsByTutorId(Long tutorId) {
        reviewRepository.deleteByTutorId(tutorId);
    }

    public List<Review> getReviewsByTutor(Long tutorId) {
        List<Review> reviews = reviewRepository.findByTutorId(tutorId);
        if (reviews == null || reviews.isEmpty()) {
            try {
                reviews = reviewRepository.findByTutorId(String.valueOf(tutorId));
            } catch (Exception e) {
                // Ignore
            }
        }
        return reviews;
    }

    public long countAll() {
        return reviewRepository.count();
    }

    public List<Object[]> getRatingCounts() {
        return reviewRepository.countByRating();
    }

    public void deleteReview(Long id) {
        reviewRepository.deleteById(id);
    }

    public Review saveReview(Review review) {
        return reviewRepository.save(review);
    }

    // NEW: Check if student already reviewed this booking
    public boolean hasStudentReviewedBooking(Long studentId, Long bookingId) {
        return reviewRepository.existsByStudentIdAndBookingId(studentId, bookingId);
    }

    // UPDATED: Create review with duplicate check
    public Review createReview(Long tutorId, Long studentId, Long bookingId, Integer rating, String comment) {
        // Prevent duplicate review
        if (hasStudentReviewedBooking(studentId, bookingId)) {
            return null;
        }

        Review review = new Review();

        Tutor tutor = tutorRepository.findById(tutorId).orElse(null);
        Student student = studentRepository.findById(studentId).orElse(null);

        if (tutor == null || student == null) return null;

        review.setTutor(tutor);
        review.setStudent(student);
        review.setBookingId(bookingId);
        review.setRating(rating);
        review.setComment(comment);
        // createdAt auto-set by @PrePersist

        return reviewRepository.save(review);
    }
}