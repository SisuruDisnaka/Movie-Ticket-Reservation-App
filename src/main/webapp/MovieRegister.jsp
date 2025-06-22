<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Movie Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="h-100 bg-hero" style="background-color: rgba(0, 0, 0, 0.7); background-blend-mode: darken;">

<div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card p-4 login-card text-white" style="width: 50vw;">
        <h3 class="text-center fw-bold mb-4">Add Movies</h3>
        <form action="registerMovie" method="post" enctype="multipart/form-data">
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Movie Name" name="movieName" required>
                <i class="bi bi-film position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Director" name="director" required>
                <i class="bi bi-person-video3 position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3 position-relative">
                <input type="text" class="form-control ps-5" placeholder="Main Character(s)" name="mainCharacter" required>
                <i class="bi bi-people-fill position-absolute top-50 start-0 translate-middle-y ms-3"></i>
            </div>
            <div class="mb-3">
                <label class="form-label">Upload Movie Image</label>
                <input type="file" class="form-control" name="image" accept="image/*" required>
            </div>
            <div class="row g-2 mb-3">
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Premium Ticket Price" name="pricePremium" required>
                </div>
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Boutique Ticket Price" name="priceBoutique" required>
                </div>
                <div class="col-md-4">
                    <input type="number" step="100" class="form-control" placeholder="Standard Ticket Price" name="priceStandard" required>
                </div>
            </div>

            <div id="timeSlotsContainer" class="mb-3">
                <label class="form-label">Showing Dates, Time Slots & Screens</label>
                <div class="row g-2 mb-2 align-items-center">
                    <div class="col-md-4">
                        <input type="date" class="form-control" name="showingDates[]" required>
                    </div>
                    <div class="col-md-4">
                        <input type="time" class="form-control" name="timeSlots[]" required>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" name="screens[]" required>
                            <option value="">-select screen-</option>
                            <option value="Premium">Premium</option>
                            <option value="Boutique">Boutique</option>
                            <option value="Standard">Standard</option>
                        </select>
                    </div>
                </div>
            </div>

            <button type="button" class="btn btn-outline-light mb-3" onclick="addTimeSlot()">+ Add Slot</button>

            <button type="submit" class="btn btn-primary w-100 text-dark fw-bold">Register Movie</button>
        </form>
    </div>
</div>

<script>
    function addTimeSlot() {
        const container = document.getElementById('timeSlotsContainer');
        const row = document.createElement('div');
        row.classList.add('row', 'g-2', 'mb-2', 'align-items-center');

        row.innerHTML = `
      <div class="col-md-4">
        <input type="date" class="form-control" name="showingDates[]" required>
      </div>
      <div class="col-md-3">
        <input type="time" class="form-control" name="timeSlots[]" required>
      </div>
      <div class="col-md-3">
          <select class="form-select" name="screens[]" required>
            <option value="">Select Screen</option>
            <option value="Premium">Premium</option>
            <option value="Boutique">Boutique</option>
            <option value="Standard">Standard</option>
          </select>
      </div>
      <div class="col-md-2 text-end">
        <button type="button" class="btn btn-danger" onclick="removeSlot(this)">&times;</button>
      </div>
    `;

        container.appendChild(row);
    }

    function removeSlot(button) {
        const row = button.closest('.row');
        row.remove();
    }
</script>

</body>
</html>