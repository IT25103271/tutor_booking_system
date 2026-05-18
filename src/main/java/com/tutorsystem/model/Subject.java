<<<<<<< Updated upstream:src/main/java/com/tutorsystem/model/Subject.java
package com.tutorsystem.model;
=======
package com.tutorbooking.tutor_booking_system.model;
>>>>>>> Stashed changes:src/main/java/com/tutorbooking/tutor_booking_system/model/Subject.java

import jakarta.persistence.*;

/**
 * Subject Entity Class
 *
 * OOP Concept: ENCAPSULATION
 * - All fields are private
 * - Accessed through public getters and setters
 *
 * @Entity  → tells Spring Boot this class maps to a MySQL table
 * @Table   → specifies the table name in the database
 */
@Entity
@Table(name = "subjects")
public class Subject {

    // @Id → primary key
    // @GeneratedValue → auto increment (1, 2, 3...)
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "subject_name", nullable = false)
    private String subjectName;

    @Column(name = "category", nullable = false)
    private String category;

    @Column(name = "grade_level", nullable = false)
    private String gradeLevel;

    @Column(name = "description")
    private String description;

    @Column(name = "status", nullable = false)
    private String status;

    // ── Constructors ──
    public Subject() {}

    public Subject(String subjectName, String category, String gradeLevel,
                   String description, String status) {
        this.subjectName = subjectName;
        this.category    = category;
        this.gradeLevel  = gradeLevel;
        this.description = description;
        this.status      = status;
    }

    // ── Getters and Setters ──
    public Long getId()                        { return id; }
    public void setId(Long id)                 { this.id = id; }

    public String getSubjectName()             { return subjectName; }
    public void   setSubjectName(String name)  { this.subjectName = name; }

    public String getCategory()                { return category; }
    public void   setCategory(String cat)      { this.category = cat; }

    public String getGradeLevel()              { return gradeLevel; }
    public void   setGradeLevel(String grade)  { this.gradeLevel = grade; }

    public String getDescription()             { return description; }
    public void   setDescription(String desc)  { this.description = desc; }

    public String getStatus()                  { return status; }
    public void   setStatus(String status)     { this.status = status; }
}
