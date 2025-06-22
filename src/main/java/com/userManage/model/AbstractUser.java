package com.userManage.model;

/**
 * Abstract base class for all user types
 */
public abstract class AbstractUser {
    protected String userName;
    protected String password;
    
    /**
     * Constructor with username and password
     */
    protected AbstractUser(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }
    
    /**
     * Get the username
     */
    public String getUserName() {
        return userName;
    }
    
    /**
     * Set the username
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    /**
     * Get the password
     */
    public String getPassword() {
        return password;
    }
    
    /**
     * Set the password
     */
    public void setPassword(String password) {
        this.password = password;
    }
    
    /**
     * Convert user to string format for storage
     */
    public abstract String toCsvString();
    
    /**
     * Check if this user has administrative privileges
     */
    public abstract boolean isAdmin();
} 