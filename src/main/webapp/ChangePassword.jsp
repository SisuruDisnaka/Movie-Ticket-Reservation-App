<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (user == null || !"user".equals(role)) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Check for success message from servlet
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
        request.setAttribute("successMessage", successMessage);
        session.removeAttribute("successMessage"); // clear it after use
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Change Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="bg-hero d-flex flex-column" style="min-height: 100vh; background-color: rgba(0,0,0,0.7); background-blend-mode: darken;">
<%@ include file="WEB-INF/jspSC/header.jsp"%>

<div class="container d-flex justify-content-center align-items-center flex-grow-1">
    <div class="card login-card text-white p-5" style="max-width: 600px; width: 100%; border-radius: 20px; background-color: rgba(255,255,255,0.32)">
        <h2 class="text-center mb-4">Change Password</h2>

        <!-- Success message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>

        <!-- Main error message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="ChangePasswordServlet" method="POST">
            <div class="mb-3">
                <label for="oldPassword" class="form-label">Current Password</label>
                <input type="password" class="form-control ${not empty error_oldPassword ? 'is-invalid' : ''}"
                       id="oldPassword" name="oldPassword" required />
                <c:if test="${not empty error_oldPassword}">
                    <div class="invalid-feedback">${error_oldPassword}</div>
                </c:if>
            </div>
            <div class="mb-3">
                <label for="newPassword" class="form-label">New Password</label>
                <input type="password" class="form-control ${not empty error_newPassword || not empty error_strength ? 'is-invalid' : ''}"
                       id="newPassword" name="newPassword" required />
                <c:if test="${not empty error_newPassword}">
                    <div class="invalid-feedback">${error_newPassword}</div>
                </c:if>
                <c:if test="${not empty error_strength}">
                    <div class="invalid-feedback">${error_strength}</div>
                </c:if>
                <small class="form-text text-muted">Password must be at least 8 characters long</small>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                <input type="password" class="form-control ${not empty error_confirmPassword || not empty error_match ? 'is-invalid' : ''}"
                       id="confirmPassword" name="confirmPassword" required />
                <c:if test="${not empty error_confirmPassword}">
                    <div class="invalid-feedback">${error_confirmPassword}</div>
                </c:if>
                <c:if test="${not empty error_match}">
                    <div class="invalid-feedback">${error_match}</div>
                </c:if>
            </div>

            <button type="submit" class="btn btn-primary w-100">Change Password</button>
        </form>
    </div>
</div>
</body>
</html>
