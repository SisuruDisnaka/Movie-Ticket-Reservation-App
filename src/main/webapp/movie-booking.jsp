<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movieManage.Movie" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Booking | PopComPulse</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%
    // Get movie from request attribute
    Movie movie = (Movie) request.getAttribute("movie");
    
    if (movie == null) {
        response.sendRedirect("MoviePage.jsp?error=movie_not_found");
        return;
    }
    
    // Get movie details
    String title = movie.getTitle();
    String director = movie.getDirector();
    String mainCharacter = movie.getMainCharacter();
    String imagePath = movie.getImagePath();
    String[] showingDates = movie.getShowingDates();
    String[] timeSlots = movie.getTimeSlots();
    String[] screens = movie.getScreens();
    double pricePremium = movie.getPricePremium();
    double priceBoutique = movie.getPriceBoutique();
    double priceStandard = movie.getPriceStandard();
    
    // Find the minimum length among dates, times, and screens
    int minLength = Math.min(Math.min(showingDates.length, timeSlots.length), screens.length);
%>

<main class="movie-details-container">
    <section class="movie-header">
        <div class="movie-title">
            <h1><%= title %></h1>
            <div class="movie-meta">
                <span>Director: <%= director %></span>
                <span>Main Cast: <%= mainCharacter %></span>
            </div>
            <div class="movie-poster-container" style="margin-top: 20px;">
                <img src="<%= imagePath %>" alt="<%= title %>" style="max-width: 300px; border-radius: 8px;">
            </div>
        </div>
    </section>

    <section class="showtimes-section">
        <h2>BOOK TICKETS</h2>
        <h3>Select Showtime</h3>
        
        <form action="seating.jsp" method="get" id="bookingForm">
            <input type="hidden" name="movie" value="<%= title %>">
            
            <div class="booking-options">
                <div class="datetime-selection">
                    <h4>SELECT SHOWTIME:</h4>
                    <div class="options-grid">
                        <% 
                        for (int i = 0; i < minLength; i++) { 
                        %>
                            <div class="option-item">
                                <input type="radio" id="datetime<%= i %>" name="datetime" 
                                       data-date="<%= showingDates[i] %>" 
                                       data-time="<%= timeSlots[i] %>"
                                       data-screen="<%= screens[i] %>"
                                       data-index="<%= i %>"
                                       value="<%= i %>" 
                                       onclick="updateSelection(<%= i %>)" <%= i == 0 ? "checked" : "" %>>
                                <label for="datetime<%= i %>">
                                    <%= showingDates[i] %> at <%= timeSlots[i] %>
                                    <span class="theater-badge"><%= screens[i] %></span>
                                </label>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Hidden inputs for seating.jsp -->
            <input type="hidden" name="date" id="selectedDate" value="<%= minLength > 0 ? showingDates[0] : "" %>">
            <input type="hidden" name="time" id="selectedTime" value="<%= minLength > 0 ? timeSlots[0] : "" %>">
            <input type="hidden" name="screenType" id="selectedScreen" value="<%= minLength > 0 ? screens[0] : "" %>">
            <input type="hidden" name="price" id="selectedPrice" value="<%= minLength > 0 ? getPrice(screens[0], pricePremium, priceBoutique, priceStandard) : 0 %>">
            
            <div class="booking-summary">
                <h3>Booking Summary</h3>
                <p>Movie: <span><%= title %></span></p>
                <p>Date: <span id="summaryDate"><%= minLength > 0 ? showingDates[0] : "Not available" %></span></p>
                <p>Time: <span id="summaryTime"><%= minLength > 0 ? timeSlots[0] : "Not available" %></span></p>
                <p>Theater: <span id="summaryScreen"><%= minLength > 0 ? screens[0] : "Standard" %></span></p>
                <p>Price: <span id="summaryPrice"><%= formatPrice(minLength > 0 ? getPrice(screens[0], pricePremium, priceBoutique, priceStandard) : 0) %></span></p>
            </div>
            
            <div class="action-buttons">
                <button type="button" class="btn-cancel" onclick="window.history.back()">Cancel</button>
                <button type="submit" class="btn-proceed">Continue to Seat Selection</button>
            </div>
        </form>
    </section>
</main>

<%@include file="WEB-INF/jspSC/footer.jsp"%>

<%!
    // Helper method to get price based on screen type
    private double getPrice(String screenType, double pricePremium, double priceBoutique, double priceStandard) {
        if ("Premium".equalsIgnoreCase(screenType)) {
            return pricePremium;
        } else if ("Boutique".equalsIgnoreCase(screenType)) {
            return priceBoutique;
        } else {
            return priceStandard;
        }
    }
    
    // Format price with LKR
    private String formatPrice(double price) {
        return String.format("LKR %.2f", price);
    }
%>

<script>
    // Store dates, times, and screens as JavaScript variables
    var showingDates = [];
    var timeSlots = [];
    var screens = [];
    var prices = [];
    
    <% for(int i = 0; i < minLength; i++) { %>
        showingDates.push("<%= showingDates[i] %>");
        timeSlots.push("<%= timeSlots[i] %>");
        screens.push("<%= screens[i] %>");
        prices.push(<%= getPrice(screens[i], pricePremium, priceBoutique, priceStandard) %>);
    <% } %>
    
    // Update all selections based on the selected showtime
    function updateSelection(index) {
        // Get the date, time, screen from the selected option
        var date = showingDates[index];
        var time = timeSlots[index];
        var screen = screens[index];
        var price = prices[index];
        
        // Update hidden inputs
        document.getElementById('selectedDate').value = date;
        document.getElementById('selectedTime').value = time;
        document.getElementById('selectedScreen').value = screen;
        document.getElementById('selectedPrice').value = price;
        
        // Update summary
        document.getElementById('summaryDate').textContent = date;
        document.getElementById('summaryTime').textContent = time;
        document.getElementById('summaryScreen').textContent = screen;
        document.getElementById('summaryPrice').textContent = 'LKR ' + price.toFixed(2);
    }
    
    // Initialize the form with the first showtime selected
    document.addEventListener('DOMContentLoaded', function() {
        if (showingDates.length > 0) {
            updateSelection(0);
        }
    });
</script>

<style>
/* Additional styles for the booking page */
.booking-options {
    display: flex;
    flex-direction: column;
    gap: 30px;
    margin: 30px 0;
}

.options-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 15px;
    margin-top: 10px;
}

