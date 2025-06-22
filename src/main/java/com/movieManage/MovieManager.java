package com.movieManage;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class MovieManager {
    private final String movieFilePath;
    private final String imageUploadDir;

    public MovieManager(String movieFilePath, String imageUploadDir) {
        this.movieFilePath = movieFilePath;
        this.imageUploadDir = imageUploadDir;
    }

    /**
     * Read all movies from the storage file
     */
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        File file = new File(movieFilePath);

        if (!file.exists()) return movies;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = br.readLine()) != null) {
                try {
                    String[] parts = line.split(",", -1); // allow empty fields
                    if (parts.length >= 4) {
                        String title = parts[0];
                        String director = parts.length > 1 ? parts[1] : "";
                        String mainCharacter = parts.length > 2 ? parts[2] : "";
                        String image = "movie-images/" + parts[3]; // prepend image folder
                        
                        // Initialize with reasonable defaults
                        String[] showingDates = new String[0];
                        String[] timeSlots = new String[0];
                        String[] screens = new String[0];
                        double pricePremium = 0.0;
                        double priceBoutique = 0.0;
                        double priceStandard = 0.0;
                        

                        // "Premium", "Boutique", "Standard" keywords
                        List<Integer> screenPositions = new ArrayList<>();
                        for (int i = 4; i < parts.length; i++) {
                            if (parts[i].equals("Premium") || parts[i].equals("Boutique") || parts[i].equals("Standard")) {
                                screenPositions.add(i);
                            }
                        }


                        if (!screenPositions.isEmpty()) {
                            int firstScreenPos = screenPositions.get(0);

                            List<String> datesList = new ArrayList<>();
                            List<String> timeList = new ArrayList<>();

                            for (int i = 4; i < firstScreenPos; i++) {
                                String value = parts[i];
                                if (isValidDate(value)) {
                                    datesList.add(value);
                                }
                                else if (isValidTime(value)) {
                                    timeList.add(value);
                                }
                            }

                            if (datesList.isEmpty()) {
                                if (!timeList.isEmpty()) {
                                    datesList = Collections.nCopies(timeList.size(), "Not specified");
                                } else {
                                    datesList.add("Not specified");
                                }
                            }
                            

                            if (timeList.isEmpty() && !datesList.isEmpty()) {
                                timeList = Collections.nCopies(datesList.size(), "Not specified");
                            }
                            
                            // Ensure we have equal number of dates and times (use the smaller count)
                            int count = Math.min(datesList.size(), timeList.size());
                            if (count > 0) {
                                datesList = datesList.subList(0, count);
                                timeList = timeList.subList(0, count);
                            }
                            
                            // Collect screen types
                            List<String> screenList = new ArrayList<>();
                            for (int pos : screenPositions) {
                                screenList.add(parts[pos]);
                            }
                            
                            // Ensure we have enough screen values (match count of dates/times)
                            while (screenList.size() < count) {
                                screenList.add(screenList.isEmpty() ? "Standard" : screenList.get(screenList.size() - 1));
                            }
                            // Trim excess screen values if needed
                            if (screenList.size() > count) {
                                screenList = screenList.subList(0, count);
                            }
                            
                            // Find prices by looking after the screen positions
                            List<Double> priceList = new ArrayList<>();
                            for (int i = screenPositions.get(screenPositions.size() - 1) + 1; i < parts.length; i++) {
                                try {
                                    if (!parts[i].isEmpty()) {
                                        priceList.add(Double.parseDouble(parts[i]));
                                    }
                                } catch (NumberFormatException e) {
                                    // Skip if not a valid price
                                }
                            }
                            
                            // Assign the collected values
                            showingDates = datesList.toArray(new String[0]);
                            timeSlots = timeList.toArray(new String[0]);
                            screens = screenList.toArray(new String[0]);
                            
                            // Assign prices based on available values
                            if (priceList.size() >= 3) {
                                pricePremium = priceList.get(0);
                                priceBoutique = priceList.get(1);
                                priceStandard = priceList.get(2);
                            } else if (priceList.size() == 2) {
                                pricePremium = priceList.get(0);
                                priceBoutique = priceList.get(1);
                            } else if (priceList.size() == 1) {
                                pricePremium = priceList.get(0);
                            }
                        } else {
                            // Fallback for completely unrecognized format
                            showingDates = new String[]{"Not available"};
                            timeSlots = new String[]{"Not available"};
                            screens = new String[]{"Standard"};
                        }
                        
                        movies.add(new Movie(title, director, mainCharacter, image, 
                            showingDates, timeSlots, screens, 
                            pricePremium, priceBoutique, priceStandard));
                    }
                } catch (Exception e) {
                    // Log the error but continue processing other movies
                    System.err.println("Error processing movie entry: " + line);
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return movies;
    }



    //YYYY-MM-DD
    private boolean isValidDate(String date) {

        if (date == null || date.length() < 8) {
            return false;
        }
        
        // Check if it contains image file extensions
        if (date.toLowerCase().endsWith(".jpg") || 
            date.toLowerCase().endsWith(".jpeg") || 
            date.toLowerCase().endsWith(".png") || 
            date.toLowerCase().endsWith(".gif") || 
            date.toLowerCase().endsWith(".webp")) {
            return false;
        }
        // Check for date pattern
        return date.matches("\\d{4}-\\d{2}-\\d{2}");
    }
    
    // HH:MM
    private boolean isValidTime(String time) {
        if (time == null || time.length() < 4) {
            return false;
        }
        return time.matches("\\d{1,2}:\\d{2}");
    }

    //Filter movies by search term and starting letter
    public List<Movie> filterMovies(String searchTerm, String startingLetter) {
        List<Movie> allMovies = getAllMovies();
        List<Movie> filtered = new ArrayList<>();
        
        String search = searchTerm.toLowerCase();
        
        for (Movie movie : allMovies) {
            String title = movie.getTitle().toLowerCase();
            if (title.contains(search) && 
                (startingLetter.equals("all") || title.startsWith(startingLetter))) {
                filtered.add(movie);
            }
        }
        sortMovies(filtered);
        return filtered;
    }

    //Sort movies by title (case insensitive)
    public void sortMovies(List<Movie> movies) {
        for (int i = 1; i < movies.size(); i++) {
            Movie key = movies.get(i);
            int j = i - 1;
            while (j >= 0 && movies.get(j).getTitle().compareToIgnoreCase(key.getTitle()) > 0) {
                movies.set(j + 1, movies.get(j));
                j--;
            }
            movies.set(j + 1, key);
        }
    }
    

    // sort by nearest future showing date
    public void sortMoviesByNearestDate(List<Movie> movies) {
        for (int i = 1; i < movies.size(); i++) {
            Movie keyMovie = movies.get(i);
            LocalDate keyDate = getNearestFutureDate(keyMovie.getShowingDates());

            int j = i - 1;
            while (j >= 0) {
                LocalDate currentDate = getNearestFutureDate(movies.get(j).getShowingDates());

                if (compareDates(keyDate, currentDate) < 0) {
                    movies.set(j + 1, movies.get(j));
                    j--;
                } else {
                    break;
                }
            }
            movies.set(j + 1, keyMovie);
        }
    }

    // Get the nearest date- future
    private LocalDate getNearestFutureDate(String[] dates) {
        LocalDate today = LocalDate.now();
        LocalDate nearest = null;

        for (String dateStr : dates) {
            if (isValidDate(dateStr)) {
                LocalDate date = LocalDate.parse(dateStr);
                if (!date.isBefore(today)) {
                    if (nearest == null || date.isBefore(nearest)) {
                        nearest = date;
                    }
                }
            }
        }

        return nearest != null ? nearest : LocalDate.MAX;
    }

    // Compare dates
    private int compareDates(LocalDate d1, LocalDate d2) {
        if (d1 == null && d2 == null) return 0;
        if (d1 == null) return 1;
        if (d2 == null) return -1;
        return d1.compareTo(d2);
    }

    public void addMovie(Movie movie) throws IOException {
        File movieFile = new File(movieFilePath);
        movieFile.getParentFile().mkdirs();
        
        try (FileWriter fw = new FileWriter(movieFile, true);
             BufferedWriter bw = new BufferedWriter(fw)) {
            bw.write(movie.toCsvString() + System.lineSeparator());
        }
    }

    public void saveImageToDisk(InputStream inputStream, String fileName, String uploadPath) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try (FileOutputStream outputStream = new FileOutputStream(uploadPath + File.separator + fileName)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
    }
} 