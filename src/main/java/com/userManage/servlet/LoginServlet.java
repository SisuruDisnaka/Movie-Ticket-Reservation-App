package com.userManage.servlet;

import com.userManage.dao.UserDAO;
import com.userManage.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PWD = "admin123";
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        String userFile = getServletContext().getRealPath("/WEB-INF/users.txt");
        try {
            userDAO = new UserDAO(userFile);
        } catch (IOException e) {
            throw new ServletException("Failed to initialize UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        
        // Check if parameters are null or empty
        if (userName == null || password == null || userName.isEmpty() || password.isEmpty()) {
            request.setAttribute("loginError", "Username and password are required");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }
        
        HttpSession session = request.getSession();
        
        // Admin login
        if (ADMIN_USER.equals(userName) && ADMIN_PWD.equals(password)) {
            session.setAttribute("username", userName);
            session.setAttribute("role", "admin");
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        // User login
        User user = userDAO.getUserByUsername(userName);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("username", userName);
            session.setAttribute("role", "user");
            response.sendRedirect("UserProfileServlet");
        } else {
            // For debugging - print the issue
            System.out.println("Login failed for: " + userName);
            
            // Provide more specific error messages
            if (user == null) {
                System.out.println("User not found in database");
                request.setAttribute("loginError", "Username not found. Please check your username or register a new account.");
                request.setAttribute("showRegisterLink", true);
            } else {
                System.out.println("Password mismatch: [entered]=" + password + ", [stored]=" + user.getPassword());
                request.setAttribute("loginError", "Incorrect password. Please try again.");
            }
            
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}