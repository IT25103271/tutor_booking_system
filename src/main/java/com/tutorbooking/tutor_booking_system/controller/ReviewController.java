package com.tutorbooking.tutor_booking_system.controller;

import com.tutorbooking.tutor_booking_system.entity.Review;
import com.tutorbooking.tutor_booking_system.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reviews")
public class ReviewController {
    
    @Autowired
    private ReviewService reviewService;
    
    @GetMapping("/tutor/{tutorId}")
    public String getTutorReviews(@PathVariable Long tutorId, Model model) {
        List<Review> reviews = reviewService.getVerifiedReviewsForTutor(tutorId);
        Double averageRating = reviewService.getAverageRating(tutorId);
        Long reviewCount = reviewService.getReviewCount(tutorId);
        
        model.addAttribute("tutorId", tutorId);
        model.addAttribute("reviews", reviews);
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("reviewCount", reviewCount);
        
        return "reviews/tutor-reviews";
    }
    
    @GetMapping("/add")
    public String showAddReviewForm(@RequestParam Long tutorId, Model model) {
        model.addAttribute("tutorId", tutorId);
        model.addAttribute("review", new Review());
        return "reviews/add-review";
    }
    
    @PostMapping("/add")
    public String submitReview(@ModelAttribute Review review, @RequestParam Long tutorId) {
        review.setTutorId(tutorId);
        review.setIsVerified(true);
        reviewService.addReview(review);
        return "redirect:/reviews/tutor/" + tutorId;
    }
    
    @GetMapping("/api/tutor/{tutorId}")
    @ResponseBody
    public ResponseEntity<List<Review>> getReviewsAPI(@PathVariable Long tutorId) {
        List<Review> reviews = reviewService.getVerifiedReviewsForTutor(tutorId);
        return ResponseEntity.ok(reviews);
    }
    
    @GetMapping("/api/tutor/{tutorId}/rating")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAverageRatingAPI(@PathVariable Long tutorId) {
        Double rating = reviewService.getAverageRating(tutorId);
        Long count = reviewService.getReviewCount(tutorId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("averageRating", rating);
        response.put("reviewCount", count);
        
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/api/add")
    @ResponseBody
    public ResponseEntity<Review> addReviewAPI(@RequestBody Review review) {
        review.setIsVerified(true);
        Review savedReview = reviewService.addReview(review);
        return ResponseEntity.ok(savedReview);
    }
}
