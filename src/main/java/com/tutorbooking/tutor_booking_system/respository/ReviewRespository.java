package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.entity.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    List<Review> findByTutorId(Long tutorId);
    
    List<Review> findByTutorIdAndIsVerifiedTrue(Long tutorId);
    
    List<Review> findByStudentId(Long studentId);
    
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.tutorId = :tutorId AND r.isVerified = true")
    Double getAverageRatingForTutor(@Param("tutorId") Long tutorId);
    
    @Query("SELECT COUNT(r) FROM Review r WHERE r.tutorId = :tutorId AND r.isVerified = true")
    Long getVerifiedReviewCountForTutor(@Param("tutorId") Long tutorId);
}
