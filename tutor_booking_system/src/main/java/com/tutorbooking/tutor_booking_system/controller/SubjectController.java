package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.model.Subject;
import com.tutorbooking.tutor_booking_system.repository.SubjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/subject")
public class SubjectController {

    @Autowired
    private SubjectRepository subjectRepository;

    @GetMapping("/list")
    public String list(Model model) {
        List<Subject> subjects = subjectRepository.findAll();
        model.addAttribute("subjects", subjects);
        model.addAttribute("keyword", "");
        return "subject/subjectList";
    }

    @GetMapping("/search")
    public String search(@RequestParam(defaultValue = "") String q, Model model) {
        List<Subject> subjects;
        if (q.isEmpty()) {
            subjects = subjectRepository.findAll();
        } else {
            subjects = subjectRepository
                    .findBySubjectNameContainingIgnoreCaseOrCategoryContainingIgnoreCaseOrGradeLevelContainingIgnoreCase(q, q, q);
        }
        model.addAttribute("subjects", subjects);
        model.addAttribute("keyword", q);
        return "subject/subjectList";
    }

    @GetMapping("/add")
    public String showAdd() {
        return "subject/addSubject";
    }

    @PostMapping("/add")
    public String add(@RequestParam String subjectName,
                      @RequestParam String category,
                      @RequestParam String gradeLevel,
                      @RequestParam String description,
                      @RequestParam String status,
                      RedirectAttributes ra) {
        Subject subject = new Subject(subjectName, category, gradeLevel, description, status);
        subjectRepository.save(subject);
        ra.addFlashAttribute("message", "Subject '" + subjectName + "' added successfully!");
        return "redirect:/subject/list";
    }

    @GetMapping("/edit")
    public String showEdit(@RequestParam Long id, Model model, RedirectAttributes ra) {
        Optional<Subject> subject = subjectRepository.findById(id);
        if (subject.isEmpty()) {
            ra.addFlashAttribute("message", "Subject not found.");
            return "redirect:/subject/list";
        }
        model.addAttribute("subject", subject.get());
        return "subject/editSubject";
    }

    @PostMapping("/edit")
    public String edit(@RequestParam Long subjectId,
                       @RequestParam String subjectName,
                       @RequestParam String category,
                       @RequestParam String gradeLevel,
                       @RequestParam String description,
                       @RequestParam String status,
                       RedirectAttributes ra) {
        Optional<Subject> existing = subjectRepository.findById(subjectId);
        if (existing.isPresent()) {
            Subject subject = existing.get();
            subject.setSubjectName(subjectName);
            subject.setCategory(category);
            subject.setGradeLevel(gradeLevel);
            subject.setDescription(description);
            subject.setStatus(status);
            subjectRepository.save(subject);
            ra.addFlashAttribute("message", "Subject updated successfully!");
        }
        return "redirect:/subject/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam Long id, RedirectAttributes ra) {
        subjectRepository.deleteById(id);
        ra.addFlashAttribute("message", "Subject deleted successfully.");
        return "redirect:/subject/list";
    }
}
