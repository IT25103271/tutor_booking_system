package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.*;

@Entity
@Table(name = "subjects")
public class Subject {

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

    public Subject() {}

    public Subject(String subjectName, String category, String gradeLevel,
                   String description, String status) {
        this.subjectName = subjectName;
        this.category = category;
        this.gradeLevel = gradeLevel;
        this.description = description;
        this.status = status;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getGradeLevel() { return gradeLevel; }
    public void setGradeLevel(String gradeLevel) { this.gradeLevel = gradeLevel; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
