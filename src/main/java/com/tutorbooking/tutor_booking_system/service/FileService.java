package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Tutor;
import com.tutorbooking.tutor_booking_system.model.Schedule;
import com.tutorbooking.tutor_booking_system.repository.FileHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class FileService {
    private final FileHandler fileHandler;
    private static final String TUTORS_FILE = "tutors.txt";
    private static final String SCHEDULE_FILE = "schedule.txt";

    @Autowired
    public FileService(FileHandler fileHandler) {
        this.fileHandler = fileHandler;
    }

    // Tutor Operations
    public List<Tutor> getAllTutors() {
        return fileHandler.readLines(TUTORS_FILE).stream()
                .map(Tutor::fromString)
                .filter(t -> t != null)
                .collect(Collectors.toList());
    }

    public void saveTutor(Tutor tutor) {
        fileHandler.appendLine(TUTORS_FILE, tutor.toString());
    }

    public void updateTutor(Tutor updatedTutor) {
        List<Tutor> tutors = getAllTutors();
        List<String> lines = tutors.stream()
                .map(t -> t.getTutorId().equals(updatedTutor.getTutorId()) ? updatedTutor.toString() : t.toString())
                .collect(Collectors.toList());
        fileHandler.writeLines(TUTORS_FILE, lines);
    }

    public void deleteTutor(String tutorId) {
        List<Tutor> tutors = getAllTutors();
        List<String> lines = tutors.stream()
                .filter(t -> !t.getTutorId().equals(tutorId))
                .map(Tutor::toString)
                .collect(Collectors.toList());
        fileHandler.writeLines(TUTORS_FILE, lines);
    }

    // Schedule Operations
    public List<Schedule> getAllSchedules() {
        return fileHandler.readLines(SCHEDULE_FILE).stream()
                .map(Schedule::fromString)
                .filter(s -> s != null)
                .collect(Collectors.toList());
    }

    public void saveSchedule(Schedule schedule) {
        fileHandler.appendLine(SCHEDULE_FILE, schedule.toString());
    }

    public void updateSchedule(Schedule updatedSchedule) {
        List<Schedule> schedules = getAllSchedules();
        List<String> lines = schedules.stream()
                .map(s -> s.getScheduleId().equals(updatedSchedule.getScheduleId()) ? updatedSchedule.toString() : s.toString())
                .collect(Collectors.toList());
        fileHandler.writeLines(SCHEDULE_FILE, lines);
    }

    public void deleteSchedule(String scheduleId) {
        List<Schedule> schedules = getAllSchedules();
        List<String> lines = schedules.stream()
                .filter(s -> !s.getScheduleId().equals(scheduleId))
                .map(Schedule::toString)
                .collect(Collectors.toList());
        fileHandler.writeLines(SCHEDULE_FILE, lines);
    }
}
