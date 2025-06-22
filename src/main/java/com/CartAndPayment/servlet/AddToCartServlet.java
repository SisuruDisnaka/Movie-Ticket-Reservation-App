package com.CartAndPayment.servlet;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String itemName = request.getParameter("itemName");
        int price = Integer.parseInt(request.getParameter("price"));

        // Retrieve or create cart
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("priceMap");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        if (priceMap == null) {
            priceMap = new HashMap<>();
            session.setAttribute("priceMap", priceMap);
        }

        // Update item quantity
        cart.put(itemName, cart.getOrDefault(itemName, 0) + 1);
        priceMap.putIfAbsent(itemName, price);

        response.sendRedirect("FoodCard.jsp");
    }
}


