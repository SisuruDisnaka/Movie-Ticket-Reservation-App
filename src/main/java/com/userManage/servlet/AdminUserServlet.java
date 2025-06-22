package com.userManage.servlet;

import com.userManage.factory.UserManagementFactory;
import com.userManage.model.User;
import com.userManage.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

/**
 * Servlet to handle admin operations on users without using JavaScript
 */
@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        String userFile = getServletContext().getRealPath("/WEB-INF/users.txt");
        try {
            userService = UserManagementFactory.getInstance().createUserService(userFile);
        } catch (IOException e) {
            throw new ServletException("Failed to initialize UserService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Verify admin role
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Check for operation type
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "view":
                    viewUser(request, response);
                    break;
                case "deleteConfirm":
                    showDeleteConfirmation(request, response);
                    break;
                case "list":
                default:
                    listUsers(request, response);
                    break;
            }
        } else {
            listUsers(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Verify admin role
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Check for operation type
        String action = request.getParameter("action");
        
        if (action != null) {
            switch (action) {
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    response.sendRedirect("AdminDashboard.jsp");
                    break;
            }
        } else {
            response.sendRedirect("AdminDashboard.jsp");
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get all users and convert to List for better handling in JSP
        Queue<User> userQueue = userService.getAllUsers();
        List<User> users = new ArrayList<>(userQueue);
        
        // Add to request and forward to admin page
        request.setAttribute("users", users);
        request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
    }
    
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        User user = userService.getUserByUsername(username);
        
        if (user == null) {
            request.setAttribute("error", "User not found");
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("viewUser", user);
        request.getRequestDispatcher("ViewUser.jsp").forward(request, response);
    }
    
    private void showDeleteConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        User user = userService.getUserByUsername(username);
        
        if (user == null) {
            request.setAttribute("error", "User not found");
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("userToDelete", user);
        request.getRequestDispatcher("DeleteUserConfirm.jsp").forward(request, response);
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String confirmed = request.getParameter("confirmed");
        
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        // Only delete if confirmed is "yes"
        if ("yes".equals(confirmed)) {
            boolean deleted = userService.deleteUser(username);
            
            if (deleted) {
                request.setAttribute("successMessage", "User '" + username + "' has been deleted");
            } else {
                request.setAttribute("error", "Failed to delete user '" + username + "'");
            }
        }
        
        // Refresh user list and show Admin Dashboard
        Queue<User> userQueue = userService.getAllUsers();
        List<User> users = new ArrayList<>(userQueue);
        request.setAttribute("users", users);
        request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
    }
} 