.option-item {
    position: relative;
}

.option-item input[type="radio"] {
    position: absolute;
    opacity: 0;
}

.option-item label {
    display: block;
    padding: 15px;
    background-color: #f1f3f5;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    font-weight: 500;
    color: #495057;
    transition: all 0.3s;
    position: relative;
}

.theater-badge {
    display: inline-block;
    background-color: #4361ee;
    color: white;
    padding: 3px 8px;
    border-radius: 10px;
    font-size: 0.8rem;
    margin-left: 5px;
    position: absolute;
    top: -10px;
    right: -5px;
}

.option-item input[type="radio"]:checked + label {
    background-color: #4361ee;
    color: white;
}

.option-item input[type="radio"]:checked + label .theater-badge {
    background-color: #fff;
    color: #4361ee;
}

.option-item label:hover {
    background-color: #e9ecef;
}

.option-item input[type="radio"]:checked + label:hover {
    background-color: #3a56d4;
}

.booking-summary {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin: 30px 0;
}

.booking-summary h3 {
    margin-bottom: 15px;
    color: #1a1a2e;
}

.booking-summary p {
    margin: 8px 0;
    display: flex;
    justify-content: space-between;
    color: #495057;
}

.booking-summary p span {
    font-weight: 500;
    color: #1a1a2e;
}

.movie-poster-container {
    text-align: center;
}
</style>
</body>
</html> 