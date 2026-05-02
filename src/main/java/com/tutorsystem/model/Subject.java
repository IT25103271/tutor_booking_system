package com.tutorsystem.model;

/**
 * Subject Model - OOP Concept: ENCAPSULATION
 */
public class Subject {

    private String subjectId;
    private String subjectName;
    private String category;
    private String gradeLevel;
    private String description;
    private String status;

    public Subject() {}

    public Subject(String subjectId, String subjectName, String category,
                   String gradeLevel, String description, String status) {
        this.subjectId   = subjectId;
        this.subjectName = subjectName;
        this.category    = category;
        this.gradeLevel  = gradeLevel;
        this.description = description;
        this.status      = status;
    }

    public String getSubjectId()               { return subjectId; }
    public void   setSubjectId(String id)      { this.subjectId = id; }

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

    public String toFileString() {
        return subjectId + "|" + subjectName + "|" + category + "|" +
               gradeLevel + "|" + description + "|" + status;
    }

    public static Subject fromFileString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length < 6) return null;
        return new Subject(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
    }
}
