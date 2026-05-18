package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

List<Review> findByTutorId(Long tutorId);
List<Review> findByTutorId(String tutorId);
List<Review> findByApproved(boolean approved);
List<Review> findByStudentId(Long studentId);

    // Add inside ReviewRepository interface, after existing methods:
    @Modifying
    @Transactional
    @Query("DELETE FROM Review r WHERE r.tutor.id = :tutorId")
    void deleteByTutorId(@Param("tutorId") Long tutorId);
// NEW: Check if student already reviewed this booking
boolean existsByStudentIdAndBookingId(Long studentId, Long bookingId);

@Query("SELECT r.rating, COUNT(r) FROM Review r GROUP BY r.rating ORDER BY r.rating")
List<Object[]> countByRating();
}
