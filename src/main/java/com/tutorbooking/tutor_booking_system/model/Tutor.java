package com.tutorbooking.tutor_booking_system.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class Tutor {
    @Id
    private String tutorId;
    
    private String fullName;
    private String email;
    private String phoneNumber;
    private String subject;
    private String qualification;
    private String experience;
    private String hourlyRate;
    private String availableDays;
    private String availableTime;
    
    @Column(length = 2000)
    private String aboutTutor;
    
    private String password;

    @OneToMany(mappedBy = "tutor", cascade = CascadeType.ALL)
    private List<Schedule> schedules;

    public Tutor() {}

    public Tutor(String tutorId, String fullName, String email, String phoneNumber, String subject, 
                 String qualification, String experience, String hourlyRate, String availableDays, 
                 String availableTime, String aboutTutor, String password) {
        this.tutorId = tutorId;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.subject = subject;
        this.qualification = qualification;
        this.experience = experience;
        this.hourlyRate = hourlyRate;
        this.availableDays = availableDays;
        this.availableTime = availableTime;
        this.aboutTutor = aboutTutor;
        this.password = password;
    }

    // Getters and Setters
    public String getTutorId() { return tutorId; }
    public void setTutorId(String tutorId) { this.tutorId = tutorId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(String hourlyRate) { this.hourlyRate = hourlyRate; }

    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }

    public String getAvailableTime() { return availableTime; }
    public void setAvailableTime(String availableTime) { this.availableTime = availableTime; }

    public String getAboutTutor() { return aboutTutor; }
    public void setAboutTutor(String aboutTutor) { this.aboutTutor = aboutTutor; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public List<Schedule> getSchedules() { return schedules; }
    public void setSchedules(List<Schedule> schedules) { this.schedules = schedules; }
}

