<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Transfer Payment</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px;
        }

        .payment-section {
            width: 400px;
            margin: auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        .payment-section h2 {
            margin-bottom: 10px;
        }

        .payment-section hr {
            margin: 15px 0;
            border: none;
            border-top: 1px solid #ddd;
        }

        .payment-section label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .payment-section input[type="text"],
        .payment-section select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
        }

        .payment-section button {
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

        .payment-section p {
            margin-top: 15px;
            font-size: 12px;
            color: #666;
        }

        .back-btn {
            display: block;
            width: 10%;
            padding: 14px;
            background-color: #3b488c; /* gray */
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.5s;
            margin-top: 15px;
        }

        .back-btn:hover {
            background-color: #3b488c; /* darker gray on hover */
        }

        .order-summary {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .order-total {
            font-weight: bold;
            margin-top: 10px;
            text-align: right;
            font-size: 18px;
            color: #283da2;
        }
    </style>
</head>
<body>
<%@ page import="java.util.*" %>


<%
    // Get cart and price information from session
    Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
    Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("priceMap");
    int total = 0;

    // Calculate total amount if cart exists
    if (cart != null && priceMap != null) {
        for (String item : cart.keySet()) {
            int qty = cart.get(item);
            int price = priceMap.get(item);
            total += qty * price;
        }
    }
%>

<div class="payment-section">
    <h2>Payment</h2>
    <hr>

    <% if (cart != null && !cart.isEmpty()) { %>
    <div class="order-summary">
        <h3>Order Summary</h3>
        <% for (String item : cart.keySet()) {
            int qty = cart.get(item);
            int price = priceMap.get(item);
        %>
        <div><%= item %>: <%= qty %> x Rs. <%= price %> = Rs. <%= qty * price %></div>
        <% } %>
        <div class="order-total">Total: Rs. <%= total %></div>
    </div>
    <% } %>

    <form action="process-payment" method="post">
        <input type="hidden" name="amount" value="<%= total %>" />

        <label for="username">Username</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required />

        <label for="bank">Select Bank</label>
        <select id="bank" name="bank" required>
            <option value="">-- Select Bank --</option>
            <option value="Bank of Ceylon">Bank of Ceylon</option>
            <option value="Peoples Bank">Peoples Bank</option>
            <option value="Hatton National Bank">Hatton National Bank</option>
            <option value="Sampath Bank">Sampath Bank</option>
            <option value="Commercial Bank">Commercial Bank</option>
        </select>

        <label for="referenceid">Enter Reference ID</label>
        <input type="text" id="referenceid" name="referenceid"
               pattern="[A-Za-z0-9]+"
               title="Reference ID should only contain letters and numbers"
               placeholder="e.g. 123456ABC" required />

        <button type="submit">Pay</button>

        <p>Your personal data will be used to process your order, support your experience
            throughout this website, and for other purposes described in our privacy policy.</p>
    </form>
</div>

<form action="Cart.jsp" method="get" style="margin-top: 20px;">
    <button type="submit" class="back-btn" style="background-color: #0e355c;"> Back </button>
</form>

</body>
</html>