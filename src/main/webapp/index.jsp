<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Movies</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body>
<%@include file="WEB-INF/jspSC/header.jsp"%>
<section class="bg-hero d-flex align-items-center justify-content-center text-white text-center" style="height: 80vh; background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">
    <div class="#">
        <h1 class="display-4 fw-bold">PopCornPulse</h1>
        <p class="lead">Streamline Your Movie Night - Book in Seconds</p>
        <div class="mt-4">
            <a href="Login.jsp" class="btn btn-primary me-2"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
            <a href="Register.jsp" class="btn btn-outline-light"><i class="fas fa-user-plus me-2"></i>Register</a>
        </div>
    </div>
</section>

<%@include file="WEB-INF/jspSC/footer.jsp"%>

</body>
</html>
