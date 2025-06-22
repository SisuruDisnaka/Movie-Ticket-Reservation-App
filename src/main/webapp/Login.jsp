<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Movie-Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="h-100 bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card p-4 login-card text-white" style="width: 350px;">
        <h3 class="text-center fw-bold mb-4">LOGIN</h3>

        <!-- Display unauthorized access message -->
        <c:if test="${param.error == 'unauthorized'}">
            <div class="alert alert-warning" role="alert">
                <i class="bi bi-shield-exclamation me-2"></i>
                Please log in to access that page
            </div>
        </c:if>

        <!-- Display error message if login failed -->
        <c:if test="${not empty loginError}">
            <div class="alert alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    ${loginError}
                <c:if test="${showRegisterLink}">
                    <div class="mt-2">
                        <a href="Register.jsp" class="btn btn-outline-light btn-sm">Register Now</a>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- Display success message after registration -->
        <c:if test="${not empty registerSuccess}">
            <div class="alert alert-success" role="alert">
                    ${registerSuccess}
                <c:remove var="registerSuccess" scope="session" />
            </div>
        </c:if>

        <form action="login" method="get" >
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Username" name="userName" required>
                <i class="bi bi-person position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3 position-relative">
                <input type="password" class="form-control ps-5" placeholder="Password" name="password" required>
                <i class="bi bi-lock position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <a class="a1-reg" href="#">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-primary w-100 text-dark fw-bold">Login</button>
            <div class="text-center mt-3">
                <small>Don't have an account? <a class="a1-reg" href="Register.jsp">Register</a></small>
            </div>
        </form>
    </div>
</div>
</body>
</html>
