package com.CartAndPayment.servlet;

import com.CartAndPayment.service.cartservice;
import com.CartAndPayment.service.paymentservice;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class ProcessPaymentServlet extends HttpServlet {

    private paymentservice paymentService;
    private cartservice cartService;

    @Override
    public void init() {
        paymentService = new paymentservice(getServletContext());
        cartService = new cartservice();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String amount = request.getParameter("amount");
        String bank = request.getParameter("bank");
        String referenceId = request.getParameter("referenceid");

        // Process payment using service
        paymentService.processPayment(username, amount, bank, referenceId);

        HttpSession session = request.getSession();

        // Store cart items in payment_items for the success page
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
        Map<String, Integer> priceMap = (Map<String, Integer>) session.getAttribute("priceMap");

        if (cart != null && priceMap != null) {
            session.setAttribute("payment_items", new HashMap<>(cart));
            session.setAttribute("payment_prices", new HashMap<>(priceMap));
        }

        // Clear the cart
        cartService.clearCart(session);

        // Set attributes for the success page
        request.setAttribute("username", username);
        request.setAttribute("bankNames", bank);
        request.setAttribute("referenceid", referenceId);
        request.setAttribute("amount", amount);

        // Forward to success page
        RequestDispatcher dispatcher = request.getRequestDispatcher("SuccesssPage.jsp");
        dispatcher.forward(request, response);
    }
}


