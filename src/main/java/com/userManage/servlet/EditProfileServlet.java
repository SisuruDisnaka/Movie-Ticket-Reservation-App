package com.userManage.servlet;

import com.userManage.dao.UserDAO;
import com.userManage.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {

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
        User user = userDAO.getUserByUsername(username);
        
        if (user != null) {
            request.setAttribute("firstName", user.getFirstName());
            request.setAttribute("lastName", user.getLastName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhone());
            request.setAttribute("age", user.getAge());
            
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("UserProfileServlet");
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

        // Get updated values from form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");

        // Get current user info
        User currentUser = userDAO.getUserByUsername(username);
        if (currentUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Create updated user object with existing password
        User updatedUser = new User(
                username,
                currentUser.getPassword(),
                firstName,
                lastName,
                email,
                phone,
                age
        );

        // Update user in the queue and save to file
        updateUserInFile(updatedUser);

        // Redirect to updated profile
        response.sendRedirect("UserProfileServlet");
    }

    private void updateUserInFile(User updatedUser) throws IOException {
        Queue<User> allUsers = userDAO.getAllUsers();
        Queue<User> updatedQueue = new LinkedList<>();

        for (User user : allUsers) {
            if (user.getUserName().equals(updatedUser.getUserName())) {
                updatedQueue.add(updatedUser);
            } else {
                updatedQueue.add(user);
            }
        }

        // Save updated queue back to file
        userDAO.clearAndSaveAll(updatedQueue);
    }
}
