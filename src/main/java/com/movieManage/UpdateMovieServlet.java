package com.movieManage;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UpdateMovieServlet")
@MultipartConfig
public class UpdateMovieServlet extends HttpServlet {
    
    private static final String IMAGE_UPLOAD_DIR = "movie-images";
    private String MOVIE_FILE_PATH;
    
    public void init() throws ServletException {
        MOVIE_FILE_PATH = getServletContext().getRealPath("/WEB-INF/movies.txt");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Verify admin role
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Get form parameters
        String originalTitle = request.getParameter("originalTitle");
        String movieName = request.getParameter("movieName");
        String director = request.getParameter("director");
        String mainCharacter = request.getParameter("mainCharacter");
        
        // Get multiple parameters for showtimes
        String[] showingDates = request.getParameterValues("showingDates[]");
        String[] timeSlots = request.getParameterValues("timeSlots[]");
        String[] screens = request.getParameterValues("screens[]");
        
        // Get price parameters
        String pricePremiumStr = request.getParameter("pricePremium");
        String priceBoutiqueStr = request.getParameter("priceBoutique");
        String priceStandardStr = request.getParameter("priceStandard");
        
        double pricePremium = pricePremiumStr != null && !pricePremiumStr.isEmpty() ? 
            Double.parseDouble(pricePremiumStr) : 0.0;
        double priceBoutique = priceBoutiqueStr != null && !priceBoutiqueStr.isEmpty() ? 
            Double.parseDouble(priceBoutiqueStr) : 0.0;
        double priceStandard = priceStandardStr != null && !priceStandardStr.isEmpty() ? 
            Double.parseDouble(priceStandardStr) : 0.0;
        
        // Handle image upload if provided
        Part imagePart = request.getPart("image");
        String imageFileName = null;
        
        // Only process image if a new one was uploaded (size > 0)
        if (imagePart != null && imagePart.getSize() > 0) {
            imageFileName = extractFileName(imagePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + IMAGE_UPLOAD_DIR;
            saveImageToDisk(imagePart, imageFileName, uploadPath);
        }
        
        // Read all movies to find and update the one being edited
        List<String> updatedMovies = new ArrayList<>();
        boolean movieFound = false;
        String currentImageFileName = null;
        
        File file = new File(MOVIE_FILE_PATH);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",", -1);
                    if (parts.length > 0 && parts[0].equals(originalTitle)) {
                        // Found the movie to update
                        movieFound = true;
                        
                        // Get the current image filename if no new image is uploaded
                        if (imageFileName == null && parts.length > 3) {
                            currentImageFileName = parts[3];
                        }
                        
                        // Create updated movie entry
                        Movie updatedMovie = new Movie(
                            movieName, 
                            director, 
                            mainCharacter, 
                            imageFileName != null ? imageFileName : currentImageFileName,
                            showingDates, 
                            timeSlots, 
                            screens,
                            pricePremium, 
                            priceBoutique, 
                            priceStandard
                        );
                        
                        // Add the updated movie record
                        updatedMovies.add(updatedMovie.toCsvString());
                    } else {
                        // Keep other movies unchanged
                        updatedMovies.add(line);
                    }
                }
            }
        }
        
        // If movie wasn't found, it's a new entry
        if (!movieFound) {
            Movie newMovie = new Movie(
                movieName, 
                director, 
                mainCharacter, 
                imageFileName != null ? imageFileName : "default.jpg",
                showingDates, 
                timeSlots, 
                screens,
                pricePremium, 
                priceBoutique, 
                priceStandard
            );
            updatedMovies.add(newMovie.toCsvString());
        }
        
        // Write all movies back to the file
        try (PrintWriter writer = new PrintWriter(new FileWriter(file, false))) {
            for (String movie : updatedMovies) {
                writer.println(movie);
            }
        }
        
        // Redirect back to admin dashboard
        response.sendRedirect("AdminDashboard.jsp");
    }
    
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                String filename = token.substring(token.indexOf("=") + 2, token.length() - 1);
                return new File(filename).getName(); // Extract only the filename, not the path
            }
        }
        return "default.jpg";
    }
    
    private void saveImageToDisk(Part imagePart, String fileName, String uploadPath) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try (InputStream inputStream = imagePart.getInputStream();
             FileOutputStream outputStream = new FileOutputStream(uploadPath + File.separator + fileName)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
} 