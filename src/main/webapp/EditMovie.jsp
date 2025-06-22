<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ page import="com.movieManage.Movie" %>
<%@ page import="com.movieManage.MovieManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>

<%
    // Check if user is admin
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String movieTitle = request.getParameter("title");
    if (movieTitle == null) {
        response.sendRedirect("AdminDashboard.jsp");
        return;
    }

    // Get the movie data
    MovieManager movieManager = new MovieManager(getServletContext().getRealPath("/WEB-INF/movies.txt"), "movie-images");
    List<Movie> allMovies = movieManager.getAllMovies();

    Movie movieToEdit = null;
    for (Movie movie : allMovies) {
        if (movie.getTitle().equals(movieTitle)) {
            movieToEdit = movie;
            break;
        }
    }

    if (movieToEdit == null) {
        response.sendRedirect("AdminDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Movie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="h-100 bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">

<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card p-4 login-card text-white" style="width: 50vw;">
        <h3 class="text-center fw-bold mb-4">Edit Movie: <%= movieToEdit.getTitle() %></h3>
        
        <!-- You would need to create an UpdateMovieServlet to handle the form submission -->
        <form action="UpdateMovieServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="originalTitle" value="<%= movieToEdit.getTitle() %>">
            
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Movie Name" name="movieName" value="<%= movieToEdit.getTitle() %>" required>
                <i class="bi bi-film position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Director" name="director" value="<%= movieToEdit.getDirector() %>" required>
                <i class="bi bi-person-video3 position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Main Character(s)" name="mainCharacter" value="<%= movieToEdit.getMainCharacter() %>" required>
                <i class="bi bi-people-fill position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Current Image</label>
                <div class="mb-2">
                    <img src="<%= movieToEdit.getImagePath() %>" alt="<%= movieToEdit.getTitle() %>" style="height: 100px; object-fit: cover;">
                </div>
                <label class="form-label">Upload New Image (optional)</label>
                <input type="file" class="form-control" name="image" accept="image/*">
            </div>
            
            <div class="row g-2 mb-3">
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Premium Ticket Price" name="pricePremium" 
                           value="<%= movieToEdit.getPricePremium() %>" required>
                </div>
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Boutique Ticket Price" name="priceBoutique"
                           value="<%= movieToEdit.getPriceBoutique() %>" required>
                </div>
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Standard Ticket Price" name="priceStandard"
                           value="<%= movieToEdit.getPriceStandard() %>" required>
                </div>
            </div>

            <div id="timeSlotsContainer" class="mb-3">
                <label class="form-label">Showing Dates, Time Slots & Screens</label>
                
                <% 
                String[] dates = movieToEdit.getShowingDates();
                String[] times = movieToEdit.getTimeSlots();
                String[] screens = movieToEdit.getScreens();
                int showCount = Math.min(Math.min(dates.length, times.length), screens.length);
                
                for (int i = 0; i < showCount; i++) { 
                %>
                <div class="row g-2 mb-2 align-items-center">
                    <div class="col-md-4">
                        <input type="date" class="form-control" name="showingDates[]" 
                               value="<%= dates[i].equals("Not specified") || dates[i].equals("Not available") ? "" : dates[i] %>" required>
                    </div>
                    <div class="col-md-3">
                        <input type="time" class="form-control" name="timeSlots[]" 
                               value="<%= times[i].equals("Not specified") || times[i].equals("Not available") ? "" : times[i] %>" required>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="screens[]" required>
                            <option value="">Select Screen</option>
                            <option value="Premium" <%= "Premium".equals(screens[i]) ? "selected" : "" %>>Premium</option>
                            <option value="Boutique" <%= "Boutique".equals(screens[i]) ? "selected" : "" %>>Boutique</option>
                            <option value="Standard" <%= "Standard".equals(screens[i]) ? "selected" : "" %>>Standard</option>
                        </select>
                    </div>
                    <% if (i > 0) { %>
                    <div class="col-md-2 text-end">
                        <button type="button" class="btn btn-danger" onclick="removeSlot(this)">&times;</button>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <button type="button" class="btn btn-outline-light mb-3" onclick="addTimeSlot()">+ Add Slot</button>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary text-dark fw-bold">Update Movie</button>
                <a href="AdminDashboard.jsp" class="btn btn-outline-light">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
    function addTimeSlot() {
        const container = document.getElementById('timeSlotsContainer');
        const row = document.createElement('div');
        row.classList.add('row', 'g-2', 'mb-2', 'align-items-center');

        row.innerHTML = `
      <div class="col-md-4">
        <input type="date" class="form-control" name="showingDates[]" required>
      </div>
      <div class="col-md-3">
        <input type="time" class="form-control" name="timeSlots[]" required>
      </div>
      <div class="col-md-3">
          <select class="form-select" name="screens[]" required>
            <option value="">Select Screen</option>
            <option value="Premium">Premium</option>
            <option value="Boutique">Boutique</option>
            <option value="Standard">Standard</option>
          </select>
      </div>
      <div class="col-md-2 text-end">
        <button type="button" class="btn btn-danger" onclick="removeSlot(this)">&times;</button>
      </div>
    `;

        container.appendChild(row);
    }

    function removeSlot(button) {
        const row = button.closest('.row');
        row.remove();
    }
</script>

</body>
</html> 