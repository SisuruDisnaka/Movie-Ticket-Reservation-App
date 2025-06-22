package com.CartAndPayment.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String itemName = request.getParameter("itemName");
        String action = request.getParameter("action");

        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

        if (cart != null) {
            if ("increase".equals(action)) {
                cart.put(itemName, cart.getOrDefault(itemName, 0) + 1);
            } else if ("decrease".equals(action)) {
                int qty = cart.getOrDefault(itemName, 0);
                if (qty > 1) {
                    cart.put(itemName, qty - 1);
                } else {
                    cart.remove(itemName);
                }
            } else if ("clear".equals(action)) {
                cart.clear();
                Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("priceMap");
                if (priceMap != null) priceMap.clear();
            }
        }

        response.sendRedirect("Cart.jsp");
    }
}

