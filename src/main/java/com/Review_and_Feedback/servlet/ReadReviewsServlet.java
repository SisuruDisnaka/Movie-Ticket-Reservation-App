package com.Review_and_Feedback.servlet;

import com.Review_and_Feedback.model.Review;
import com.Review_and_Feedback.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ReadReviewsServlet extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieName = request.getParameter("movieName");


        if (movieName == null || movieName.isEmpty()) {
            movieName = "Spider Man";
        }

        List<Review> reviews = reviewService.getReviewsForMovie(movieName);


        request.setAttribute("reviews", reviews);
        request.setAttribute("movieName", movieName);

        request.getRequestDispatcher("Reviews.jsp").forward(request, response);
    }
}
