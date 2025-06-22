<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Oppenheimer | PopComPulse</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
    <div class="logo-container">
        <h1 class="logo">PopComPulse</h1>
        <p class="tagline">Streamline Your Movie Night - Book in Seconds</p>
    </div>
    <nav>
        <ul class="nav-links">
            <li><a href="home.jsp"><i class="fas fa-arrow-left"></i> Back</a></li>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="home.jsp">Now Showing</a></li>
            <li><a href="home.jsp">Coming Soon</a></li>
        </ul>
        <div class="nav-icons">
            <a href="#"><i class="fas fa-search"></i></a>
            <a href="seating.jsp"><i class="fas fa-ticket-alt"></i></a>
            <a href="#"><i class="fas fa-shopping-cart"></i></a>
            <a href="UserProfile.jsp"><i class="fas fa-user-circle"></i></a>
        </div>
    </nav>
</header>

<main class="movie-details-container">
    <section class="movie-header">
        <div class="movie-title">
            <h1>Oppenheimer</h1>
            <div class="movie-meta">
                <span>(A)</span>
                <span>3h 00m</span>
                <span>Thursday, May 01, 2023</span>
                <span>English</span>
                <span>Thriller/Historical drama</span>
            </div>
            <div class="movie-cast">
                <p>Cillian Murphy, Emily Blunt, Matt Damon</p>
            </div>
        </div>
    </section>

    <section class="showtimes-section">
        <h2>SHOWTIMES</h2>
        <div class="showtimes-filter">
            <div class="filter-item selected" onclick="selectDate('sun', '2023-05-21')">SUN </div>
            <div class="filter-item" onclick="selectDate('mon', '2023-05-22')">MON </div>
            <div class="filter-item" onclick="selectDate('tue', '2023-05-23')">TUE </div>
            <div class="filter-item" onclick="selectDate('wed', '2023-05-24')">WED </div>
            <div class="filter-item" onclick="selectDate('thu', '2023-05-25')">THU </div>
            <div class="filter-item" onclick="selectDate('fri', '2023-05-26')">FRI </div>
            <div class="filter-item" onclick="selectDate('sat', '2023-05-27')">SAT </div>
        </div>

        <div class="showtimes-summary">
            <div class="summary-item">
                <span>10</span>
                <span>SHOWS</span>
            </div>
            <div class="summary-item">
                <span>ALL</span>
                <span>CINEMA FORMAT</span>
            </div>
            <div class="summary-item">
                <span>LKR. 1300 - 3200</span>
                <span>PRICE RANGE</span>
            </div>
            <div class="summary-item">
                <span>2:00 - 24:00</span>
                <span>SHOWTIMES</span>
            </div>
        </div>
    </section>

    <section class="cinema-search">
        <div class="search-header">
            <h3>CINEMAS...</h3>
            <div class="status-tags">
                <span class="status-tag available">AVAILABLE</span>
                <span class="status-tag filling">FILLING FAST</span>
                <span class="status-tag sold">SOLD OUT</span>
                <span class="status-tag lapsed">LAPSED</span>
            </div>
        </div>

        <div class="cinema-list">
            <div class="cinema-item">
                <div class="cinema-header">
                    <h4>PCP Colombo City Center Mall</h4>
                </div>
                <div class="cinema-format">
                    <h5>PCP LUXURY</h5>
                    <div class="showtimes">
                        <span class="language">English - 2D</span>
                        <span class="time" onclick="selectTime(this, 'luxury', '12:45 PM', 3200)">12:45 PM</span>
                        <span class="time" onclick="selectTime(this, 'luxury', '8:15 PM', 3200)">8:15 PM</span>
                    </div>
                </div>
                <div class="cinema-format">
                    <h5>PCP STANDARD</h5>
                    <div class="showtimes">
                        <span class="language">English - 2D</span>
                        <span class="time" onclick="selectTime(this, 'standard', '10:30 AM', 2200)">10:30 AM</span>
                        <span class="time" onclick="selectTime(this, 'standard', '2:15 PM', 2200)">2:15 PM</span>
                        <span class="time" onclick="selectTime(this, 'standard', '6:00 PM', 2200)">6:00 PM</span>
                        <span class="time" onclick="selectTime(this, 'standard', '10:00 PM', 2200)">10:00 PM</span>
                    </div>
                </div>
            </div>
            <div class="cinema-item">
                <div class="cinema-header">
                    <h4>PCP Cinema</h4>
                </div>
                <div class="cinema-format">
                    <h5>PCP PREMIUM</h5>
                    <div class="showtimes">
                        <span class="language">English - 2D</span>
                        <span class="time" onclick="selectTime(this, 'premium', '11:00 AM', 2800)">11:00 AM</span>
                        <span class="time" onclick="selectTime(this, 'premium', '3:00 PM', 2800)">3:00 PM</span>
                        <span class="time" onclick="selectTime(this, 'premium', '7:00 PM', 2800)">7:00 PM</span>
                        <span class="time" onclick="selectTime(this, 'premium', '10:30 PM', 2800)">10:30 PM</span>
                    </div>
                </div>
            </div>
            <div class="book-now-container">
                <form action="seating.jsp" method="get" id="bookingForm">
                    <input type="hidden" name="movie" value="Oppenheimer">
                    <input type="hidden" name="date" id="selectedDate" value="2023-05-21">
                    <input type="hidden" name="time" id="selectedTime">
                    <input type="hidden" name="screenType" id="selectedScreenType">
                    <input type="hidden" name="price" id="selectedPrice">
                    <button type="submit" class="book-now-btn" id="continueBtn" disabled>Continue</button>
                </form>
            </div>
        </div>
    </section>
</main>

<footer>
    <div class="footer-content">
        <div class="footer-logo">
            <h2>PopComPulse</h2>
            <p>Book your perfect movie night</p>
        </div>
        <div class="footer-links">
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact</a></li>
                <li><a href="#">Feedback</a></li>
                <li><a href="#">Terms</a></li>
                <li><a href="#">Privacy</a></li>
            </ul>
        </div>
    </div>
</footer>
<script>
    // Store selections
    let selections = {
        date: '2023-05-21',
        day: 'sun',
        time: null,
        screenType: null,
        price: null
    };

    // Date selection
    function selectDate(day, date) {
        // Update UI
        document.querySelectorAll('.filter-item').forEach(item => {
            item.classList.remove('selected');
        });
        event.currentTarget.classList.add('selected');

        // Store selection
        selections.day = day;
        selections.date = date;
        document.getElementById('selectedDate').value = date;

        // Only update button state if time is already selected
        if (selections.time) {
            updateContinueButton();
        }
    }

    // Time selection
    function selectTime(element, screenType, time, price) {
        // Update UI
        document.querySelectorAll('.time').forEach(timeElement => {
            timeElement.classList.remove('selected');
        });
        element.classList.add('selected');

        // Store selection
        selections.time = time;
        selections.screenType = screenType;
        selections.price = price;

        document.getElementById('selectedTime').value = time;
        document.getElementById('selectedScreenType').value = screenType;
        document.getElementById('selectedPrice').value = price;

        updateContinueButton();
    }

    // Update continue button state
    function updateContinueButton() {
        const continueBtn = document.getElementById('continueBtn');
        continueBtn.disabled = !(selections.date && selections.time && selections.screenType);

        if (!continueBtn.disabled) {
            continueBtn.classList.add('active');
        } else {
            continueBtn.classList.remove('active');
        }
    }
</script>
</body>
</html>