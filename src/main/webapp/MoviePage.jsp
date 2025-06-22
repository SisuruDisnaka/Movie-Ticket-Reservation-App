<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.movieManage.Movie" %>
<%@ page import="java.time.format.DateTimeParseException" %>
<%@ page import="java.time.LocalDate" %>


<%
    // Authentication check - only allow logged-in users (both users and admins)
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !(role.equals("user") || role.equals("admin"))) {
        response.sendRedirect("Login.jsp?error=unauthorized");
        return;
    }

    // Check if user is coming from admin dashboard
    boolean fromAdmin = "admin".equals(request.getParameter("from")) && "admin".equals(role);

    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    if (movies == null) movies = java.util.Collections.emptyList();

    String selectedLetter = request.getParameter("letter");
    if (selectedLetter == null) selectedLetter = "all";
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Movie Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>
<body class="h-100 bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
<% if (!fromAdmin) { %>
<%@include file="WEB-INF/jspSC/header.jsp"%>
<% } else { %>
<!-- Admin navigation bar -->
<div class="container-fluid">
    <div class="row py-3">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="text-white mb-0">Movie Management</h3>
                <a href="AdminDashboard.jsp" class="btn btn-outline-light">
                    <i class="bi bi-arrow-left-circle me-2"></i>Return to Admin Dashboard
                </a>
            </div>
        </div>
    </div>
</div>
<% } %>

