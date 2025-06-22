package com.movieManage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;


public class MovieServlet extends HttpServlet {
    private MovieManager movieManager;
    private String MOVIE_FILE_PATH;

    public void init() throws ServletException {
        MOVIE_FILE_PATH = getServletContext().getRealPath("/WEB-INF/movies.txt");
        movieManager = new MovieManager(MOVIE_FILE_PATH, "movie-images");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //authentication(users and admins only)
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("username") : null;
        String role = session != null ? (String) session.getAttribute("role") : null;

        if (username == null || role == null || !(role.equals("user") || role.equals("admin"))) {
            response.sendRedirect("Login.jsp?error=unauthorized");
            return;
        }

        String search = Optional.ofNullable(request.getParameter("search")).orElse("").toLowerCase();
        String letter = Optional.ofNullable(request.getParameter("letter")).orElse("all");
        String from = Optional.ofNullable(request.getParameter("from")).orElse("");
        String sortByDate = Optional.ofNullable(request.getParameter("sortByDate")).orElse("");

        // Preserve the 'from' parameter for navigation context
        if (!from.isEmpty()) {
            request.setAttribute("from", from);
        }

        List<Movie> filteredMovies = movieManager.filterMovies(search, letter);

        // Check if we need to sort by date (newest first)
        if ("true".equals(request.getParameter("sortByDate"))) {
            movieManager.sortMoviesByNearestDate(filteredMovies);
            request.setAttribute("sortByDate", true);
        }

        request.setAttribute("movies", filteredMovies);
        request.getRequestDispatcher("MoviePage.jsp").forward(request, response);
    }
}
