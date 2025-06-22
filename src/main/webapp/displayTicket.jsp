<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Ticket | PopComPulse</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px;
        }

        .ticket-section {
            width: 550px;
            margin: auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .ticket-section h2 {
            margin-bottom: 10px;
            color: #28a745;
        }

        .ticket-section .ticket-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .ticket-section hr {
            margin: 15px 0;
            border: none;
            border-top: 1px solid #ddd;
        }

        .ticket-section .details {
            text-align: left;
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .ticket-section .detail-row {
            margin-bottom: 10px;
            display: flex;
        }

        .ticket-section .detail-label {
            font-weight: 600;
            width: 120px;
        }

        .ticket-section .detail-value {
            flex: 1;
        }

        .ticket-section button {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            background-color: #283da2;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .ticket-section p {
            margin-top: 15px;
            font-size: 12px;
            color: #666;
        }

        .action-btn {
            display: block;
            width: 100%;
            padding: 14px 0;
            background-color: #0e355c;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.5s;
            margin: 0 0 15px 0;
            text-decoration: none;
        }

        .action-btn:hover {
            background-color: #3b488c;
        }

        .ticket-qr {
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .qr-code {
            width: 150px;
            height: 150px;
            margin: 0 auto;
            background: #fff;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .ticket-id {
            background: rgba(0, 0, 0, 0.1);
            padding: 8px 15px;
            border-radius: 50px;
            font-size: 14px;
            color: #333;
            display: inline-block;
            margin-bottom: 20px;
        }

        .movie-title {
            font-size: 24px;
            font-weight: bold;
            color: #283da2;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@include file="WEB-INF/jspSC/header.jsp"%>
    
    <%
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("Login.jsp?error=Please login to view your ticket");
        return;
    }
    
    // Verify ticket belongs to current user
    String currentUser = session.getAttribute("username").toString();
    String ticketUser = (String) request.getAttribute("username");
    
    if (!currentUser.equals(ticketUser)) {
        response.sendRedirect("home.jsp?error=Unauthorized access");
        return;
    }
    %>

    <div class="ticket-section">
        <div class="ticket-icon">🎬</div>
        <h2>Your Movie Ticket</h2>
        <div class="ticket-id">Ticket #${ticketId}</div>
        
        <div class="movie-title">${movieName}</div>

        <div class="details">
            <div class="detail-row">
                <div class="detail-label">Date & Time:</div>
                <div class="detail-value">${showDateTime}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Theater:</div>
                <div class="detail-value">${theater}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Seats:</div>
                <div class="detail-value">${seats}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Price:</div>
                <div class="detail-value">Rs. ${ticketPrice}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Name:</div>
                <div class="detail-value">${username}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Email:</div>
                <div class="detail-value">${userEmail}</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Phone:</div>
                <div class="detail-value">${userPhone}</div>
            </div>
            <% if (request.getAttribute("orderTotal") != null) { %>
            <div class="detail-row">
                <div class="detail-label">Total Price:</div>
                <div class="detail-value">Rs. <%= request.getAttribute("orderTotal") %></div>
            </div>
            <% } %>
            <% if (request.getAttribute("foodItems") != null && !request.getAttribute("foodItems").toString().isEmpty()) { %>
            <div class="detail-row">
                <div class="detail-label">Food Items:</div>
                <div class="detail-value"><%= request.getAttribute("foodItems") %></div>
            </div>
            <% } %>
        </div>

        <div class="ticket-qr">
            <div class="qr-code">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=TICKET:${ticketId}" alt="QR Code">
            </div>
        </div>

        <p>This ticket is valid for one-time entry. Please show this ticket at the entrance.</p>

        <button onclick="window.print()">Print Ticket</button>
        
        <div style="margin-top: 20px;">
            <a href="home.jsp" class="action-btn">Return to Home</a>
            <a href="purchasedTickets.jsp" class="action-btn">View All Tickets</a>
        </div>
    </div>

    <%@include file="WEB-INF/jspSC/footer.jsp"%>
</body>
</html> 