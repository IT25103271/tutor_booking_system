package com.tutorsystem.controller;

import com.tutorsystem.model.Subject;
import com.tutorsystem.util.SubjectFileHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/subject")
public class SubjectController {

    @GetMapping("/list")
    public String listSubjects(Model model) {
        model.addAttribute("subjects", SubjectFileHandler.readAllSubjects());
        model.addAttribute("keyword", "");
        return "subject/subjectList";
    }

    @GetMapping("/search")
    public String searchSubjects(@RequestParam(value = "q", defaultValue = "") String keyword, Model model) {
        List<Subject> subjects = keyword.isEmpty()
                ? SubjectFileHandler.readAllSubjects()
                : SubjectFileHandler.searchSubjects(keyword);
        model.addAttribute("subjects", subjects);
        model.addAttribute("keyword", keyword);
        return "subject/subjectList";
    }

    @GetMapping("/add")
    public String showAddForm() {
        return "subject/addSubject";
    }

    @PostMapping("/add")
    public String addSubject(@RequestParam String subjectName,
                              @RequestParam String category,
                              @RequestParam String gradeLevel,
                              @RequestParam String description,
                              @RequestParam String status,
                              RedirectAttributes redirectAttrs) {
        String newId = SubjectFileHandler.generateNextId();
        Subject subject = new Subject(newId, subjectName, category, gradeLevel, description, status);
        SubjectFileHandler.addSubject(subject);
        redirectAttrs.addFlashAttribute("message", "Subject '" + subjectName + "' added successfully!");
        return "redirect:/subject/list";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam String id, Model model, RedirectAttributes redirectAttrs) {
        Subject subject = SubjectFileHandler.findById(id);
        if (subject == null) {
            redirectAttrs.addFlashAttribute("message", "Subject not found.");
            return "redirect:/subject/list";
        }
        model.addAttribute("subject", subject);
        return "subject/editSubject";
    }

    @PostMapping("/edit")
    public String updateSubject(@RequestParam String subjectId,
                                 @RequestParam String subjectName,
                                 @RequestParam String category,
                                 @RequestParam String gradeLevel,
                                 @RequestParam String description,
                                 @RequestParam String status,
                                 RedirectAttributes redirectAttrs) {
        Subject subject = new Subject(subjectId, subjectName, category, gradeLevel, description, status);
        SubjectFileHandler.updateSubject(subject);
        redirectAttrs.addFlashAttribute("message", "Subject updated successfully!");
        return "redirect:/subject/list";
    }

    @GetMapping("/delete")
    public String deleteSubject(@RequestParam String id, RedirectAttributes redirectAttrs) {
        SubjectFileHandler.deleteSubject(id);
        redirectAttrs.addFlashAttribute("message", "Subject deleted successfully.");
        return "redirect:/subject/list";
    }
}
