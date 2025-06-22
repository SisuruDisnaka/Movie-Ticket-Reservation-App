package com.userManage.model;

/**
 * Specialized class for administrative users
 */
public class AdminUser extends AbstractUser {
    private String adminLevel;
    private String department;
    
    /**
     * Constructor for AdminUser
     */
    public AdminUser(String userName, String password, String adminLevel, String department) {
        super(userName, password);
        this.adminLevel = adminLevel;
        this.department = department;
    }
    
    /**
     * Get the admin's level
     */
    public String getAdminLevel() {
        return adminLevel;
    }
    
    /**
     * Set the admin's level
     */
    public void setAdminLevel(String adminLevel) {
        this.adminLevel = adminLevel;
    }
    
    /**
     * Get the admin's department
     */
    public String getDepartment() {
        return department;
    }
    
    /**
     * Set the admin's department
     */
    public void setDepartment(String department) {
        this.department = department;
    }
    
    /**
     * Always returns true for AdminUser
     */
    @Override
    public boolean isAdmin() {
        return true;
    }
    
    /**
     * Convert to CSV format
     */
    @Override
    public String toCsvString() {
        return String.join(",", 
            userName, 
            password, 
            "admin", // First name field is used for admin role
            "", // Last name is blank for admin
            "", // Email is blank for admin
            adminLevel != null ? adminLevel : "",
            department != null ? department : "");
    }
    
    /**
     * Convert from regular User to AdminUser
     */
    public static AdminUser fromUser(User user, String adminLevel, String department) {
        return new AdminUser(
            user.getUserName(),
            user.getPassword(),
            adminLevel,
            department
        );
    }
    
    /**
     * Builder pattern for AdminUser
     */
    public static class Builder {
        private String userName;
        private String password;
        private String adminLevel = "1"; // Default level
        private String department = "General"; // Default department
        
        public Builder(String userName) {
            this.userName = userName;
        }
        
        public Builder password(String password) {
            this.password = password;
            return this;
        }
        
        public Builder adminLevel(String adminLevel) {
            this.adminLevel = adminLevel;
            return this;
        }
        
        public Builder department(String department) {
            this.department = department;
            return this;
        }
        
        public AdminUser build() {
            return new AdminUser(userName, password, adminLevel, department);
        }
    }
} 