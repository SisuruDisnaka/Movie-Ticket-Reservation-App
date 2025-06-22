package com.Review_and_Feedback.servlet;

import com.Review_and_Feedback.model.Review;
import com.Review_and_Feedback.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EditFeedbackServlet extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        int rating = 0;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            rating = Integer.parseInt(ratingStr);
        }

        Review updatedReview = new Review(movieName, rating, comment);
        boolean updated = reviewService.updateReview(updatedReview);

        if (updated) {
            response.getWriter().write("Feedback updated successfully!");
            response.sendRedirect("Reviews.jsp");
        } else {
            response.getWriter().write("Movie not found to update!");
            response.sendRedirect("Feedback.jsp");
        }
    }
}

