package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, String> {
    List<Schedule> findByTutor_TutorId(String tutorId);
    boolean existsByTutor_TutorIdAndAvailableDateAndTimeSlot(String tutorId, String availableDate, String timeSlot);
}

