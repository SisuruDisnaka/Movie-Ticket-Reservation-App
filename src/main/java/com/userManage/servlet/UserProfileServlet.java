package com.userManage.servlet;

import com.userManage.dao.UserDAO;
import com.userManage.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null || !"user".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String username = (String) session.getAttribute("username");
        
        // Debug log: Request received
        System.out.println("UserProfileServlet: Loading profile for: " + username);
        
        // Reload userDAO to ensure fresh data
        String userFile = getServletContext().getRealPath("/WEB-INF/users.txt");
        try {
            userDAO = new UserDAO(userFile);
        } catch (IOException e) {
            throw new ServletException("Failed to initialize UserDAO", e);
        }
        
        User user = userDAO.getUserByUsername(username);
        if (user != null) {
            // Debug log: User data
            System.out.println("Found user data:");
            System.out.println("  firstName: " + user.getFirstName());
            System.out.println("  lastName: " + user.getLastName());
            System.out.println("  email: " + user.getEmail());
            System.out.println("  phone: " + user.getPhone());
            System.out.println("  age: " + user.getAge());
            
            request.setAttribute("firstName", user.getFirstName());
            request.setAttribute("lastName", user.getLastName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("age", user.getAge());
            
            // Check for password change success message
            if (session.getAttribute("passwordChanged") != null) {
                request.setAttribute("successMessage", "Password changed successfully!");
                session.removeAttribute("passwordChanged");
            }
            
            // Check for profile update success message
            if (session.getAttribute("profileUpdated") != null) {
                request.setAttribute("successMessage", "Profile updated successfully!");
                session.removeAttribute("profileUpdated");
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("UserProfile.jsp");
        dispatcher.forward(request, response);
    }
}