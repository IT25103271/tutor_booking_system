<<<<<<< Updated upstream:src/main/java/com/tutorsystem/repository/SubjectRepository.java
package com.tutorsystem.repository;

import com.tutorsystem.model.Subject;
=======
package com.tutorbooking.tutor_booking_system.repository;

import com.tutorbooking.tutor_booking_system.model.Subject;
>>>>>>> Stashed changes:src/main/java/com/tutorbooking/tutor_booking_system/repository/SubjectRepository.java
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

<<<<<<< Updated upstream:src/main/java/com/tutorsystem/repository/SubjectRepository.java
/**
 * SubjectRepository
 *
 * This replaces SubjectFileHandler.java
 * Instead of reading/writing to a .txt file,
 * it reads/writes to MySQL database automatically!
 *
 * JpaRepository gives us these methods for FREE:
 * - findAll()       → get all subjects
 * - findById(id)    → get one subject
 * - save(subject)   → create or update
 * - deleteById(id)  → delete
 */
=======
>>>>>>> Stashed changes:src/main/java/com/tutorbooking/tutor_booking_system/repository/SubjectRepository.java
@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {

    // Custom search method — Spring generates the SQL automatically!
    // SQL: SELECT * FROM subjects WHERE subject_name LIKE '%keyword%'
    //      OR category LIKE '%keyword%'
    //      OR grade_level LIKE '%keyword%'
    List<Subject> findBySubjectNameContainingIgnoreCaseOrCategoryContainingIgnoreCaseOrGradeLevelContainingIgnoreCase(
            String subjectName, String category, String gradeLevel);
}
