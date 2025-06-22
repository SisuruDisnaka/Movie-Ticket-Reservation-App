<%@ page import="java.util.List" %>
<%@ page import="com.Review_and_Feedback.model.Review" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Reviews</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="h-100 bg-Reviews" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: lighten;">
<div class="container py-5">
  <div class="feedback-card">
    <h4 class="ms-3" style="color: black; font-weight: bold;">Customer Feedback</h4>

    <div class="form-container">
      <img src="images/img2.jpg" class="img-fluid mb-3" alt="Movie Poster">




      <div class="form-content">
        <h1 class="fw-bold" style="text-align: left; font-size:65px;">Spider Man</h1>

        <div class="review-container">
          <%
            List<Review> reviews = (List<Review>) request.getAttribute("reviews");
            if (reviews != null && !reviews.isEmpty()) {
              for (Review review : reviews) {
          %>
          <div class="review mb-3">
            <h6 class="mb-0" style="color: black; font-weight: bold;"><%= review.getMovieName() %></h6>
            <p class="small text-muted" style="color: black; font-weight: bold;">Rating: <%= review.getRating() %>/5 <br> <%= review.getComment() %></p>

          </div>
          <%
            }
          } else {
          %>
          <p style="color: black; font-weight: bold;">No reviews available.</p>
          <%
            }
          %>

          <form action="readFeedback" method="get">

            <button type="submit" class=" btn-primary ">Latest Reviews</button>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>
</body>
</html>
