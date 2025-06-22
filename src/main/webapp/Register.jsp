<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Movie-Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="h-100 bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">

<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card p-4 login-card text-white" style="width: 50vw;">
        <h3 class="text-center fw-bold mb-4">Register</h3>

        <!-- Display error message if registration failed -->
        <c:if test="${not empty registerError}">
            <div class="alert alert-danger" role="alert">
                    ${registerError}
            </div>
        </c:if>

        <form action="register" method="post" >
            <div class="row g-3 mb-3"> <!-- g-spacing -->
                <div class="col-md-6 position-relative">
                    <input type="text" class="form-control ps-5" placeholder="First Name" name="firstName" required>
                    <i class="bi bi-person position-absolute top-50 start-0 translate-middle-y ms-3"></i>
                </div>
                <div class="col-md-6 position-relative">
                    <input type="text" class="form-control ps-5" placeholder="Last Name" name="lastName" required>
                    <i class="bi bi-person position-absolute top-50 start-0 translate-middle-y ms-3"></i>
                </div>
            </div>
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Username" name="userName" required>
                <i class="bi bi-person position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3 position-relative">
                <input type="password" class="form-control ps-5" placeholder="Password" name="password" required>
                <i class="bi bi-lock position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3 position-relative">
                <input type="email" class="form-control ps-5" placeholder="Email Address" name="email" required>
                <i class="bi bi-envelope position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="row g-3 mb-3">
                <div class="col-md-6 position-relative">
                    <input type="tel" class="form-control ps-5" placeholder="Phone Number" name="phone" required>
                    <i class="bi bi-phone position-absolute top-50 start-0 translate-middle-y ms-3"></i>
                </div>
                <div class="col-md-6 position-relative">
                    <input type="number" class="form-control ps-5" placeholder="Age" name="age" required min="1" max="120">
                    <i class="bi bi-calendar position-absolute top-50 start-0 translate-middle-y ms-3"></i>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 text-dark fw-bold">Register</button>
        </form>
    </div>
</div>

</body>
</html>

