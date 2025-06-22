<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Include Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Include Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!-- Include Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
  /* Override for extra visible navigation */
  .navbar .nav-link {
    color: #FFFFFF !important;
    font-weight: 900 !important;
    text-shadow: 0 0 3px rgba(0,0,0,0.5);
    letter-spacing: 0.5px;
  }
  
  .navbar-brand span {
    color: #FFFFFF !important;
    font-weight: 900 !important;
    text-shadow: 0 0 4px rgba(0,0,0,0.6);
    letter-spacing: 0.5px;
  }
</style>

<header>
  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="home.jsp">
        <span class="ms-2 fw-bold text-white">PopComPulse</span>
      </a>
      
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <i class="fas fa-bars text-white"></i>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item mx-2">
            <a class="nav-link" href="home.jsp">
              <i class="fas fa-home me-1"></i> HOME
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link" href="movies?letter=all">
              <i class="fas fa-film me-1"></i> MOVIES
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link" href="purchasedTickets.jsp">
              <i class="fas fa-ticket-alt me-1"></i> TICKETS
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link" href="Cart.jsp">
              <i class="fas fa-shopping-cart me-1"></i> CART
            </a>
          </li>
          <li class="nav-item mx-2">
            <a class="nav-link" href="UserProfileServlet">
              <i class="fas fa-user-circle me-1"></i> PROFILE
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<!-- Include Bootstrap JS at the end to ensure proper functionality for mobile toggle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>