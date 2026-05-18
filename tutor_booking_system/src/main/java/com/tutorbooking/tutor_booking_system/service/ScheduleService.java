package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Schedule;
import com.tutorbooking.tutor_booking_system.repository.ScheduleRepository;
import com.tutorbooking.tutor_booking_system.util.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class ScheduleService {
    private final ScheduleRepository scheduleRepository;

    @Autowired
    public ScheduleService(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    public List<Schedule> getSchedulesByTutor(String tutorId) {
        return scheduleRepository.findByTutorId(tutorId);
    }

    // ← ADD: for ownership check in controller before deleting
    public Schedule getScheduleById(String scheduleId) {
        return scheduleRepository.findById(scheduleId).orElse(null);
    }

    // ← ADD: for booking page — only show future/today slots
    public List<Schedule> getAvailableSchedules(String tutorId) {
        return scheduleRepository.findByTutorIdAndAvailableDateGreaterThanEqual(tutorId, LocalDate.now());
    }

    public boolean addSchedule(Schedule schedule) {
        boolean duplicate = scheduleRepository.isDuplicateSlot(
                schedule.getTutorId(),
                schedule.getAvailableDate(),
                schedule.getTimeSlot()
        );

        if (duplicate) return false;

        schedule.setScheduleId(IDGenerator.generateScheduleID());
        scheduleRepository.save(schedule);
        return true;
    }

    public void updateSchedule(Schedule schedule) {
        scheduleRepository.save(schedule);
    }

    // Delete all schedules for a tutor (called before deleting tutor account)
    public void deleteSchedulesByTutorId(Long tutorId) {
        List<Schedule> schedules = scheduleRepository.findByTutorId(String.valueOf(tutorId));
        for (Schedule s : schedules) {
            scheduleRepository.deleteById(s.getScheduleId());
        }
    }

    // ← FIXED: safe delete — won't throw if ID doesn't exist
    public void deleteSchedule(String scheduleId) {
        if (scheduleRepository.existsById(scheduleId)) {
            scheduleRepository.deleteById(scheduleId);
        }
    }
}