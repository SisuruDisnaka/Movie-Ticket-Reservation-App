package com.movieManage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MovieDetailServlet", urlPatterns = {"/movie"})
public class MovieDetailServlet extends HttpServlet {
    private MovieManager movieManager;
    private String MOVIE_FILE_PATH;

    @Override
    public void init() throws ServletException {
        MOVIE_FILE_PATH = getServletContext().getRealPath("/WEB-INF/movies.txt");
        movieManager = new MovieManager(MOVIE_FILE_PATH, "movie-images");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Authentication check - only allow logged-in users
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("username") : null;
        String role = session != null ? (String) session.getAttribute("role") : null;
        
        if (username == null || role == null) {
            response.sendRedirect("Login.jsp?error=unauthorized");
            return;
        }

        // Get movie ID parameter (in this case, we'll use the movie title as ID)
        String movieId = request.getParameter("id");
        
        if (movieId == null || movieId.isEmpty()) {
            response.sendRedirect("MoviePage.jsp?error=missing_movie_id");
            return;
        }

        // Get all movies and find the one with matching ID
        List<Movie> allMovies = movieManager.getAllMovies();
        Movie selectedMovie = null;
        
        // In a real application, you would have proper IDs
        // For now, we'll match by title or by index if id is numeric
        try {
            int index = Integer.parseInt(movieId) - 1; // Convert 1-based index to 0-based
            if (index >= 0 && index < allMovies.size()) {
                selectedMovie = allMovies.get(index);
            }
        } catch (NumberFormatException e) {
            // If not a number, search by title
            for (Movie movie : allMovies) {
                if (movie.getTitle().equalsIgnoreCase(movieId)) {
                    selectedMovie = movie;
                    break;
                }
            }
        }
        
        if (selectedMovie == null) {
            response.sendRedirect("MoviePage.jsp?error=movie_not_found");
            return;
        }
        
        // Set the movie info as a request attribute
        request.setAttribute("movie", selectedMovie);
        
        // Forward to the booking page
        request.getRequestDispatcher("movie-booking.jsp").forward(request, response);
    }
} 