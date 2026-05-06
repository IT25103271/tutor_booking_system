package com.tutorbooking.tutor_booking_system.controller;

import jakarta.servlet.http.HttpSession;
import com.tutorbooking.tutor_booking_system.model.Admin;
import com.tutorbooking.tutor_booking_system.service.AdminService;
import com.tutorbooking.tutor_booking_system.service.StudentService;
import com.tutorbooking.tutor_booking_system.service.TutorService;
import com.tutorbooking.tutor_booking_system.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TutorService tutorService;

    @Autowired
    private BookingService bookingService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model){
        if(session.getAttribute("adminId")==null){
            return "redirect:/admin/login";
        }
        Long adminId=Long.valueOf(session.getAttribute("adminId").toString());
        Admin admin=adminService.getAdminById(adminId);
        model.addAttribute("admin",admin);

        // Fetch System Stats
        model.addAttribute("studentCount", studentService.getStudentCount());
        model.addAttribute("tutorCount", tutorService.getTutorCount());
        model.addAttribute("totalBookings", bookingService.getTotalBookingCount());
        model.addAttribute("pendingBookings", bookingService.getOverallBookingCountByStatus("Pending"));
        model.addAttribute("confirmedBookings", bookingService.getOverallBookingCountByStatus("Confirmed"));

        return "admin/dashboard";
    }

    @GetMapping("/login")
    public String loginPage(){
        return "admin/login";
    }
    @PostMapping("/login")
    public String login(@RequestParam String email,@RequestParam String password,HttpSession session,RedirectAttributes ra){
        Admin admin=adminService.loginAdmin(email,password);
        if(admin == null){
            ra.addFlashAttribute("error","Inavlid email or password.");
            return "redirect:/admin/login";
        }
        session.setAttribute("adminId",admin.getId());
        session.setAttribute("adminName",admin.getName());
        return "redirect:/admin/dashboard";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/admin/login";
    }

    @GetMapping("/edit")
    public String editPage(HttpSession session
                           , Model model){
        if (session.getAttribute("adminId")==null){
            return "redirect:/admin/login";
        }
        Long adminId=Long.valueOf(session.getAttribute("adminId").toString());
        Admin admin=adminService.getAdminById(adminId);
        model.addAttribute("admin",admin);
        return "admin/edit";
    }
    @PostMapping("/edit")
    public String update(@RequestParam String name,@RequestParam String email,@RequestParam String phone,@RequestParam String password,HttpSession session,RedirectAttributes ra){
        if (session.getAttribute("adminId")==null){
            return "redirect:/admin/login";
        }
        Long adminId=Long.valueOf(session.getAttribute("adminId").toString());
        Admin admin=adminService.getAdminById(adminId);
        admin.setName(name);
        admin.setEmail(email);
        admin.setPhone(phone);
        admin.setPassword(password);
        adminService.updateAdmin(admin);
        session.setAttribute("adminName",name);
        session.setAttribute("adminEmail",email);
        ra.addFlashAttribute("success","Profile updated successfully!");
        return "redirect:/admin/dashboard";
    }
    @PostMapping("/delete")
    public String delete(HttpSession session,RedirectAttributes ra){
        if (session.getAttribute("adminId")==null){
            return "redirect:/admin/login";
        }
        Long adminId=Long.valueOf(session.getAttribute("adminId").toString());
        adminService.deleteAdmin(adminId);
        session.invalidate();
        ra.addFlashAttribute("success", "Your account has been deleted.");
        return "redirect:/admin/login";
    }

}
