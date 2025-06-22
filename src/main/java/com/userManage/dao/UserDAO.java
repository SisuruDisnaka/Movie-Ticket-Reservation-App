package com.userManage.dao;

import com.userManage.model.User;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

/**
 * Data Access Object for User operations
 */
public class UserDAO implements UserDAOInterface {

    private final String userFile;
    private final Queue<User> usersQueue;
    
    /**
     * Constructor initializes the DAO with the location of the user file
     */
    public UserDAO(String userFile) throws IOException {
        this.userFile = userFile;
        this.usersQueue = new LinkedList<>();
        loadUsersFromFile();
    }

    /**
     * Load users from file into memory
     */
    @Override
    public void loadUsersFromFile() throws IOException {
        // Clear existing users before loading
        usersQueue.clear();
        
        File file = new File(userFile);
        if (!file.exists()) return;
        
        System.out.println("Loading users from file: " + userFile);
        
        try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    // Use the Builder pattern to create user
                    User user = new User.Builder(parts[0])
                        .password(parts[1])
                        .firstName(parts[2])
                        .lastName(parts[3])
                        .email(parts[4])
                        .phone(parts[5])
                        .age(parts[6])
                        .build();
                        
                    usersQueue.add(user);
                    System.out.println("Loaded user: " + parts[0] + ", firstName: " + parts[2] + ", lastName: " + parts[3]);
                }
            }
        }
        System.out.println("Total users loaded: " + usersQueue.size());
    }
    

    @Override
    public void saveUsersToFile() throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFile))) {
            for (User user : usersQueue) {
                writer.write(user.toCsvString());
                writer.newLine();
            }
        }
    }
    

    @Override
    public void saveUser(User user) throws IOException {
        usersQueue.add(user);
        saveUsersToFile(); // write entire queue to file
    }
    

    @Override
    public User getUserByUsername(String username) {
        // Reload data from file to ensure we have the latest version
        try {
            loadUsersFromFile();
        } catch (IOException e) {
            System.out.println("Error reloading user data: " + e.getMessage());
        }
        
        // Debug output
        System.out.println("Looking for user: " + username);
        
        for (User user : usersQueue) {
            if (user.getUserName().equals(username)) {
                // Debug - found the user
                System.out.println("Found user in database: " + username);
                System.out.println("  firstName: " + user.getFirstName());
                System.out.println("  lastName: " + user.getLastName());
                return user;
            }
        }
        System.out.println("User not found in database: " + username);
        return null;
    }
    

    @Override
    public boolean validateUser(String username, String password) {
        User user = getUserByUsername(username);
        return user != null && user.getPassword().equals(password);
    }

    @Override
    public Queue<User> getAllUsers() {
        return new LinkedList<>(usersQueue); // Return a copy to prevent external modification
    }


    @Override
    public void clearAndSaveAll(Queue<User> updatedUsers) throws IOException {
        usersQueue.clear();
        usersQueue.addAll(updatedUsers);
        saveUsersToFile();
    }


    @Override
    public void updateUserPassword(String username, String newPassword) throws IOException {
        boolean updated = false;
        Queue<User> updatedQueue = new LinkedList<>();
        
        // Debug info
        System.out.println("Updating password for: " + username);
        System.out.println("Original queue size: " + usersQueue.size());
        
        for (User user : usersQueue) {
            if (user.getUserName().equals(username)) {
                // Create updated user with new password using Builder pattern
                User updatedUser = new User.Builder(user.getUserName())
                    .password(newPassword)
                    .firstName(user.getFirstName())
                    .lastName(user.getLastName())
                    .email(user.getEmail())
                    .phone(user.getPhone())
                    .age(user.getAge())
                    .build();
                    
                updatedQueue.add(updatedUser);
                updated = true;
                System.out.println("Found user to update: " + user.getUserName());
            } else {
                updatedQueue.add(user);
            }
        }
        
        // Replace queue and save to file
        if (updated) {
            System.out.println("User found, updating password");
            usersQueue.clear();
            usersQueue.addAll(updatedQueue);
            saveUsersToFile();
            System.out.println("Updated queue size: " + usersQueue.size());
            System.out.println("Password updated and saved to file");
        } else {
            System.out.println("User not found, no password updated");
        }
    }
}