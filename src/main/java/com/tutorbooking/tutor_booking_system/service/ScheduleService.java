package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Schedule;
import com.tutorbooking.tutor_booking_system.repository.ScheduleRepository;
import com.tutorbooking.tutor_booking_system.util.IDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleService {
    private final ScheduleRepository scheduleRepository;

    @Autowired
    public ScheduleService(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    public List<Schedule> getSchedulesByTutor(String tutorId) {
        return scheduleRepository.findByTutor_TutorId(tutorId);
    }

    public boolean addSchedule(Schedule schedule) {
        // Prevent duplicate time slots for the same tutor on the same date
        boolean duplicate = scheduleRepository.existsByTutor_TutorIdAndAvailableDateAndTimeSlot(
                schedule.getTutor().getTutorId(), schedule.getAvailableDate(), schedule.getTimeSlot()
        );

        if (duplicate) return false;

        schedule.setScheduleId(IDGenerator.generateScheduleID());
        scheduleRepository.save(schedule);
        return true;
    }

    public void updateSchedule(Schedule schedule) {
        scheduleRepository.save(schedule);
    }

    public void deleteSchedule(String scheduleId) {
        scheduleRepository.deleteById(scheduleId);
    }
}

