<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Review and Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body  class="h-100 bg-Feedback" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: lighten;">
<div class="container">
    <div class="feedback-container mt-5">
        <h2 class="text-center fw-bold">Rate Your Experience</h2>
        <p class="text-center text-muted">Tell us about your experience with our booking platform.</p>
        <form id="feedbackForm" method="post">
            <!-- Hidden action field -->
            <input type="hidden" name="action" id="actionType" value="add">

            <!-- Movie Name -->
            <div class="mb-3">
                <label for="movieName" class="form-label ">Movie Name:</label>
                <input type="text" class="form-control" id="movieName" name="movieName" placeholder="Enter Movie Name..." required>
            </div>

            <!-- Rating -->
            <div class="mb-3">
                <label class="form-label ">Your Rating:</label>
                <input type="hidden" id="ratingValue" name="rating" required>
                <div class="stars">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                </div>
            </div>

            <!-- Comment -->
            <div class="mb-3">
                <label for="comments" class="form-label ">Comment:</label>
                <textarea class="form-control" id="comments" name="comment" rows="3" placeholder="Write your review..." required></textarea>
            </div>

            <!-- Buttons -->
            <button type="submit" class="btn-primary" style="width: 100%" onclick="submitForm('add')">Submit Feedback</button>
            <br>
            <br>
            <button type="button" class="btn-primary" style="width: 100%" onclick="submitForm('delete')">Delete Feedback</button>
        </form>
    </div>
</div>

<script>
    // Star Rating Script
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('ratingValue');

    stars.forEach((star, index) => {
        star.addEventListener('click', () => {
            stars.forEach(s => s.classList.remove('selected'));
            for (let i = 0; i <= index; i++) {
                stars[i].classList.add('selected');
            }
            ratingInput.value = index + 1;
        });
    });

    // Form Action Switcher
    function submitForm(action) {
        const form = document.getElementById("feedbackForm");
        document.getElementById("actionType").value = action;

        if (action === "add") {
            form.action = "feedback"; // FeedbackServlet
        } else if (action === "delete") {
            form.action = "deleteFeedback"; // DeleteFeedbackServlet
        }

        form.submit();
    }
</script>
</body>
</html>