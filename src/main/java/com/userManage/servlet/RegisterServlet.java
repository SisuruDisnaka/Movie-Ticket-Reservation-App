package com.userManage.servlet;

import com.userManage.dao.UserDAO;
import com.userManage.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        
        // Check if username already exists
        if (userDAO.getUserByUsername(userName) != null) {
            request.setAttribute("registerError", "Username already exists. Please choose another one.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }
        
        // Create user and save
        User user = new User(userName, password, firstName, lastName, email, phone, age);
        userDAO.saveUser(user);
        
        // Add success message to the session
        HttpSession session = request.getSession();
        session.setAttribute("registerSuccess", "Registration successful! Please log in with your new account.");
        response.sendRedirect("Login.jsp");
    }
}