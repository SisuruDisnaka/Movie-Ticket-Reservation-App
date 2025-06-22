package com.userManage.service;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Service class to handle validation logic server-side
 * instead of using JavaScript
 */
public class ValidationService {
    
    // Email validation regex pattern
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    // Phone validation regex pattern (simple version)
    private static final Pattern PHONE_PATTERN =
        Pattern.compile("^[0-9]{10}$");
    
    /**
     * Validate password change form data
     * @return Map with validation errors (empty if validation passed)
     */
    public static Map<String, String> validatePasswordChange(
            String oldPassword, String newPassword, String confirmPassword) {
        
        Map<String, String> errors = new HashMap<>();
        
        // Check if any field is empty
        if (oldPassword == null || oldPassword.trim().isEmpty()) {
            errors.put("oldPassword", "Current password is required");
        }
        
        if (newPassword == null || newPassword.trim().isEmpty()) {
            errors.put("newPassword", "New password is required");
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Confirm password is required");
        }
        
        // Check if passwords match
        if (newPassword != null && confirmPassword != null && 
                !newPassword.equals(confirmPassword)) {
            errors.put("match", "New passwords do not match");
        }
        
        // Check if new password is strong enough
        if (newPassword != null && newPassword.length() < 8) {
            errors.put("strength", "Password must be at least 8 characters long");
        }
        
        return errors;
    }
    
    /**
     * Validate user profile form data
     * @return Map with validation errors (empty if validation passed)
     */
    public static Map<String, String> validateUserProfile(
            String firstName, String lastName, String email, String phone, String age) {
        
        Map<String, String> errors = new HashMap<>();
        
        // Check required fields
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "First name is required");
        }
        
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Last name is required");
        }
        
        // Validate email format
        if (email != null && !email.trim().isEmpty() && 
                !EMAIL_PATTERN.matcher(email).matches()) {
            errors.put("email", "Invalid email format");
        }
        
        // Validate phone format
        if (phone != null && !phone.trim().isEmpty() && 
                !PHONE_PATTERN.matcher(phone).matches()) {
            errors.put("phone", "Phone must be 10 digits");
        }
        
        // Validate age (should be a number)
        if (age != null && !age.trim().isEmpty()) {
            try {
                int ageInt = Integer.parseInt(age);
                if (ageInt < 0 || ageInt > 120) {
                    errors.put("age", "Age must be between 0 and 120");
                }
            } catch (NumberFormatException e) {
                errors.put("age", "Age must be a number");
            }
        }
        
        return errors;
    }
    
    /**
     * Validate login form data
     * @return Map with validation errors (empty if validation passed)
     */
    public static Map<String, String> validateLogin(String username, String password) {
        Map<String, String> errors = new HashMap<>();
        
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Username is required");
        }
        
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password is required");
        }
        
        return errors;
    }
} 