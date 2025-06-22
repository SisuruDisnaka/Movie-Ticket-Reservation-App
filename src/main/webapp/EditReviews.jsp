<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Reviews</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="stylesheet.css">
</head>
<body  class="h-100 bg-Feedback" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: lighten;">
<div class="container">
    <div class="feedback-container mt-5">
        <h2 class="text-center fw-bold">Update Your Feedback</h2>

        <form  id="feedbackForm" action="Edit" method="post">
            <input type="hidden" name="actionType" id="actionType" value="Edit">

            <div class="mb-3">
                <label for="movieName" class="form-label">Movie Name:</label>
                <input type="text" name="movieName" class="form-control" id="movieName" placeholder="Enter Movie Name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Your Rating:</label>
                <input type="hidden" id="rating" name="rating" required>
                <div class="rating">
                    <span class="star" data-value="1">&#9733;</span>
                    <span class="star" data-value="2">&#9733;</span>
                    <span class="star" data-value="3">&#9733;</span>
                    <span class="star" data-value="4">&#9733;</span>
                    <span class="star" data-value="5">&#9733;</span>
                </div>
            </div>

            <div class="mb-3">
                <label for="comments" class="form-label">Comment:</label>
                <textarea name="comment" class="form-control" id="comments" rows="3" placeholder="Write your review..." required></textarea>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%" onclick="EditForm('Edit')">Edit Feedback</button>
            <br>
            <br>
            <button type="submit" class="btn btn-primary" style="width: 100%" onclick="EditForm('delete')">Delete Feedback</button>
        </form>




    </div>
</div>

<script>
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('rating');

    stars.forEach(star => {
        star.addEventListener('click', () => {
            const rating = star.getAttribute('data-value');
            ratingInput.value = rating;

            stars.forEach(s => s.classList.remove('selected'));
            for (let i = 0; i < rating; i++) {
                stars[i].classList.add('selected');
            }
        });
    });
    function EditForm(action) {
        const form = document.getElementById("feedbackForm");
        document.getElementById("actionType").value = action;

        if (action === "Edit") {
            form.action = "Edit"; // FeedbackServlet
        } else if (action === "delete") {
            form.action = "deleteFeedback"; // DeleteFeedbackServlet
        }

        form.submit();
    }
</script>

</body>
</html>