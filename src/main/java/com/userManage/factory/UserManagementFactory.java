package com.userManage.factory;

import com.userManage.dao.UserDAO;
import com.userManage.dao.UserDAOInterface;
import com.userManage.service.UserService;
import com.userManage.service.UserServiceImpl;

import java.io.IOException;

/**
 * Factory class for creating UserDAO and UserService instances
 * Implements the Singleton pattern for centralized access
 */
public class UserManagementFactory {
    private static UserManagementFactory instance;
    private UserDAOInterface userDAO;
    private UserService userService;
    
    /**
     * Private constructor to enforce singleton pattern
     */
    private UserManagementFactory() {
    }
    
    /**
     * Get the singleton instance
     */
    public static synchronized UserManagementFactory getInstance() {
        if (instance == null) {
            instance = new UserManagementFactory();
        }
        return instance;
    }
    
    /**
     * Create and return a UserDAO instance
     */
    public UserDAOInterface createUserDAO(String userFilePath) throws IOException {
        if (userDAO == null) {
            userDAO = new UserDAO(userFilePath);
        }
        return userDAO;
    }
    
    /**
     * Create and return a UserService instance
     */
    public UserService createUserService(String userFilePath) throws IOException {
        if (userDAO == null) {
            userDAO = new UserDAO(userFilePath);
        }
        
        if (userService == null) {
            userService = new UserServiceImpl(userDAO);
        }
        
        return userService;
    }
    
    /**
     * Get an existing UserDAO instance or throw an exception if not initialized
     */
    public UserDAOInterface getUserDAO() {
        if (userDAO == null) {
            throw new IllegalStateException("UserDAO not initialized. Call createUserDAO first.");
        }
        return userDAO;
    }
    
    /**
     * Get an existing UserService instance or throw an exception if not initialized
     */
    public UserService getUserService() {
        if (userService == null) {
            throw new IllegalStateException("UserService not initialized. Call createUserService first.");
        }
        return userService;
    }
} 