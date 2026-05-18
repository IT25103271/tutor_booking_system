package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Booking;
import com.tutorbooking.tutor_booking_system.model.Booking.Status;
import com.tutorbooking.tutor_booking_system.model.Student;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByStatus(Status status);
    List<Booking> findByTutor_Id(Long tutorId);
    List<Booking> findByStudent_Id(Long studentId);

    // Add inside BookingRepository interface, after existing methods:
    @Modifying
    @Transactional
    @Query("DELETE FROM Booking b WHERE b.tutor.id = :tutorId")
    void deleteByTutorId(@Param("tutorId") Long tutorId);

    List<Booking> findByStudentAndStatus(Student student, Status status);
    long countByStudentAndStatus(Student student, Status status);

    long countByStatus(Status status);

    @Query(value = "SELECT DATE_FORMAT(session_date, '%b %Y') AS monthLabel, COUNT(*) AS count " +
            "FROM bookings " +
            "WHERE session_date >= DATE_SUB(CURDATE(), INTERVAL 180 DAY) " +
            "GROUP BY monthLabel, YEAR(session_date), MONTH(session_date) " +
            "ORDER BY YEAR(session_date), MONTH(session_date)",
            nativeQuery = true)
    List<Object[]> countByMonth();


}