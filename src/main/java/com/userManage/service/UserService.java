package com.userManage.service;

import com.userManage.model.User;

import java.io.IOException;
import java.util.Queue;

/**
 * Service interface defining user management operations
 */
public interface UserService {
    /**
     * Authenticate a user with username and password
     */
    boolean authenticateUser(String username, String password);
    
    /**
     * Get a user by their username
     */
    User getUserByUsername(String username);
    
    /**
     * Save a new user to the system
     */
    void saveUser(User user) throws IOException;
    
    /**
     * Get all users in the system
     */
    Queue<User> getAllUsers();
    
    /**
     * Update a user's password
     */
    void updateUserPassword(String username, String newPassword) throws IOException;
    
    /**
     * Delete a user by username
     */
    boolean deleteUser(String username) throws IOException;
    
    /**
     * Update user profile information
     */
    boolean updateUserProfile(User updatedUser) throws IOException;
} 