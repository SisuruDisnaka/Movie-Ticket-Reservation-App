package com.userManage.model;

/**
 * User model with proper encapsulation and builder pattern
 */
public class User extends AbstractUser {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String age;
    
    // Keep existing constructor for backward compatibility
    public User(String userName, String password, String firstName, String lastName, String email, String phone, String age) {
        super(userName, password);
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.age = age;
    }
    
    // Private constructor for Builder pattern
    private User(Builder builder) {
        super(builder.userName, builder.password);
        this.firstName = builder.firstName;
        this.lastName = builder.lastName;
        this.email = builder.email;
        this.phone = builder.phone;
        this.age = builder.age;
    }

    // Getters
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getAge() { return age; }
    
    // Setters for encapsulation
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setAge(String age) { this.age = age; }
    
    /**
     * Check if this user is an admin
     * In this implementation, we're using a simple check of the username
     */
    @Override
    public boolean isAdmin() {
        return "admin".equals(userName);
    }
    
    /**
     * Builder pattern implementation for User
     */
    public static class Builder {
        private String userName;
        private String password;
        private String firstName;
        private String lastName;
        private String email;
        private String phone;
        private String age;
        
        public Builder(String userName) {
            this.userName = userName;
        }
        
        public Builder password(String password) {
            this.password = password;
            return this;
        }
        
        public Builder firstName(String firstName) {
            this.firstName = firstName;
            return this;
        }
        
        public Builder lastName(String lastName) {
            this.lastName = lastName;
            return this;
        }
        
        public Builder email(String email) {
            this.email = email;
            return this;
        }
        
        public Builder phone(String phone) {
            this.phone = phone;
            return this;
        }
        
        public Builder age(String age) {
            this.age = age;
            return this;
        }
        
        public User build() {
            return new User(this);
        }
    }
    
    /**
     * Create a copy of this User
     */
    public User copy() {
        return new Builder(this.userName)
            .password(this.password)
            .firstName(this.firstName)
            .lastName(this.lastName)
            .email(this.email)
            .phone(this.phone)
            .age(this.age)
            .build();
    }
    
    /**
     * Helper method to convert User to CSV format
     */
    @Override
    public String toCsvString() {
        return String.join(",", 
            userName, 
            password, 
            firstName != null ? firstName : "", 
            lastName != null ? lastName : "",
            email != null ? email : "",
            phone != null ? phone : "",
            age != null ? age : "");
    }
}
