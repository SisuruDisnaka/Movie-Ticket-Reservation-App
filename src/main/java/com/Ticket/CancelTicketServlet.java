package com.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CancelTicketServlet")
public class CancelTicketServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");
        
        if (ticketId == null || ticketId.isEmpty()) {
            response.sendRedirect("purchasedTickets.jsp?error=Invalid ticket ID");
            return;
        }
        
        // Read the tickets file
        String ticketsPath = getServletContext().getRealPath("/WEB-INF/tickets.txt");
        File ticketsFile = new File(ticketsPath);
        
        if (!ticketsFile.exists()) {
            response.sendRedirect("purchasedTickets.jsp?error=Tickets file not found");
            return;
        }
        
        List<String> tickets = new ArrayList<>();
        BufferedReader reader = new BufferedReader(new FileReader(ticketsFile));
        String line;
        boolean ticketFound = false;
        
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length > 0 && parts[0].equals(ticketId)) {
                // This is the ticket to cancel - change status to "Cancelled"
                String[] ticketParts = line.split(",");
                if (ticketParts.length >= 8) {
                    StringBuilder modifiedTicket = new StringBuilder();
                    for (int i = 0; i < ticketParts.length; i++) {
                        if (i == 7) {
                            modifiedTicket.append("Cancelled");
                        } else {
                            modifiedTicket.append(ticketParts[i]);
                        }
                        
                        if (i < ticketParts.length - 1) {
                            modifiedTicket.append(",");
                        }
                    }
                    tickets.add(modifiedTicket.toString());
                    ticketFound = true;
                } else {
                    tickets.add(line);
                }
            } else {
                tickets.add(line);
            }
        }
        reader.close();
        
        if (!ticketFound) {
            response.sendRedirect("purchasedTickets.jsp?error=Ticket not found");
            return;
        }
        
        // Write the updated tickets back to the file
        BufferedWriter writer = new BufferedWriter(new FileWriter(ticketsFile));
        for (int i = 0; i < tickets.size(); i++) {
            writer.write(tickets.get(i));
            if (i < tickets.size() - 1) {
                writer.newLine();
            }
        }
        writer.close();
        
        response.sendRedirect("purchasedTickets.jsp?message=Ticket cancelled successfully");
    }
} 