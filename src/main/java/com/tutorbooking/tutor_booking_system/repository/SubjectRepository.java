package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {

    List<Subject> findBySubjectNameContainingIgnoreCaseOrCategoryContainingIgnoreCaseOrGradeLevelContainingIgnoreCase(
            String subjectName, String category, String gradeLevel);
}
