package com.tutorbooking.tutor_booking_system.service;

import com.tutorbooking.tutor_booking_system.model.Admin;
import com.tutorbooking.tutor_booking_system.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    public Admin registerAdmin(Admin admin){
        return adminRepository.save(admin);
    }

    public List<Admin>getAllAdmins(){
        return adminRepository.findAll();
    }

    public Admin getAdminById(Long id){
        return adminRepository.findById(id).orElse(null);
    }

    public Admin getAdminByEmail(String email){
        return adminRepository.findByEmail(email);
    }

    public boolean emailExists(String email){
        return adminRepository.existsByEmail(email);
    }

    public Admin updateAdmin(Admin admin){
        return adminRepository.save(admin);
    }

    public void deleteAdmin(Long id){
        adminRepository.deleteById(id);
    }

    public Admin loginAdmin(String email, String password){
        Admin admin=adminRepository.findByEmail(email);
        if (admin != null && admin.getPassword().equals(password)){
            return admin;
        }
        return null;
    }
}
