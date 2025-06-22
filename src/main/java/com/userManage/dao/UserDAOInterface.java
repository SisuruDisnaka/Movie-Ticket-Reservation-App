package com.userManage.dao;

import com.userManage.model.User;

import java.io.IOException;
import java.util.Queue;

/**
 * Interface for User Data Access Object
 */
public interface UserDAOInterface {
    /**
     * Load users from the data source
     */
    void loadUsersFromFile() throws IOException;
    
    /**
     * Save users to the data source
     */
    void saveUsersToFile() throws IOException;
    
    /**
     * Save a single user
     */
    void saveUser(User user) throws IOException;
    
    /**
     * Get a user by username
     */
    User getUserByUsername(String username);
    
    /**
     * Validate user credentials
     */
    boolean validateUser(String username, String password);
    
    /**
     * Get all users
     */
    Queue<User> getAllUsers();
    
    /**
     * Clear all users and save new user list
     */
    void clearAndSaveAll(Queue<User> updatedUsers) throws IOException;
    
    /**
     * Update a user's password
     */
    void updateUserPassword(String username, String newPassword) throws IOException;
} 