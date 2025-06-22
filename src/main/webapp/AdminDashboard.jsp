<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="com.userManage.model.User" %>
<%@ page import="com.userManage.factory.UserManagementFactory" %>
<%@ page import="com.userManage.service.UserService" %>
<%@ page import="com.movieManage.Movie" %>
<%@ page import="com.movieManage.MovieManager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>g
k,,hgfmjgfmngfhjmgfm
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String userFile = application.getRealPath("/WEB-INF/users.txt");
    UserService userService = UserManagementFactory.getInstance().createUserService(userFile);

    // Use existing users from request if available, otherwise get from service
    List<User> users;
    if (request.getAttribute("users") != null) {
        users = (List<User>) request.getAttribute("users");
    } else {
        Queue<User> userQueue = userService.getAllUsers();
        users = new ArrayList<>(userQueue);
    }
    int userCount = users.size();

    // Get movies data
    MovieManager movieManager = new MovieManager(application.getRealPath("/WEB-INF/movies.txt"), "movie-images");
    List<Movie> movies = movieManager.getAllMovies();
    int movieCount = movies.size();

    // Check for success or error messages
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3">
            <div class="card glass-card">
                <div class="card-body">
                    <h4 class="card-title text-center">Admin Dashboard</h4>
                    <ul class="list-group">
                        <li class="custom-list-group-item"><a href="AdminUserServlet?action=list">Dashboard</a></li>
                        <li class="custom-list-group-item"><a href="MovieRegister.jsp">Add Movie</a></li>
                        <li class="custom-list-group-item"><a href="movies?letter=all&from=admin">View Movies</a></li>
                        <li class="custom-list-group-item"><a href="Logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-md-9">
            <!-- Message alerts -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Stats Cards -->
            <div class="row">
                <div class="col-md-6">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title">Total Users</h5>
                            <p class="card-text"><strong><%= userCount %></strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title">Total Movies</h5>
                            <p class="card-text"><strong><%= movieCount %></strong></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User List -->
            <div class="row mt-3">
                <div class="col-12">
                    <div class="card glass-card">
                        <div class="card-header text-center bg-blue">
                            <h5 class="card-title mb-0">List of Users</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped text-white">
                                <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Email</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% for (User user : users) { %>
                                <tr>
                                    <td><%= user.getUserName() %></td>
                                    <td><%= user.getFirstName() %></td>
                                    <td><%= user.getLastName() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td>
                                        <a href="AdminUserServlet?action=view&username=<%= user.getUserName() %>" class="btn btn-info btn-sm">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                        <a href="AdminUserServlet?action=deleteConfirm&username=<%= user.getUserName() %>" class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Movie List -->
            <div class="row mt-3">
                <div class="col-12">
                    <div class="card glass-card">
                        <div class="card-header text-center bg-blue">
                            <h5 class="card-title mb-0">List of Movies</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped text-white">
                                <thead>
                                <tr>
                                    <th>Movie</th>
                                    <th>Director</th>
                                    <th>Cast</th>
                                    <th>Showtimes</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% for (Movie movie : movies) { %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="<%= movie.getImagePath() %>" alt="<%= movie.getTitle() %>" class="me-2" style="height: 50px; width: 40px; object-fit: cover;">
                                            <span><%= movie.getTitle() %></span>
                                        </div>
                                    </td>
                                    <td><%= movie.getDirector() %></td>
                                    <td><%= movie.getMainCharacter() %></td>
                                    <td>
                                        <%
                                            String[] dates = movie.getShowingDates();
                                            String[] times = movie.getTimeSlots();
                                            int showCount = Math.min(dates.length, times.length);

                                            for (int i = 0; i < showCount; i++) {
                                                if (i > 0) { %><br><% } %>
                                        <%= dates[i] %> - <%= times[i] %>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="EditMovie.jsp?title=<%= movie.getTitle() %>" class="btn btn-warning btn-sm">
                                            <i class="bi bi-pencil"></i> Edit
                                        </a>
                                        <form action="DeleteMovieServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="title" value="<%= movie.getTitle() %>">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Manage Movies -->
            <div class="row mt-3">
                <div class="col-12">
                    <div class="card glass-card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Manage Movies</h5>
                            <a href="MovieRegister.jsp" class="btn btn-success"><i class="bi bi-plus-circle me-2"></i>Add Movie</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
