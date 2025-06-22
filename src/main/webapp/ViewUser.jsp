<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ page import="com.userManage.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Verify admin role
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get user from request attribute (set by AdminUserServlet)
    User userToView = (User) request.getAttribute("viewUser");

    // Redirect if no user
    if (userToView == null) {
        response.sendRedirect("AdminUserServlet?action=list");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card glass-card text-white">
                <div class="card-header bg-primary">
                    <h3 class="card-title mb-0"><i class="bi bi-person-fill"></i> User Details</h3>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-3 d-flex justify-content-center align-items-center">
                            <div class="bg-light rounded-circle p-3 text-center" style="width: 100px; height: 100px;">
                                <i class="bi bi-person-fill text-primary" style="font-size: 4rem;"></i>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <h4><%= userToView.getFirstName() %> <%= userToView.getLastName() %></h4>
                            <p class="text-muted">@<%= userToView.getUserName() %></p>
                        </div>
                    </div>

                    <table class="table table-dark">
                        <tbody>
                        <tr>
                            <th style="width: 30%;">Username</th>
                            <td><%= userToView.getUserName() %></td>
                        </tr>
                        <tr>
                            <th>First Name</th>
                            <td><%= userToView.getFirstName() %></td>
                        </tr>
                        <tr>
                            <th>Last Name</th>
                            <td><%= userToView.getLastName() %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= userToView.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= userToView.getPhone() %></td>
                        </tr>
                        <tr>
                            <th>Age</th>
                            <td><%= userToView.getAge() %></td>
                        </tr>
                        <tr>
                            <th>Role</th>
                            <td><span class="badge bg-info"><%= userToView.isAdmin() ? "Admin" : "User" %></span></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="AdminUserServlet?action=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Back to Dashboard
                        </a>
                        <div>
                            <a href="AdminUserServlet?action=deleteConfirm&username=<%= userToView.getUserName() %>" class="btn btn-danger">
                                <i class="bi bi-trash"></i> Delete User
                            </a>
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