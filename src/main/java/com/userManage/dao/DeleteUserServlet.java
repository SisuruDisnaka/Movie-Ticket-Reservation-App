package com.userManage.dao;

import com.userManage.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verify admin role
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Get username to delete
        String usernameToDelete = request.getParameter("username");
        if (usernameToDelete == null || usernameToDelete.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        // Path to the users.txt file
        String usersFilePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        
        // Get all users first
        UserDAO userDAO = new UserDAO(usersFilePath);
        Queue<User> allUsers = userDAO.getAllUsers();
        
        // Create a new queue with all users except the one to delete
        Queue<User> updatedUsers = new LinkedList<>();
        boolean userFound = false;
        
        for (User user : allUsers) {
            if (!user.getUserName().equals(usernameToDelete)) {
                updatedUsers.add(user);
            } else {
                userFound = true;
            }
        }
        
        // Only update the file if we found the user to delete
        if (userFound) {
            userDAO.clearAndSaveAll(updatedUsers);
        }
        
        // Redirect back to admin dashboard
        response.sendRedirect("AdminDashboard.jsp");
    }
} 