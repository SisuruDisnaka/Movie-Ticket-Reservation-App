package com.theaterManagement.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.theaterManagement.model.BookedSeats;

@WebServlet(name = "BookingSaveServlet", urlPatterns = {"/bookingSave"})
public class BookingSaveServlet extends HttpServlet {
    private static final String THEATER_FILE = "theater.txt";
    private static final String SEATS_FILE = "seats.txt";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        
        // If user is not logged in, redirect to login
        if (username == null || username.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get booking details from request
        String movie = request.getParameter("movie");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String theater = request.getParameter("screenType");
        String seats = request.getParameter("seats");
        String totalPrice = request.getParameter("totalPrice");
        
        // Debug logging
        System.out.println("Received booking request:");
        System.out.println("Movie: " + movie);
        System.out.println("Date: " + date);
        System.out.println("Time: " + time);
        System.out.println("Theater: " + theater);
        System.out.println("Seats: " + seats);
        System.out.println("Total Price: " + totalPrice);
        
        // Validate required parameters
        if (movie == null || date == null || time == null || theater == null || 
            seats == null || totalPrice == null || 
            movie.trim().isEmpty() || date.trim().isEmpty() || 
            time.trim().isEmpty() || theater.trim().isEmpty() || 
            seats.trim().isEmpty() || totalPrice.trim().isEmpty()) {
            response.sendRedirect("seating.jsp?error=missing_parameters");
            return;
        }
        
        // Create booking record with date, time separate from theater
        // Format: username,movie,date,time,theater,seats,price
        String bookingRecord = String.format("%s,%s,%s,%s,%s,%s,%s\n", 
            username, movie, date, time, theater, seats, totalPrice);
        
        // Get path to theater.txt file
        String filePath = getServletContext().getRealPath("/WEB-INF/" + THEATER_FILE);
        File file = new File(filePath);
        
        // Create directories if they don't exist
        file.getParentFile().mkdirs();
        
        // Append booking to file
        try (FileWriter fw = new FileWriter(file, true);
             BufferedWriter bw = new BufferedWriter(fw)) {
            bw.write(bookingRecord);
        }
        
        // Also save seats to the seats.txt file
        String seatsFilePath = getServletContext().getRealPath("/WEB-INF/" + SEATS_FILE);
        BookedSeats bookedSeats = new BookedSeats(seatsFilePath);
        
        // Split the seats string and add each seat
        if (seats != null && !seats.isEmpty()) {
            String[] seatArray = seats.split(",");
            bookedSeats.bookSeats(movie, date, time, theater, seatArray);
        }
        
        // Redirect to confirmation page with all parameters including price
        String redirectUrl = String.format("confirmation.jsp?movie=%s&date=%s&time=%s&seats=%s&screenType=%s&price=%s",
            java.net.URLEncoder.encode(movie, "UTF-8"),
            java.net.URLEncoder.encode(date, "UTF-8"),
            java.net.URLEncoder.encode(time, "UTF-8"),
            java.net.URLEncoder.encode(seats, "UTF-8"),
            java.net.URLEncoder.encode(theater, "UTF-8"),
            java.net.URLEncoder.encode(totalPrice, "UTF-8"));
            
        System.out.println("Redirecting to: " + redirectUrl);
        response.sendRedirect(redirectUrl);
    }
} 