<div class="container py-4">

    <br>
    <!-- Search Bar -->
    <form method="get" action="movies" class="mb-4">
        <input type="hidden" name="from" value="<%= fromAdmin ? "admin" : "" %>">
        <div class="d-flex justify-content-start ms-5" style="max-width: 400px;">

            <div class="input-group mb-3 w-100">
                <input type="text" name="search" class="form-control"
                       placeholder="Search for a movie..."
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </div>
        </div>

        <!-- Alphabet filter buttons -->
        <div class="d-flex justify-content-center flex-wrap mb-4">
            <div class="btn-group">
                <a href="movies?letter=all<%= fromAdmin ? "&from=admin" : "" %><%= request.getParameter("search") != null ? "&search=" + request.getParameter("search") : "" %>"
                   class="btn <%= "all".equals(selectedLetter) ? "btn-primary" : "btn-outline-light" %>">All</a>
                <% for (char c = 'A'; c <= 'Z'; c++) {
                    String current = String.valueOf(c).toLowerCase(); %>
                <a href="movies?letter=<%= current %><%= fromAdmin ? "&from=admin" : "" %><%= request.getParameter("search") != null ? "&search=" + request.getParameter("search") : "" %>"
                   class="btn <%= current.equals(selectedLetter) ? "btn-primary" : "btn-outline-light" %>"><%= c %></a>
                <% } %>
            </div>
        </div>

        <!-- Sort by Date Button -->
        <div class="d-flex justify-content-center mb-4">
            <div class="btn-group">
                <%
                    boolean isSortedByDate = request.getAttribute("sortByDate") != null && (Boolean)request.getAttribute("sortByDate");
                    String currentParams = "letter=" + selectedLetter +
                            (fromAdmin ? "&from=admin" : "") +
                            (request.getParameter("search") != null ? "&search=" + request.getParameter("search") : "");
                %>
                <a href="movies?<%= currentParams %>"
                   class="btn <%= !isSortedByDate ? "btn-primary" : "btn-outline-light" %>">
                    <i class="bi bi-sort-alpha-down"></i> Sort by Title
                </a>
                <a href="movies?<%= currentParams %>&sortByDate=true"
                   class="btn <%= isSortedByDate ? "btn-primary" : "btn-outline-light" %>"
                   data-bs-toggle="tooltip" data-bs-placement="bottom"
                   title="Sorts movies by their nearest show date">
                    <i class="bi bi-calendar-date"></i> Sort by Nearest
                </a>
            </div>
        </div>
    </form>

    <!-- Movie Grid -->
    <div class="row">
        <% for (Movie movie : movies) { %>
        <div class="col-md-4 mb-4">
            <div class="card bg-dark text-white h-100">
                <img src="<%= movie.getImagePath() %>" class="card-img-top" alt="<%= movie.getTitle() %>" style="height: 300px; object-fit: cover;">
                <div class="card-body">
                    <h5 class="card-title text-center"><%= movie.getTitle() %></h5>
                    <% if (movie.getDirector() != null && !movie.getDirector().isEmpty()) { %>
                    <p class="card-text"><i class="bi bi-person-video3"></i> Director: <%= movie.getDirector() %></p>
                    <% } %>
                    <% if (movie.getMainCharacter() != null && !movie.getMainCharacter().isEmpty()) { %>
                    <p class="card-text"><i class="bi bi-people-fill"></i> Cast: <%= movie.getMainCharacter() %></p>
                    <% } %>

                    <% if (movie.getShowingDates() != null && movie.getShowingDates().length > 0 &&
                            movie.getTimeSlots() != null && movie.getTimeSlots().length > 0 &&
                            movie.getScreens() != null && movie.getScreens().length > 0) { %>
                    <h6 class="mt-3 mb-2"><i class="bi bi-calendar-event"></i> Upcoming Shows:</h6>

                    <%


                        String[] dates = movie.getShowingDates();
                        String[] times = movie.getTimeSlots();
                        String[] screens = movie.getScreens();

                        LocalDate today = LocalDate.now();
                        LocalDate nearestDate = null;
                        int nearestDateIndex = -1;

                        if (isSortedByDate && dates != null) {
                            for (int i = 0; i < dates.length; i++) {
                                String dateStr = dates[i];
                                if (dateStr != null && dateStr.matches("\\d{4}-\\d{2}-\\d{2}")) {
                                    try {
                                        LocalDate date = LocalDate.parse(dateStr);
                                        if (!date.isBefore(today)) {  // today or future
                                            if (nearestDate == null || date.isBefore(nearestDate)) {
                                                nearestDate = date;
                                                nearestDateIndex = i;
                                            }
                                        }
                                    } catch (DateTimeParseException e) {
                                        // invalid date format, skip
                                    }
                                }
                            }

                            // If no future date found, mark all dates as after today by setting nearestDateIndex = -1 or handle fallback
                            if (nearestDate == null) {
                                nearestDateIndex = -1;
                            }
                        }
                    %>


                    <div class="table-responsive small">
                        <table class="table table-sm table-dark">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Screen</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                // Display up to 3 showtimes initially
                                int showCount = Math.min(Math.min(dates.length, times.length), screens.length);
                                int displayCount = Math.min(showCount, 3);

                                for (int i = 0; i < displayCount; i++) { %>
                            <tr <%= (isSortedByDate && i == nearestDateIndex) ? "class=\"table-primary text-dark fw-bold\"" : "" %>>
                                <td>
                                    <%= dates[i] %>
                                    <% if (isSortedByDate && i == nearestDateIndex) { %>
                                    <i class="bi bi-sort-numeric-down ms-1" data-bs-toggle="tooltip" title="This is the nearest date for screen"></i>
                                    <% } %>
                                </td>
                                <td><%= times[i] %></td>
                                <td><%= screens[i] %></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% if (showCount > 3) { %>
                    <button class="btn btn-sm btn-outline-light w-100 mt-2" type="button" data-bs-toggle="modal" data-bs-target="#showtimesModal<%= movie.getTitle().replaceAll("\\s+", "") %>">
                        View All Showtimes
                    </button>

                    <!-- Modal for all showtimes -->
                    <div class="modal fade" id="showtimesModal<%= movie.getTitle().replaceAll("\\s+", "") %>" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content bg-dark text-white">
                                <div class="modal-header">
                                    <h5 class="modal-title"><%= movie.getTitle() %> - All Showtimes</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="table-responsive">
                                        <table class="table table-dark">
                                            <thead>
                                            <tr>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>Screen</th>
                                                <th>Price</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <% for (int i = 0; i < showCount; i++) {
                                                String screenType = screens[i];
                                                double price = 0.0;
                                                if ("Premium".equals(screenType)) {
                                                    price = movie.getPricePremium();
                                                } else if ("Boutique".equals(screenType)) {
                                                    price = movie.getPriceBoutique();
                                                } else if ("Standard".equals(screenType)) {
                                                    price = movie.getPriceStandard();
                                                }
                                            %>
                                            <tr <%= (isSortedByDate && i == nearestDateIndex) ? "class=\"table-primary text-dark fw-bold\"" : "" %>>
                                                <td>
                                                    <%= dates[i] %>
                                                    <% if (isSortedByDate && i == nearestDateIndex) { %>
                                                    <i class="bi bi-sort-numeric-down ms-1" data-bs-toggle="tooltip" title="This is the newest date used for sorting"></i>
                                                    <% } %>
                                                </td>
                                                <td><%= times[i] %></td>
                                                <td><%= screenType %></td>
                                                <td>Rs <%= String.format("%.2f", price) %></td>
                                            </tr>
                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% }
                    else { %>
                    <p class="card-text small fst-italic text-muted">No showtimes available</p>
                    <% } %>

                    <div class="d-grid gap-2 mt-3">
                        <a href="movie?id=<%= movies.indexOf(movie) + 1 %>" class="btn btn-primary">Book Tickets</a>

                        <% if (role != null && role.equals("admin")) { %>
                        <div class="d-flex justify-content-between mt-2">
                            <a href="EditMovie.jsp?title=<%= movie.getTitle() %>" class="btn btn-warning w-100 me-1">
                                <i class="bi bi-pencil"></i> Edit
                            </a>
                            <a href="DeleteMovieServlet?title=<%= movie.getTitle() %>"
                               class="btn btn-danger w-100 ms-1"
                               onclick="return confirm('Are you sure you want to delete <%= movie.getTitle() %>?')">
                                <i class="bi bi-trash"></i> Delete
                            </a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize tooltips
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>
</body>
</html>
