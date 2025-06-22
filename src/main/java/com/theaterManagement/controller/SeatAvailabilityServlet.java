package com.theaterManagement.controller;

import java.io.IOException;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.theaterManagement.model.BookedSeats;

@WebServlet(name = "SeatAvailabilityServlet", urlPatterns = {"/seatAvailability"})
public class SeatAvailabilityServlet extends HttpServlet {
    private static final String SEATS_FILE = "seats.txt";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get parameters
        String movie = request.getParameter("movie");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String theater = request.getParameter("screenType");
        
        // Validate required parameters
        if (movie == null || date == null || time == null || theater == null) {
            response.sendRedirect("MoviePage.jsp?error=missing_params");
            return;
        }
        
        // Initialize BookedSeats with the file path
        String seatsFilePath = getServletContext().getRealPath("/WEB-INF/" + SEATS_FILE);
        BookedSeats bookedSeats = new BookedSeats(seatsFilePath);
        
        // Get already booked seats
        Set<String> unavailableSeats = bookedSeats.getBookedSeats(movie, date, time, theater);
        
        // Set booked seats as a request attribute
        request.setAttribute("bookedSeats", unavailableSeats);
        
        // Forward to seating.jsp
        request.getRequestDispatcher("seating.jsp").forward(request, response);
    }
} 