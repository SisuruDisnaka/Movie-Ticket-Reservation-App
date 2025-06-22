package com.userManage.servlet;

import com.userManage.factory.UserManagementFactory;
import com.userManage.model.User;
import com.userManage.service.UserService;
import com.userManage.service.ValidationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;


public class ChangePasswordServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        String userFile = getServletContext().getRealPath("/WEB-INF/users.txt");
        try {
            // Use the UserManagementFactory to get UserService
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

        String username = (String) session.getAttribute("username");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Use ValidationService for server-side validation
        Map<String, String> validationErrors = ValidationService.validatePasswordChange(
                oldPassword, newPassword, confirmPassword);
        
        if (!validationErrors.isEmpty()) {
            // Add all validation errors to the request
            for (Map.Entry<String, String> error : validationErrors.entrySet()) {
                request.setAttribute("error_" + error.getKey(), error.getValue());
            }
            request.setAttribute("error", "Please correct the errors below");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }
        
        // Validate old password against stored password
        User user = userService.getUserByUsername(username);
        if (user != null && user.getPassword().equals(oldPassword)) {
            // Debug logging
            System.out.println("Changing password for user: " + username);
            
            // Update password
            userService.updateUserPassword(username, newPassword);
            
            // Set success message
            session.setAttribute("successMessage", "Password has been successfully updated");
            
            response.sendRedirect("UserProfileServlet");  // Redirect to profile page
        } else {
            // Old password is incorrect
            request.setAttribute("error_oldPassword", "Current password is incorrect");
            request.setAttribute("error", "Password change failed");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
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
        
        // Simply forward to the JSP page (no JavaScript required)
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }
}
