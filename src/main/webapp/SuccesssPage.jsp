<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px;
        }

        .success-section {
            width: 400px;
            margin: auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .success-section h2 {
            margin-bottom: 10px;
            color: #28a745;
        }

        .success-section .success-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }

        .success-section hr {
            margin: 15px 0;
            border: none;
            border-top: 1px solid #ddd;
        }

        .success-section .details {
            text-align: left;
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .success-section .detail-row {
            margin-bottom: 10px;
            display: flex;
        }

        .success-section .detail-label {
            font-weight: 600;
            width: 120px;
        }

        .success-section .detail-value {
            flex: 1;
        }

        .success-section button {
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

        .success-section p {
            margin-top: 15px;
            font-size: 12px;
            color: #666;
        }

        .back-btn {
            display: block;
            width: 10%;
            padding: 14px;
            background-color: #0e355c;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.5s;
            margin: 15px auto;
        }

        .back-btn:hover {
            background-color: #3b488c;
        }

        .order-items {
            text-align: left;
            margin-top: 10px;
            padding: 10px 0;
            border-top: 1px dashed #ddd;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            margin: 5px 0;
        }
    </style>
</head>
<body>
<%@ page import="java.util.*" %>
<%


    Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("payment_items");
    Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("payment_prices");
    Map<String, String> movieDetails = (Map<String, String>) session.getAttribute("movie_ticket_details");

    // Current date
    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MMMM d, yyyy");
    String currentDate = dateFormat.format(new java.util.Date());
%>

<div class="success-section">3
    <div class="success-icon">✓</div>
    <h2>Payment Successful!</h2>
    <p>Thank you for your payment. Your transaction has been completed successfully.</p>

    <hr>

    <div class="details">
        <h3>Transaction Details</h3>
        <div class="detail-row">
            <div class="detail-label">Username:</div>
            <div class="detail-value">${username}</div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Bank:</div>
            <div class="detail-value">${bankNames}</div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Reference ID:</div>
            <div class="detail-value">${referenceid}</div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Date:</div>
            <div class="detail-value"><%= currentDate %></div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Status:</div>
            <div class="detail-value" style="color: #28a745; font-weight: 600;">Completed</div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Amount:</div>
            <div class="detail-value">Rs.${amount}</div>
        </div>

        <% if (cart != null && !cart.isEmpty() && priceMap != null) { %>
        <div class="order-items">
            <h4>Order Items:</h4>
            <% for (String item : cart.keySet()) {
                int qty = cart.get(item);
                int price = priceMap.getOrDefault(item, 0);
            %>
            <div class="order-item">
                <span><%= item %> (x<%= qty %>)</span>
                <span>Rs. <%= price * qty %></span>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>

    <button onclick="window.print()">Print Receipt</button>

    <p>A confirmation has been sent to your email address. Please keep this transaction details for your records.</p>
</div>

<% if (movieDetails != null) { %>
<form action="createTicket" method="get">
    <input type="hidden" name="movie" value="<%= movieDetails.get("movie") %>" />
    <input type="hidden" name="date" value="<%= movieDetails.get("date") %>" />
    <input type="hidden" name="time" value="<%= movieDetails.get("time") %>" />
    <input type="hidden" name="theater" value="<%= movieDetails.get("theater") %>" />
    <input type="hidden" name="seats" value="<%= movieDetails.get("seats") %>" />
    <input type="hidden" name="price" value="<%= priceMap != null && !priceMap.isEmpty() ? priceMap.values().iterator().next() : "" %>" />
    <button type="submit" class="back-btn">View Ticket</button>
</form>
<% } else { %>
<form action="movies?letter=all" method="get">
    <button type="submit" class="back-btn">Back to Home</button>
</form>
<% } %>


</body>
</html>