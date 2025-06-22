package com.movieManage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/DeleteMovieServlet")
public class DeleteMovieServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verify admin role
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String movieTitle = request.getParameter("title");
        if (movieTitle == null || movieTitle.trim().isEmpty()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        // Path to the movies.txt file
        String moviesFilePath = getServletContext().getRealPath("/WEB-INF/movies.txt");
        File file = new File(moviesFilePath);
        
        if (!file.exists()) {
            response.sendRedirect("AdminDashboard.jsp");
            return;
        }
        
        // Read all movies except the one to delete
        List<String> remainingMovies = new ArrayList<>();
        boolean movieFound = false;
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length > 0) {
                    String title = parts[0];
                    if (!title.equals(movieTitle)) {
                        remainingMovies.add(line);
                    } else {
                        movieFound = true;
                    }
                }
            }
        }
        
        // If movie was found, write the remaining movies back to the file
        if (movieFound) {
            try (PrintWriter writer = new PrintWriter(new FileWriter(file, false))) {
                for (String movie : remainingMovies) {
                    writer.println(movie);
                }
            }
        }
        
        response.sendRedirect("AdminDashboard.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Call doGet to handle the deletion
        doGet(request, response);
    }
} 