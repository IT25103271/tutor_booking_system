package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, String> {

List<Schedule> findByTutorId(String tutorId);

List<Schedule> findByTutorIdAndAvailableDateGreaterThanEqual(String tutorId, LocalDate date);

@Query("SELECT COUNT(s) > 0 FROM Schedule s " +
        "WHERE s.tutorId = :tutorId " +
        "AND s.availableDate = :availableDate " +
        "AND s.timeSlot = :timeSlot")
boolean isDuplicateSlot(
        @Param("tutorId") String tutorId,
        @Param("availableDate") LocalDate availableDate,
        @Param("timeSlot") String timeSlot
);

// Used by TutorService.deleteTutor() — cascading delete
@Modifying(flushAutomatically = true)
@Transactional
@Query("DELETE FROM Schedule s WHERE s.tutorId = :tutorId")
int deleteByTutorId(@Param("tutorId") String tutorId);
}