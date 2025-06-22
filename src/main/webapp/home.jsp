<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.movieManage.Movie" %>
<%@ page import="com.movieManage.MovieManager" %>

<%
    // Get today's date
    LocalDate today = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String todayString = today.format(formatter);
    
    // Initialize MovieManager and get all movies
    String movieFilePath = application.getRealPath("/WEB-INF/movies.txt");
    MovieManager movieManager = new MovieManager(movieFilePath, "movie-images");
    List<Movie> allMovies = movieManager.getAllMovies();
    
    // Separate movies into "Now Showing" and "Coming Soon" categories
    List<Movie> nowShowingMovies = new ArrayList<>();
    List<Movie> comingSoonMovies = new ArrayList<>();
    
    for (Movie movie : allMovies) {
        boolean hasCurrentOrFutureShow = false;
        boolean hasOnlyFutureShows = true;
        
        String[] showingDates = movie.getShowingDates();
        if (showingDates != null && showingDates.length > 0) {
            for (String date : showingDates) {
                // Skip invalid dates
                if (date == null || !date.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    continue;
                }
                
                // Compare with today's date
                int comparison = date.compareTo(todayString);
                
                // Current or future show date (today or later)
                if (comparison >= 0) {
                    hasCurrentOrFutureShow = true;
                } else {
                    // Has at least one past date
                    hasOnlyFutureShows = false;
                }
            }
        }
        
        // Add to appropriate category
        if (hasCurrentOrFutureShow) {
            if (hasOnlyFutureShows) {
                comingSoonMovies.add(movie);
            } else {
                nowShowingMovies.add(movie);
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>PopComPulse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="stylesheet.css">
    <style>
        .glass-effect {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .section-title {
            background: linear-gradient(45deg, #00c6ff, #0072ff);
            color: white;
            border-radius: 10px;
            padding: 10px 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 114, 255, 0.3);
        }
        
        .movie-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 198, 255, 0.3);
        }
        
        .badge.bg-primary {
            background: linear-gradient(45deg, #00c6ff, #0072ff) !important;
        }
        
        .now-showing-section {
            background: linear-gradient(135deg, rgba(0, 114, 255, 0.1), rgba(0, 190, 214, 0.15));
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 5px solid #0072ff;
        }
        
        .coming-soon-section {
            background: linear-gradient(135deg, rgba(112, 48, 160, 0.1), rgba(192, 53, 162, 0.15));
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            border-left: 5px solid #8e44ad;
        }
        
        .coming-soon-title {
            background: linear-gradient(45deg, #8e44ad, #c0392b);
            color: white;
            border-radius: 10px;
            padding: 10px 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(142, 68, 173, 0.3);
        }
    </style>
</head>
<body>
<%@include file="WEB-INF/jspSC/header.jsp"%>

<section class="bg-hero d-flex align-items-center justify-content-center text-white text-center" style="height: 80vh; background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
    <div class="hero-content">
        <h1 class="display-4 fw-bold">PopComPulse</h1>
        <p class="lead mb-4">Streamline Your Movie Night - Book In Seconds</p>
        <a href="movies?letter=all" class="btn btn-primary btn-lg">
            <i class="fas fa-ticket-alt me-2"></i>Book Now
        </a>
    </div>
</section>

<section class="container py-5">
    <div class="now-showing-section">
        <div class="row">
            <div class="col-12">
                <div class="section-title d-flex justify-content-between align-items-center mb-4">
                    <h2 class="m-0"><i class="fas fa-film me-2"></i>Now Showing</h2>
                    <a href="movies" class="btn btn-outline-light">View All</a>
                </div>
            </div>
        </div>

        <div class="row">
            <% 
            if (nowShowingMovies.isEmpty()) {
            %>
                <div class="col-12 text-center text-white glass-effect p-5">
                    <p class="fs-5"><i class="fas fa-exclamation-circle me-2"></i>No movies currently showing. Check back soon!</p>
                </div>
            <% 
            } else {
                // Display up to 3 now showing movies
                int limit = Math.min(nowShowingMovies.size(), 4);
                for (int i = 0; i < limit; i++) {
                    Movie movie = nowShowingMovies.get(i);
                    String[] dates = movie.getShowingDates();
                    String[] times = movie.getTimeSlots();
                    String[] screens = movie.getScreens();
            %>
            <div class="col-md-3 mb-4">
                <div class="card bg-dark text-white h-100 glass-effect" style="min-height: 400px;">
                    <img src="<%= movie.getImagePath() %>" class="card-img-top" alt="<%= movie.getTitle() %>" style="height: 200px; object-fit: cover; border-top-left-radius: 15px; border-top-right-radius: 15px;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-center fs-6"><%= movie.getTitle() %></h5>
                        <p class="card-text small"><i class="bi bi-person-video3 me-1"></i>Director: <%= movie.getDirector() %></p>
                        <p class="card-text small"><i class="bi bi-people-fill me-1"></i>Cast: <%= movie.getMainCharacter() %></p>
                        
                        <div class="mt-auto">
                            <div class="d-grid gap-2">
                                <a href="movie?id=<%= i + 1 %>" class="btn btn-primary btn-sm">
                                    <i class="fas fa-ticket-alt me-1"></i>Book Tickets
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                }
            } 
            %>
        </div>
    </div>
</section>

<section class="container pb-5">
    <div class="coming-soon-section">
        <div class="row">
            <div class="col-12">
                <div class="coming-soon-title d-flex justify-content-between align-items-center mb-4">
                    <h2 class="m-0"><i class="fas fa-calendar-alt me-2"></i>Coming Soon</h2>
                    <a href="movies?filter=coming" class="btn btn-outline-light">View All</a>
                </div>
            </div>
        </div>

        <div class="row">
            <% 
            if (comingSoonMovies.isEmpty()) {
            %>
                <div class="col-12 text-center text-white glass-effect p-5">
                    <p class="fs-5"><i class="fas fa-exclamation-circle me-2"></i>No upcoming movies scheduled. Check back soon!</p>
                </div>
            <% 
            } else {
                // Display up to 4 coming soon movies
                int limit = Math.min(comingSoonMovies.size(), 4);
                for (int i = 0; i < limit; i++) {
                    Movie movie = comingSoonMovies.get(i);
                    String[] dates = movie.getShowingDates();
                    
                    // Find first valid future date for release date
                    String releaseDate = "TBD";
                    if (dates != null && dates.length > 0) {
                        for (String date : dates) {
                            if (date != null && date.matches("\\d{4}-\\d{2}-\\d{2}") && 
                                date.compareTo(todayString) >= 0) {
                                releaseDate = date;
                                break;
                            }
                        }
                    }
                    
                    // Format the date nicely for display
                    try {
                        if (!releaseDate.equals("TBD")) {
                            LocalDate releaseDateObj = LocalDate.parse(releaseDate);
                            releaseDate = releaseDateObj.format(DateTimeFormatter.ofPattern("MMMM d, yyyy"));
                        }
                    } catch (Exception e) {
                        // Keep original format if parsing fails
                    }
            %>
            <div class="col-md-3 mb-4">
                <div class="card bg-dark text-white h-100 glass-effect" style="min-height: 400px;">
                    <img src="<%= movie.getImagePath() %>" class="card-img-top" alt="<%= movie.getTitle() %>" style="height: 200px; object-fit: cover; border-top-left-radius: 15px; border-top-right-radius: 15px;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-center fs-6"><%= movie.getTitle() %></h5>
                        <p class="card-text small"><i class="bi bi-person-video3 me-1"></i>Director: <%= movie.getDirector() %></p>
                        <p class="card-text small"><i class="bi bi-people-fill me-1"></i>Cast: <%= movie.getMainCharacter() %></p>
                        
                        <p class="card-text mt-2 small">
                            <i class="fas fa-calendar-check me-1"></i>Release: <span class="badge bg-primary"><%= releaseDate %></span>
                        </p>
                        
                        <div class="mt-auto">
                            <div class="d-grid gap-2">
                                <a href="MoviePage.jsp" class="btn btn-outline-light btn-sm">
                                    <i class="fas fa-bell me-1"></i>Notify Me
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                }
            } 
            %>
        </div>
    </div>
</section>

<%@include file="WEB-INF/jspSC/footer.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>