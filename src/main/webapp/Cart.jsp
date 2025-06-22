<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>

<%
    HttpSession Session = request.getSession();
    Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
    Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("priceMap");
%>

<h2>Your Cart:</h2>



<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 40px;
        }
        .cart-container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #283da2;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f1f1f1;
        }
        .total-row td {
            font-weight: bold;
            color: #00c853;
        }
        .qty-btn {
            background-color: #283da2;
            color: white;
            border: none;
            padding: 4px 10px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
        }
        .qty-btn:hover {
            background-color: #3b488c;
        }
        .pay-btn {
            display: block;
            width: 100%;
            padding: 14px;
            background-color: #283da2;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
        .pay-btn:hover {
            background-color: #3b488c;
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

    </style>
</head>
<body>

<%
    Map<String, Integer> Cart = (Map<String, Integer>) session.getAttribute("cart");
    Map<String, Integer> PriceMap = (Map<String, Integer>) session.getAttribute("priceMap");
    int total = 0;
%>

<div class="cart-container">
    <h2>Your Food Cart 🛒</h2>

    <% if (cart == null || cart.isEmpty()) { %>
    <p style="text-align: center;">Your cart is empty.</p>
    <% } else { %>
    <table>
        <tr>
            <th>Item</th>
            <th>Qty</th>
            <th>Price</th>
            <th>Subtotal</th>
        </tr>

        <% for (String item : cart.keySet()) {
            int qty = cart.get(item);
            int price = priceMap.get(item);
            int subtotal = qty * price;
            total += subtotal;
        %>
        <tr>
            <td><%= item %></td>
            <td>
                <form action="update-cart" method="post" style="display:inline;">
                    <input type="hidden" name="itemName" value="<%= item %>"/>
                    <input type="hidden" name="action" value="decrease"/>
                    <button class="qty-btn">-</button>
                </form>
                <strong><%= qty %></strong>
                <form action="update-cart" method="post" style="display:inline;">
                    <input type="hidden" name="itemName" value="<%= item %>"/>
                    <input type="hidden" name="action" value="increase"/>
                    <button class="qty-btn">+</button>
                </form>
            </td>
            <td>Rs. <%= price %></td>
            <td>Rs. <%= subtotal %></td>
        </tr>
        <% } %>

        <tr class="total-row">
            <td colspan="3">Total</td>
            <td>Rs. <%= total %></td>
        </tr>
    </table>

    <form action="update-cart" method="post">
        <button type="submit" name="action" value="clear">Clear Cart</button>
    </form>
    <form action=Payment.jsp method="get">
        <button class="pay-btn">Proceed to Payment</button>
    </form>
    <% } %>
</div>
<form action="FoodCard.jsp" method="get" style="margin-top: 20px;">
    <button type="submit" class="back-btn" style="background-color: #0e355c;"> Back </button>
</form>

<form action="home.jsp" method="get" style="margin-top: 20px;">
    <button type="submit" class="back-btn" style="background-color: #0e355c;"> Return Home </button>
</form>

</body>
</html>
