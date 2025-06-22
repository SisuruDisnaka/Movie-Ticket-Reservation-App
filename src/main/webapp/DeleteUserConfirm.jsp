<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm User Deletion</title>
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
                        <li class="custom-list-group-item"><a href="AdminDashboard.jsp">Dashboard</a></li>
                        <li class="custom-list-group-item"><a href="MovieRegister.jsp">Add Movie</a></li>
                        <li class="custom-list-group-item"><a href="movies?letter=all&from=admin">View Movies</a></li>
                        <li class="custom-list-group-item"><a href="Logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-md-9">
            <div class="card glass-card">
                <div class="card-header text-center bg-danger text-white">
                    <h5 class="card-title mb-0">Confirm User Deletion</h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty userToDelete}">
                        <div class="alert alert-danger">User not found</div>
                        <a href="AdminDashboard.jsp" class="btn btn-primary">Return to Dashboard</a>
                    </c:if>

                    <c:if test="${not empty userToDelete}">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            Are you sure you want to delete the following user? This action cannot be undone.
                        </div>

                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">${userToDelete.userName}</h5>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">First Name: ${userToDelete.firstName}</li>
                                    <li class="list-group-item">Last Name: ${userToDelete.lastName}</li>
                                    <li class="list-group-item">Email: ${userToDelete.email}</li>
                                </ul>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <form action="AdminUserServlet" method="post" class="me-2">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="username" value="${userToDelete.userName}">
                                <input type="hidden" name="confirmed" value="yes">
                                <button type="submit" class="btn btn-danger">
                                    <i class="bi bi-trash me-2"></i>Delete User
                                </button>
                            </form>

                            <a href="AdminDashboard.jsp" class="btn btn-secondary">
                                <i class="bi bi-x-circle me-2"></i>Cancel
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 