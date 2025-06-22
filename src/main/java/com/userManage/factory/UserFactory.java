package com.userManage.factory;

import com.userManage.model.AdminUser;
import com.userManage.model.User;
import com.userManage.model.AbstractUser;

/**
 * Factory for creating different types of users
 */
public class UserFactory {

    /**
     * Create a user based on the provided role
     */
    public static AbstractUser createUser(String role, String userName, String password,
                                          String firstName, String lastName,
                                          String email, String phone, String age) {
        if ("admin".equalsIgnoreCase(role)) {
            // Create an admin user with default department and level
            return new AdminUser.Builder(userName)
                    .password(password)
                    .adminLevel("1")
                    .department("Administration")
                    .build();
        } else {
            // Create a regular user
            return new User.Builder(userName)
                    .password(password)
                    .firstName(firstName)
                    .lastName(lastName)
                    .email(email)
                    .phone(phone)
                    .age(age)
                    .build();
        }
    }

    /**
     * Create a user from CSV data
     */
    public static AbstractUser createFromCsv(String[] parts) {
        if (parts.length < 7) {
            throw new IllegalArgumentException("Invalid CSV data for user creation");
        }

        // Check if this is an admin user based on first name field
        if ("admin".equals(parts[2])) {
            // Admin format: username,password,admin,blank,blank,level,department
            return new AdminUser.Builder(parts[0])
                    .password(parts[1])
                    .adminLevel(parts[5])
                    .department(parts[6])
                    .build();
        } else {
            // Regular user: username,password,firstName,lastName,email,phone,age
            return new User.Builder(parts[0])
                    .password(parts[1])
                    .firstName(parts[2])
                    .lastName(parts[3])
                    .email(parts[4])
                    .phone(parts[5])
                    .age(parts[6])
                    .build();
        }
    }
}