package com.movieManage;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/registerMovie")
@MultipartConfig
public class RegisterMovie extends HttpServlet {

    private static final String IMAGE_UPLOAD_DIR = "movie-images";
    private String MOVIE_FILE_PATH;
    private MovieManager movieManager;

    public void init() throws ServletException {
        MOVIE_FILE_PATH = getServletContext().getRealPath("/WEB-INF/movies.txt");
        movieManager = new MovieManager(MOVIE_FILE_PATH, IMAGE_UPLOAD_DIR);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Get form parameters
        String movieName = request.getParameter("movieName");
        String director = request.getParameter("director");
        String mainCharacter = request.getParameter("mainCharacter");

        String[] showingDates = request.getParameterValues("showingDates[]");
        String[] timeSlots = request.getParameterValues("timeSlots[]");
        String[] screens = request.getParameterValues("screens[]");

        String pricePremiumStr = request.getParameter("pricePremium");
        String priceBoutiqueStr = request.getParameter("priceBoutique");
        String priceStandardStr = request.getParameter("priceStandard");
        
        double pricePremium = pricePremiumStr != null && !pricePremiumStr.isEmpty() ? 
            Double.parseDouble(pricePremiumStr) : 0.0;
        double priceBoutique = priceBoutiqueStr != null && !priceBoutiqueStr.isEmpty() ? 
            Double.parseDouble(priceBoutiqueStr) : 0.0;
        double priceStandard = priceStandardStr != null && !priceStandardStr.isEmpty() ? 
            Double.parseDouble(priceStandardStr) : 0.0;

        // Handle image upload
        Part imagePart = request.getPart("image");
        String imageFileName = extractFileName(imagePart);
        
        // Save image to disk
        String uploadPath = getServletContext().getRealPath("") + File.separator + IMAGE_UPLOAD_DIR;
        movieManager.saveImageToDisk(imagePart.getInputStream(), imageFileName, uploadPath);

        // Create Movie object
        Movie movie = new Movie(
            movieName, director, mainCharacter, 
            imageFileName, showingDates, timeSlots, screens,
            pricePremium, priceBoutique, priceStandard
        );
        
        // Add movie to the database
        movieManager.addMovie(movie);

        response.sendRedirect("AdminDashboard.jsp");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return new File(token.substring(token.indexOf("=") + 2, token.length() - 1)).getName();
            }
        }
        return "default.jpg";
    }
}
