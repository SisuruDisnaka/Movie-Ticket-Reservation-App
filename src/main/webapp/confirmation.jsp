<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation | PopComPulse</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <%@include file="WEB-INF/jspSC/header.jsp"%>

    <div class="confirmation-container">
        <div class="confirmation-card">
            <div class="confirmation-header">
                <i class="fas fa-check-circle"></i>
                <h1>Booking Confirmed!</h1>
            </div>
            
            <div class="ticket-details">
                <h2>${param.movie}</h2>
                <p><strong>Date:</strong> ${param.date}</p>
                <p><strong>Time:</strong> ${param.time}</p>
                <p><strong>Theater:</strong> ${param.screenType}</p>
                <p><strong>Seats:</strong> ${param.seats}</p>
                <p><strong>Total Price:</strong> LKR ${param.price}</p>
            </div>
            
            <div class="ticket-actions">
                <p>Your ticket has been sent to your registered email.</p>
                <a href="add-movie-to-cart?movie=${param.movie}&date=${param.date}&time=${param.time}&theater=${param.screenType}&seats=${param.seats}&price=${param.price}" class="btn-home">Order Your Food</a>
            </div>
        </div>
    </div>

    <%@include file="WEB-INF/jspSC/footer.jsp"%>
</body>
</html> 