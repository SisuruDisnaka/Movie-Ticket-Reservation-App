package com.userManage.service;

import com.userManage.dao.UserDAOInterface;
import com.userManage.model.User;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

/**
 * Implementation of UserService that delegates to UserDAO
 */
public class UserServiceImpl implements UserService {
    private final UserDAOInterface userDAO;
    
    /**
     * Constructor with UserDAO dependency
     */
    public UserServiceImpl(UserDAOInterface userDAO) {
        this.userDAO = userDAO;
    }
    
    @Override
    public boolean authenticateUser(String username, String password) {
        return userDAO.validateUser(username, password);
    }
    
    @Override
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }
    
    @Override
    public void saveUser(User user) throws IOException {
        userDAO.saveUser(user);
    }
    
    @Override
    public Queue<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    @Override
    public void updateUserPassword(String username, String newPassword) throws IOException {
        userDAO.updateUserPassword(username, newPassword);
    }
    
    @Override
    public boolean deleteUser(String username) throws IOException {
        Queue<User> allUsers = userDAO.getAllUsers();
        Queue<User> updatedUsers = new LinkedList<>();
        boolean userFound = false;
        
        // Create new queue without the user to delete
        for (User user : allUsers) {
            if (!user.getUserName().equals(username)) {
                updatedUsers.add(user);
            } else {
                userFound = true;
            }
        }
        
        // Only update if user was found
        if (userFound) {
            userDAO.clearAndSaveAll(updatedUsers);
            return true;
        }
        
        return false;
    }
    
    @Override
    public boolean updateUserProfile(User updatedUser) throws IOException {
        Queue<User> allUsers = userDAO.getAllUsers();
        Queue<User> updatedUsers = new LinkedList<>();
        boolean userFound = false;
        
        for (User user : allUsers) {
            if (user.getUserName().equals(updatedUser.getUserName())) {
                updatedUsers.add(updatedUser);
                userFound = true;
            } else {
                updatedUsers.add(user);
            }
        }
        
        if (userFound) {
            userDAO.clearAndSaveAll(updatedUsers);
            return true;
        }
        
        return false;
    }
} 