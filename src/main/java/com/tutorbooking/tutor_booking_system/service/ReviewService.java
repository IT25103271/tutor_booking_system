package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.entity.Review;
import com.tutorbooking.tutor_booking_system.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ReviewService {
    
    @Autowired
    private ReviewRepository reviewRepository;
    
    public Review addReview(Review review) {
        return reviewRepository.save(review);
    }
    
    public List<Review> getReviewsForTutor(Long tutorId) {
        return reviewRepository.findByTutorId(tutorId);
    }
    
    public List<Review> getVerifiedReviewsForTutor(Long tutorId) {
        return reviewRepository.findByTutorIdAndIsVerifiedTrue(tutorId);
    }
    
    public List<Review> getReviewsByStudent(Long studentId) {
        return reviewRepository.findByStudentId(studentId);
    }
    
    public Optional<Review> getReviewById(Long reviewId) {
        return reviewRepository.findById(reviewId);
    }
    
    public Double getAverageRating(Long tutorId) {
        Double average = reviewRepository.getAverageRatingForTutor(tutorId);
        return average != null ? average : 0.0;
    }
    
    public Long getReviewCount(Long tutorId) {
        return reviewRepository.getVerifiedReviewCountForTutor(tutorId);
    }
    
    public Review updateReview(Long reviewId, Review reviewDetails) {
        Optional<Review> review = reviewRepository.findById(reviewId);
        if (review.isPresent()) {
            Review existingReview = review.get();
            existingReview.setRating(reviewDetails.getRating());
            existingReview.setReviewText(reviewDetails.getReviewText());
            return reviewRepository.save(existingReview);
        }
        return null;
    }
    
    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }
    
    public void verifyReview(Long reviewId) {
        Optional<Review> review = reviewRepository.findById(reviewId);
        if (review.isPresent()) {
            Review existingReview = review.get();
            existingReview.setIsVerified(true);
            reviewRepository.save(existingReview);
        }
    }
}
