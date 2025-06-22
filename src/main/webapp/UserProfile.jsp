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
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>User Profile</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="bg-hero d-flex flex-column" style="min-height: 100vh; background-color: rgba(0,0,0,0.7); background-blend-mode: darken;">
<%@ include file="WEB-INF/jspSC/header.jsp" %>

<!-- Container to center profile card vertically -->
<div class="container d-flex justify-content-center align-items-center flex-grow-1">
  <!-- Success message alert -->
  <c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-4" style="z-index: 1050">
      <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <div class="card login-card text-white p-5" style="max-width: 1000px; width: 100%; border-radius: 20px; background-color: rgba(255,255,255,0.32)">
    <div class="row g-0">
      <!-- Profile Image & Username -->
      <div class="col-md-4 d-flex flex-column align-items-center justify-content-center text-center border-end">
        <i class="bi bi-person-circle display-1 mb-3"></i>
        <h3 class="fw-bold"><%= user %></h3>
        <p class="fst-italic text-muted">Role: <%= role %></p>
        <a href="EditProfileServlet" class="btn btn-outline-info mt-3"><i class="bi bi-pencil me-1"></i>Edit Profile</a>
      </div>

      <!-- Profile Details -->
      <div class="col-md-8 px-4">
        <h2 class="mt-2 mb-4 border-bottom pb-2">Profile Information</h2>

        <!-- Debug information - will show in the browser for troubleshooting -->
        <%
          System.out.println("JSP - Rendering profile data:");
          System.out.println("  firstName: " + request.getAttribute("firstName"));
          System.out.println("  lastName: " + request.getAttribute("lastName"));
          System.out.println("  email: " + request.getAttribute("email"));
        %>

        <div class="row mb-3">
          <div class="col-sm-6 text-white">
            <div class="d-flex justify-content-between">
              <span><i class="bi bi-person-fill me-2"></i>First Name</span>
              <span class="text-white">${firstName}</span>
            </div>
          </div>
          <div class="col-sm-6 text-white">
            <div class="d-flex justify-content-between">
              <span><i class="bi bi-person-fill me-2"></i>Last Name</span>
              <span class="text-white">${lastName}</span>
            </div>
          </div>
        </div>

        <ul class="list-group list-group-flush text-white">
          <li class="list-group-item bg-transparent d-flex justify-content-between">
            <span><i class="bi bi-envelope-fill me-2"></i>Email</span>
            <span>${email}</span>
          </li>
          <li class="list-group-item bg-transparent d-flex justify-content-between">
            <span><i class="bi bi-telephone-fill me-2"></i>Phone</span>
            <span>${phone}</span>
          </li>
          <li class="list-group-item bg-transparent d-flex justify-content-between">
            <span><i class="bi bi-calendar-fill me-2"></i>Age</span>
            <span>${age}</span>
          </li>
        </ul>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-between mt-4">
          <a href="ChangePassword.jsp" class="btn btn-outline-light"><i class="bi bi-lock-fill me-1"></i>Change Password</a>
          <a href="Logout.jsp" class="btn btn-primary"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Auto-dismiss toasts after 3 seconds
  document.addEventListener('DOMContentLoaded', function() {
    const toasts = document.querySelectorAll('.toast.show');
    toasts.forEach(toast => {
      setTimeout(() => {
        toast.classList.remove('show');
      }, 3000);
    });
  });
</script>
</body>
</html>
