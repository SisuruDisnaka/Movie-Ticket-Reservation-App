package com.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.Map;
import java.util.UUID;
import java.util.ArrayList;
import java.util.List;
import com.db.QueueX;

@WebServlet("/createTicket")
public class TicketServlet extends HttpServlet {

    private final int MAX_TICKETS_PER_USER = 4;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Check login
        if (session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp?error=Please login to create a ticket");
            return;
        }

        String username = (String) session.getAttribute("username");
        String movieName = request.getParameter("movie");
        String showDateTime = request.getParameter("date") + " " + request.getParameter("time");
        String theater = request.getParameter("theater");
        String seats = request.getParameter("seats");
        String ticketPrice = request.getParameter("price");

        // Get user email & phone
        String userEmail = "";
        String userPhone = "";
        try {
            String usersPath = getServletContext().getRealPath("/WEB-INF/users.txt");
            BufferedReader reader = new BufferedReader(new FileReader(usersPath));
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6 && parts[0].equals(username)) {
                    userEmail = parts[4];
                    userPhone = parts[5];
                    break;
                }
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Generate ticket ID
        String ticketId = UUID.randomUUID().toString().substring(0, 8);

        // Extract food items
        Map<String, Integer> foodCart = (Map<String, Integer>) session.getAttribute("payment_items");
        Map<String, Integer> foodPrices = (Map<String, Integer>) session.getAttribute("payment_prices");

        StringBuilder foodItemsStr = new StringBuilder();
        int orderTotal = 0;
        if (foodCart != null && foodPrices != null) {
            for (String item : foodCart.keySet()) {
                int qty = foodCart.get(item);
                int price = foodPrices.getOrDefault(item, 0);
                orderTotal += qty * price;
                if (foodItemsStr.length() > 0) foodItemsStr.append("; ");
                foodItemsStr.append(item).append(" (x").append(qty).append(") : Rs.").append(price * qty);
            }
        }

        String foodItemsField = foodItemsStr.toString();

        // Ticket data line
        String ticketData = ticketId + "," + username + "," + movieName + "," +
                showDateTime + "," + seats + "," + ticketPrice + "," +
                request.getParameter("date") + "," + "Confirmed" + "," +
                userEmail + "," + userPhone + "," + foodItemsField;

        // write to file
        String ticketsPath = getServletContext().getRealPath("/WEB-INF/tickets.txt");
        updateUserTicketQueue(username, ticketData, ticketsPath);

        // Pass ticket data to JSP
        request.setAttribute("ticketId", ticketId);
        request.setAttribute("username", username);
        request.setAttribute("movieName", movieName);
        request.setAttribute("showDateTime", showDateTime);
        request.setAttribute("theater", theater);
        request.setAttribute("seats", seats);
        request.setAttribute("ticketPrice", ticketPrice);
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("userPhone", userPhone);
        request.setAttribute("foodItems", foodItemsField);
        request.setAttribute("orderTotal", orderTotal);

        request.getRequestDispatcher("/displayTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private synchronized void updateUserTicketQueue(String username, String newTicket, String ticketsPath) {
        List<String> allOtherTickets = new ArrayList<>();
        QueueX userQueue = new QueueX(MAX_TICKETS_PER_USER);

        try {
            File file = new File(ticketsPath);
            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length > 1 && parts[1].equals(username)) {
                        userQueue.insert(line);
                    } else {
                        allOtherTickets.add(line);
                    }
                }
                reader.close();
            }

            userQueue.insert(newTicket);

            BufferedWriter writer = new BufferedWriter(new FileWriter(ticketsPath, false));

            for (String otherTicket : allOtherTickets) {
                writer.write(otherTicket);
                writer.newLine();
            }

            String[] userTickets = userQueue.getItemsInOrder();
            for (int i = 0; i < userTickets.length; i++) {
                writer.write(userTickets[i]);
                if (i < userTickets.length - 1 || !allOtherTickets.isEmpty()) {
                    writer.newLine();
                }
            }

            writer.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}