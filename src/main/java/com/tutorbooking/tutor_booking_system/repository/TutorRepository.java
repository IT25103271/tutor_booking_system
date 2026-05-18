package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TutorRepository extends JpaRepository<Tutor, Long> {
    Tutor findByEmail(String email);
    boolean existsByEmail(String email);
    List<Tutor> findByVerified(boolean verified);
    List<Tutor> findBySubjectContainingIgnoreCase(String subject);

    @Query("SELECT t.subject, COUNT(t) FROM Tutor t GROUP BY t.subject")
    List<Object[]> countBySubject();

    @Query("SELECT COUNT(t) FROM Tutor t WHERE t.verified = false")
    int countPending();
    List<Tutor> findBySubjectAndVerifiedTrue(String subject);

    // Find tutors containing subject keyword (for search)
    List<Tutor> findBySubjectContainingIgnoreCaseAndVerifiedTrue(String subject);
}
