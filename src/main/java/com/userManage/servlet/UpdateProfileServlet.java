package com.userManage.servlet;

import com.userManage.factory.UserManagementFactory;
import com.userManage.model.User;
import com.userManage.service.UserService;
import com.userManage.service.ValidationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class UpdateProfileServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        String userFile = getServletContext().getRealPath("/WEB-INF/users.txt");
        try {
            // Use UserManagementFactory to get UserService
            userService = UserManagementFactory.getInstance().createUserService(userFile);
        } catch (IOException e) {
            throw new ServletException("Failed to initialize UserService", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String userName = (String) session.getAttribute("username");
        User existingUser = userService.getUserByUsername(userName);

        if (existingUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Get updated fields from form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");

        // Use ValidationService to validate form data
        Map<String, String> validationErrors = ValidationService.validateUserProfile(
                firstName, lastName, email, phone, age);
        
        if (!validationErrors.isEmpty()) {
            // Add validation errors to request
            for (Map.Entry<String, String> error : validationErrors.entrySet()) {
                request.setAttribute("error_" + error.getKey(), error.getValue());
            }
            request.setAttribute("error", "Please correct the errors below");
            
            // Add form data back to request to preserve values
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("age", age);
            
            // Forward back to form
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
            return;
        }

        // Create updated user using builder pattern
        User updatedUser = new User.Builder(userName)
                .password(existingUser.getPassword())  // keep the same password
                .firstName(firstName)
                .lastName(lastName)
                .email(email)
                .phone(phone)
                .age(age)
                .build();

        // Update user profile using UserService
        boolean updateSuccess = userService.updateUserProfile(updatedUser);
        
        if (updateSuccess) {
            // Set success message in session
            session.setAttribute("successMessage", "Your profile has been successfully updated");
            
            // Force browser to make a new request rather than using a cached response
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            
            // Redirect to UserProfileServlet to refresh the view
            response.sendRedirect("UserProfileServlet");
        } else {
            // Handle update failure
            request.setAttribute("error", "Failed to update profile. Please try again.");
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle direct access to the servlet via GET
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String userName = (String) session.getAttribute("username");
        User user = userService.getUserByUsername(userName);
        
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Set user data in request
        request.setAttribute("user", user);
        
        // Forward to edit profile page
        request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
    }
}
