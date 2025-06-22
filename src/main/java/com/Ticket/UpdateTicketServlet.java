package com.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UpdateTicket")
public class UpdateTicketServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");
        String newTime = request.getParameter("newTime");
        String additionalSeatsStr = request.getParameter("additionalSeats");
        
        if (ticketId == null || ticketId.isEmpty()) {
            response.sendRedirect("purchasedTickets.jsp?error=Invalid ticket ID");
            return;
        }
        
        int additionalSeats = 0;
        try {
            additionalSeats = Integer.parseInt(additionalSeatsStr);
        } catch (NumberFormatException e) {
            // Just use 0 if parsing fails
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
                // This is the ticket to update
                String[] ticketParts = line.split(",");
                if (ticketParts.length >= 6) {
                    // Update show time
                    String oldShowTime = ticketParts[3];
                    String[] dateTimeComponents = oldShowTime.split(" ");
                    
                    // Build new show time string
                    StringBuilder newShowTime = new StringBuilder();
                    if (dateTimeComponents.length > 0) {
                        newShowTime.append(dateTimeComponents[0]).append(" ").append(newTime);
                    } else {
                        newShowTime.append(newTime);
                    }
                    
                    // Calculate updated seats and price if additional seats were requested
                    int currentSeats = 0;
                    try {
                        currentSeats = ticketParts[4].split(" ").length; // Assuming seats are separated by spaces
                    } catch (Exception e) {
                        currentSeats = 1;
                    }
                    
                    int totalSeats = currentSeats + additionalSeats;
                    double pricePerSeat = 10.0; // Default price per seat if we can't parse the original
                    double originalPrice = 0.0;
                    
                    try {
                        originalPrice = Double.parseDouble(ticketParts[5]);
                        pricePerSeat = originalPrice / currentSeats;
                    } catch (Exception e) {
                        // Use default price
                    }
                    
                    double totalPrice = totalSeats * pricePerSeat;
                    
                    // Build updated ticket data
                    StringBuilder modifiedTicket = new StringBuilder();
                    for (int i = 0; i < ticketParts.length; i++) {
                        if (i == 3) {
                            modifiedTicket.append(newShowTime.toString());
                        } else if (i == 4 && additionalSeats > 0) {
                            // Add additional seats - we'd need more information about seating structure
                            // This is a simplified version
                            String originalSeats = ticketParts[4];
                            modifiedTicket.append(originalSeats).append(" (+").append(additionalSeats).append(")");
                        } else if (i == 5 && additionalSeats > 0) {
                            modifiedTicket.append(String.format("%.2f", totalPrice));
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
        
        response.sendRedirect("purchasedTickets.jsp?message=Ticket updated successfully");
    }
} 