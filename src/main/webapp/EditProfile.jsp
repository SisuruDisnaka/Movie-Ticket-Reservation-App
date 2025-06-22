<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (user == null || !"user".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="bg-hero d-flex flex-column" style="min-height: 100vh; background-color: rgba(0,0,0,0.7); background-blend-mode: darken;">
<%@ include file="WEB-INF/jspSC/header.jsp"%>

<div class="container d-flex justify-content-center align-items-center flex-grow-1">

    <div class="card login-card p-5 text-white" style="width: 600px; border-radius: 20px; background-color: rgba(255,255,255,0.32)">
        <h3 class="text-center mb-4"><i class="bi bi-pencil-square me-2"></i>Edit Profile</h3>

        <form action="UpdateProfileServlet" method="post">
            <div class="mb-3">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" class="form-control" id="firstName" name="firstName" value="${firstName}" required>
            </div>
            <div class="mb-3">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" class="form-control" id="lastName" name="lastName" value="${lastName}" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" value="${email}" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${phone}" required>
            </div>
            <div class="mb-3">
                <label for="age" class="form-label">Age</label>
                <input type="number" class="form-control" id="age" name="age" value="${age}" required>
            </div>

            <div class="d-flex justify-content-between">
                <a href="UserProfileServlet" class="btn btn-outline-light"><i class="bi bi-arrow-left me-1"></i>Cancel</a>
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-circle me-1"></i>Save Changes</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
