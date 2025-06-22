<%--
  Created by IntelliJ IDEA.
  User: Anoja
  Date: 06/05/2025
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%!
    // Helper method to get day of week from date string
    public String getDayOfWeek(String dateStr) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); // Adjust format to match your date format
            Date date = format.parse(dateStr);
            SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE");
            return dayFormat.format(date);
        } catch (Exception e) {
            return "Unknown";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Purchased Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>
<body class="bg-hero d-flex align-items-center justify-content-center" style="min-height: 100vh; background-color: rgba(0,0,0,0.7); background-blend-mode: darken;">

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-white mb-0">Your Purchased Tickets</h2>
        <a href="home.jsp" class="btn btn-success"><i class="bi bi-house-fill me-2"></i>Return Home</a>
    </div>

    <!-- Search Filter -->
    <input type="text" id="ticketSearch" class="form-control mb-4" placeholder="Search by movie name..." onkeyup="filterTickets()">

    <%
        String filePath = application.getRealPath("/WEB-INF/tickets.txt");
        out.println("<!-- Looking for file at: " + filePath + " -->");
        // Make sure tickets.txt is inside your project root folder
        File ticketFile = new File(filePath);

        if (ticketFile.exists()) {
            BufferedReader reader = new BufferedReader(new FileReader(ticketFile));
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 10) {
                    String ticketId = parts[0];
                    String username = parts[1];
                    String movieTitle = parts[2];
                    String showTime = parts[3];
                    String seats = parts[4];
                    String ticketPrice = parts[5];
                    String ticketDate = parts[6];
                    String status = parts[7];
                    String userEmail = parts[8];
                    String userPhone = parts[9];
                    String foodItems = "";
                    if (parts.length > 10) {
                        StringBuilder sb = new StringBuilder();
                        for (int i = 10; i < parts.length; i++) {
                            if (sb.length() > 0) sb.append(",");
                            sb.append(parts[i]);
                        }
                        foodItems = sb.toString();
                    }
                    // Calculate total price from foodItems and ticketPrice (movie price)
                    int orderTotal = 0;
                    try { orderTotal += Integer.parseInt(ticketPrice); } catch(Exception e) {}
                    if (foodItems != null && !foodItems.isEmpty()) {
                        String[] itemsArr = foodItems.split("; ");
                        for (String itemStr : itemsArr) {
                            int idx = itemStr.lastIndexOf(": Rs.");
                            if (idx != -1) {
                                try { orderTotal += Integer.parseInt(itemStr.substring(idx+5).trim()); } catch(Exception e) {}
                            }
                        }
                    }
                    
                    // Only show tickets for the logged-in user
                    HttpSession userSession = request.getSession();
                    if (userSession.getAttribute("username") == null || !username.equals(userSession.getAttribute("username").toString())) {
                        continue;
                    }
    %>
    <div class="card ticket-card mb-4" data-title="<%= movieTitle %>" data-ticket-id="<%= ticketId %>">
        <div class="card-body">
            <h5 class="card-title">🎬 <%= movieTitle %>
                <span class="badge <%= status.equals("Confirmed") ? "bg-success" : "bg-danger" %>"><%= status %></span></h5>
            <p class="card-text">Date: <span class="ticket-date"><%= ticketDate %></span></p>
            <p class="card-text">Day: <span class="ticket-day"><%= getDayOfWeek(ticketDate) %></span></p>

            <p class="card-text">Show Time: <span class="show-time"><%= showTime %></span></p>
            <p class="card-text">Seats: <span class="seat-count"><%= seats %></span></p>
            <p class="card-text">Total: <span class="total-price">Rs. <%= orderTotal %></span></p>
            <p class="card-text">Status: <span><%= status %></span></p>
            <p class="card-text">Email: <span><%= userEmail %></span></p>
            <p class="card-text">Phone: <span><%= userPhone %></span></p>
            <% if (foodItems != null && !foodItems.isEmpty()) { %>
            <p class="card-text"><strong>Ordered Items:</strong> <%= foodItems %></p>
            <% } %>

            <% if (status.equals("Confirmed")) { %>
            <button class="btn btn-primary me-2" onclick="openEditModal(this)">Edit</button>
            <form method="post" action="CancelTicketServlet" style="display:inline;">
                <input type="hidden" name="ticketId" value="<%= ticketId %>">
                <button type="submit" class="btn btn-danger me-2" onclick="return confirm('Are you sure you want to cancel this ticket?')">Cancel</button>
            </form>
            <% } %>
            <button class="btn btn-outline-secondary" onclick="printTicket(this)">Print</button>
        </div>
    </div>
    <%
            }
        }
        reader.close();
    } else {
    %>
    <div class="alert alert-warning text-white bg-warning mt-3" role="alert">
        ⚠️ No tickets found. Make sure <code>tickets.txt</code> is placed in the correct location.
    </div>
    <%
        }
    %>

    <!-- 🔧 Modal: Edit Ticket -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form method="post" action="UpdateTicket">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Ticket</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="editTicketId" name="ticketId" value=""/>

                        <label for="newTime" class="form-label">New Show Time</label>
                        <select class="form-select mb-3" name="newTime" id="newTime">
                            <option value="1:00 PM">1:00 PM</option>
                            <option value="4:00 PM">4:00 PM</option>
                            <option value="7:00 PM">7:00 PM</option>
                        </select>

                        <label for="additionalSeats" class="form-label">Add More Seats</label>
                        <input type="number" class="form-control" name="additionalSeats" id="additionalSeats" min="0" max="10">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-warning">Save Changes</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function openEditModal(btn) {
        const card = btn.closest(".card");
        const ticketId = card.getAttribute("data-ticket-id");

        const currentShowTime = card.querySelector(".show-time").innerText.trim();
        const currentSeatCount = parseInt(card.querySelector(".seat-count").innerText.trim());

        // Debug alert (optional)
        // alert("Editing ticket ID: " + ticketId);

        document.getElementById("editTicketId").value = ticketId;
        document.getElementById("newTime").value = currentShowTime;
        document.getElementById("additionalSeats").value = 0;

        new bootstrap.Modal(document.getElementById("editModal")).show();
    }

    function updateSeats(btn, change) {
        const card = btn.closest(".card");
        const seatSpan = card.querySelector(".seat-count");
        const totalSpan = card.querySelector(".total-price");
        let currentSeats = parseInt(seatSpan.innerText);
        const seatPrice = 10;

        currentSeats = Math.max(1, currentSeats + change);
        seatSpan.innerText = currentSeats;
        totalSpan.innerText = currentSeats * seatPrice;
    }

    function confirmCancel(btn) {
        if (confirm("Are you sure you want to cancel this ticket?")) {
            const card = btn.closest(".card");
            const badge = card.querySelector(".badge");
            badge.className = "badge bg-danger";
            badge.innerText = "Cancelled";
            btn.disabled = true;
            card.querySelector(".btn-primary").disabled = true;
        }
    }

    function printTicket(btn) {
        const card = btn.closest(".card");
        const printContent = card.innerHTML;
        const printWindow = window.open('', '', 'height=400,width=600');
        printWindow.document.write('<html><head><title>Print Ticket</title>');
        printWindow.document.write('<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">');
        printWindow.document.write('</head><body >');
        printWindow.document.write(printContent);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
    }

    function filterTickets() {
        const input = document.getElementById("ticketSearch").value.toLowerCase();
        const cards = document.getElementsByClassName("ticket-card");

        Array.from(cards).forEach(card => {
            const title = card.getAttribute("data-title").toLowerCase();
            card.style.display = title.includes(input) ? "block" : "none";
        });
    }
</script>

</body>
</html>