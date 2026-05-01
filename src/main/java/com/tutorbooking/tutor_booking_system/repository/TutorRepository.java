package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TutorRepository extends JpaRepository<Tutor, Long> {
}
