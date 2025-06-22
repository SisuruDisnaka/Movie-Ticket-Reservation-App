<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.theaterManagement.model.BookedSeats" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seat Selection | PopComPulse</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%
        // Get parameters
        String movie = request.getParameter("movie");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String theater = request.getParameter("screenType");
        
        // Get booked seats
        Set<String> bookedSeats = (Set<String>) request.getAttribute("bookedSeats");
        if (bookedSeats == null) {
            // If not coming from servlet, initialize BookedSeats and get data directly
            String seatsFilePath = application.getRealPath("/WEB-INF/seats.txt");
            BookedSeats seatsManager = new BookedSeats(seatsFilePath);
            bookedSeats = seatsManager.getBookedSeats(movie, date, time, theater);
        }
        
        // Helper function to check if a seat is booked
        pageContext.setAttribute("bookedSeats", bookedSeats);
    %>
    
    <%!
        // Helper function to check if a seat is booked
        public boolean isSeatBooked(Set<String> bookedSeats, String seatId) {
            return bookedSeats != null && bookedSeats.contains(seatId);
        }
    %>



    <div class="seat-selection-container">
        <div class="movie-info">
            <h1>${param.movie}</h1>
            <h2>${param.screenType}</h2>
            <p>${param.date} | ${param.time}</p>
        </div>

        <div class="screen-container">
            <div class="screen">SCREEN</div>
            <div class="screen-arrow"></div>
        </div>

        <div class="seat-legend">
            <div class="legend-item">
                <div class="legend-color available"></div>
                <span>Available</span>
            </div>
            <div class="legend-item">
                <div class="legend-color selected"></div>
                <span>Selected</span>
            </div>
            <div class="legend-item">
                <div class="legend-color unavailable"></div>
                <span>Unavailable</span>
            </div>
        </div>

        <div class="seating-area">
            <div class="seat-section center-section">
                <!-- Row A -->
                <div class="seat-row">
                    <div class="seat <%= isSeatBooked(bookedSeats, "A1") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A1") ? "onclick=\"selectSeat(this, 'A1')\"" : "" %> 
                         data-seat="A1">A1</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "A2") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A2") ? "onclick=\"selectSeat(this, 'A2')\"" : "" %> 
                         data-seat="A2">A2</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "A3") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A3") ? "onclick=\"selectSeat(this, 'A3')\"" : "" %> 
                         data-seat="A3">A3</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "A4") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A4") ? "onclick=\"selectSeat(this, 'A4')\"" : "" %> 
                         data-seat="A4">A4</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "A5") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A5") ? "onclick=\"selectSeat(this, 'A5')\"" : "" %> 
                         data-seat="A5">A5</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "A6") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "A6") ? "onclick=\"selectSeat(this, 'A6')\"" : "" %> 
                         data-seat="A6">A6</div>
                </div>

                <!-- Row B -->
                <div class="seat-row">
                    <div class="seat <%= isSeatBooked(bookedSeats, "B1") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B1") ? "onclick=\"selectSeat(this, 'B1')\"" : "" %> 
                         data-seat="B1">B1</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "B2") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B2") ? "onclick=\"selectSeat(this, 'B2')\"" : "" %> 
                         data-seat="B2">B2</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "B3") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B3") ? "onclick=\"selectSeat(this, 'B3')\"" : "" %> 
                         data-seat="B3">B3</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "B4") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B4") ? "onclick=\"selectSeat(this, 'B4')\"" : "" %> 
                         data-seat="B4">B4</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "B5") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B5") ? "onclick=\"selectSeat(this, 'B5')\"" : "" %> 
                         data-seat="B5">B5</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "B6") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "B6") ? "onclick=\"selectSeat(this, 'B6')\"" : "" %> 
                         data-seat="B6">B6</div>
                </div>

                <!-- Row C -->
                <div class="seat-row">
                    <div class="seat <%= isSeatBooked(bookedSeats, "C1") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C1") ? "onclick=\"selectSeat(this, 'C1')\"" : "" %> 
                         data-seat="C1">C1</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "C2") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C2") ? "onclick=\"selectSeat(this, 'C2')\"" : "" %> 
                         data-seat="C2">C2</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "C3") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C3") ? "onclick=\"selectSeat(this, 'C3')\"" : "" %> 
                         data-seat="C3">C3</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "C4") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C4") ? "onclick=\"selectSeat(this, 'C4')\"" : "" %> 
                         data-seat="C4">C4</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "C5") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C5") ? "onclick=\"selectSeat(this, 'C5')\"" : "" %> 
                         data-seat="C5">C5</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "C6") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "C6") ? "onclick=\"selectSeat(this, 'C6')\"" : "" %> 
                         data-seat="C6">C6</div>
                </div>

                <!-- Row D -->
                <div class="seat-row">
                    <div class="seat <%= isSeatBooked(bookedSeats, "D1") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D1") ? "onclick=\"selectSeat(this, 'D1')\"" : "" %> 
                         data-seat="D1">D1</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "D2") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D2") ? "onclick=\"selectSeat(this, 'D2')\"" : "" %> 
                         data-seat="D2">D2</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "D3") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D3") ? "onclick=\"selectSeat(this, 'D3')\"" : "" %> 
                         data-seat="D3">D3</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "D4") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D4") ? "onclick=\"selectSeat(this, 'D4')\"" : "" %> 
                         data-seat="D4">D4</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "D5") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D5") ? "onclick=\"selectSeat(this, 'D5')\"" : "" %> 
                         data-seat="D5">D5</div>
                    <div class="seat <%= isSeatBooked(bookedSeats, "D6") ? "unavailable" : "available" %>" 
                         <%= !isSeatBooked(bookedSeats, "D6") ? "onclick=\"selectSeat(this, 'D6')\"" : "" %> 
                         data-seat="D6">D6</div>
                </div>
            </div>
        </div>

        <div class="pricing-section">
            <div class="price-tier">
                <span>CLASSIC FULL</span>
                <span class="price">900.00</span>
            </div>
            <div class="price-tier">
                <span>PRIME FULL</span>
                <span class="price">1100.00</span>
            </div>
            <div class="price-tier">
                <span>SUPERIOR FULL</span>
                <span class="price">1200.00</span>
            </div>
        </div>

        <div class="booking-summary">
            <h3>Booking Summary</h3>
            <p>Movie: <span id="movieTitle">${param.movie}</span></p>
            <p>Date: <span id="bookingDate">${param.date}</span></p>
            <p>Time: <span id="bookingTime">${param.time}</span></p>
            <p>Screen: <span id="screenType">${param.screenType}</span></p>
            <p>Selected Seats: <span id="selectedSeats">None</span></p>
            <p>Total Price: <span id="totalPrice">0</span> LKR</p>
        </div>

        <div class="action-buttons">
            <button class="btn-cancel" onclick="window.history.back()">Cancel</button>
            <button class="btn-proceed" id="confirmBtn" onclick="confirmBooking()" disabled>Confirm Booking</button>
        </div>
    </div>

    <%@include file="WEB-INF/jspSC/footer.jsp"%>

    <script>
        // Global variables
        const seatPrice = ${param.price};
        let selectedSeats = [];

        // Select seat function
        function selectSeat(element, seatNumber) {
            if (element.classList.contains('unavailable')) return;

            // Toggle seat selection
            element.classList.toggle('selected');

            // Update selected seats array
            const index = selectedSeats.indexOf(seatNumber);
            if (index === -1) {
                selectedSeats.push(seatNumber);
            } else {
                selectedSeats.splice(index, 1);
            }

            // Update UI
            updateBookingSummary();
        }

        // Update booking summary
        function updateBookingSummary() {
            document.getElementById('selectedSeats').textContent =
                selectedSeats.length > 0 ? selectedSeats.join(', ') : 'None';

            document.getElementById('totalPrice').textContent =
                selectedSeats.length * seatPrice;

            // Enable/disable confirm button
            document.getElementById('confirmBtn').disabled = selectedSeats.length === 0;
        }

        // Confirm booking function
        function confirmBooking() {
            if (selectedSeats.length === 0) {
                alert('Please select at least one seat');
                return;
            }

            const totalPrice = selectedSeats.length * seatPrice;

            // Create booking data object
            const bookingData = {
                movie: '${param.movie}',
                date: '${param.date}',
                time: '${param.time}',
                screenType: '${param.screenType}',
                seats: selectedSeats.join(','),
                totalPrice: totalPrice
            };

            // Create a form to submit the data to the server
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'bookingSave';
            
            // Add form fields for each piece of data
            for (const [key, value] of Object.entries(bookingData)) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = value;
                form.appendChild(input);
            }
            
            // Submit the form
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>