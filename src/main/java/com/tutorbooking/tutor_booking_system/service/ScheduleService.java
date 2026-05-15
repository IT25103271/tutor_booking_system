package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Schedule;
import com.tutorbooking.tutor_booking_system.util.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ScheduleService {
    private final FileService fileService;

    @Autowired
    public ScheduleService(FileService fileService) {
        this.fileService = fileService;
    }

    public List<Schedule> getSchedulesByTutor(String tutorId) {
        return fileService.getAllSchedules().stream()
                .filter(s -> s.getTutorId().equals(tutorId))
                .collect(Collectors.toList());
    }

    public boolean addSchedule(Schedule schedule) {
        // Prevent duplicate time slots for the same tutor on the same date
        List<Schedule> tutorSchedules = getSchedulesByTutor(schedule.getTutorId());
        boolean duplicate = tutorSchedules.stream().anyMatch(s -> 
            s.getAvailableDate().equals(schedule.getAvailableDate()) && 
            s.getTimeSlot().equals(schedule.getTimeSlot())
        );

        if (duplicate) return false;

        schedule.setScheduleId(IDGenerator.generateScheduleID());
        fileService.saveSchedule(schedule);
        return true;
    }

    public void updateSchedule(Schedule schedule) {
        fileService.updateSchedule(schedule);
    }

    public void deleteSchedule(String scheduleId) {
        fileService.deleteSchedule(scheduleId);
    }
}
