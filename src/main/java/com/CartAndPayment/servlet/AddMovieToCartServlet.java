package com.CartAndPayment.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AddMovieToCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String movie = request.getParameter("movie");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String theater = request.getParameter("theater");
        String seats = request.getParameter("seats");
        String priceStr = request.getParameter("price");

        // Validate required parameters
        if (movie == null || date == null || time == null || theater == null || seats == null || priceStr == null || 
            movie.trim().isEmpty() || date.trim().isEmpty() || time.trim().isEmpty() || 
            theater.trim().isEmpty() || seats.trim().isEmpty() || priceStr.trim().isEmpty()) {
            // If any required parameter is missing, redirect to home page
            response.sendRedirect("home.jsp");
            return;
        }

        int price;
        try {
            price = Integer.parseInt(priceStr.trim());
        } catch (NumberFormatException e) {
            // If price is not a valid number, redirect to home page
            response.sendRedirect("home.jsp");
            return;
        }

        // Create a unique item name for the movie ticket
        String itemName = String.format("Movie Ticket - %s (%s, %s, %s)", movie, date, time, theater);

        // Clear existing cart and price map
        session.removeAttribute("cart");
        session.removeAttribute("priceMap");
        session.removeAttribute("movie_ticket_details");

        // Create new cart and price map
        Map<String, Integer> cart = new HashMap<>();
        Map<String, Integer> priceMap = new HashMap<>();
        session.setAttribute("cart", cart);
        session.setAttribute("priceMap", priceMap);

        // Add movie ticket to cart
        cart.put(itemName, 1); // Movie tickets are always quantity 1
        priceMap.put(itemName, price);

        // Store additional movie ticket details in session for later use
        Map<String, String> movieDetails = new HashMap<>();
        movieDetails.put("movie", movie);
        movieDetails.put("date", date);
        movieDetails.put("time", time);
        movieDetails.put("theater", theater);
        movieDetails.put("seats", seats);
        session.setAttribute("movie_ticket_details", movieDetails);

        // Redirect to FoodCard.jsp
        response.sendRedirect("FoodCard.jsp");
    }
} 