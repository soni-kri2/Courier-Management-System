<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Track Courier</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    body {
        background: linear-gradient(135deg, #1e3c72, #2a5298);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .card {
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        border: none;
    }

    .title {
        font-weight: bold;
        color: #1e3c72;
    }

    .btn-custom {
        background-color: #1e3c72;
        color: white;
        border-radius: 25px;
        transition: 0.3s;
    }

    .btn-custom:hover {
        background-color: #16325c;
        transform: scale(1.05);
    }

    .input-group-text {
        background-color: #1e3c72;
        color: white;
        border-radius: 10px 0 0 10px;
    }

    .form-control {
        border-radius: 0 10px 10px 0;
    }
</style>

</head>

<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <div class="card text-center">

                <!-- Icon -->
                <div class="mb-3">
                    <i class="fa-solid fa-box fa-3x text-primary"></i>
                </div>

                <!-- Title -->
                <h3 class="title mb-3">Track Your Courier 📦</h3>
                <p class="text-muted">Enter your tracking number to get delivery status</p>

                <!-- Form -->
                <form action="trackCourier" method="get">

                    <div class="input-group mb-4">
                        <span class="input-group-text">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </span>
                        <input type="text" name="tracking" class="form-control" placeholder="Enter Tracking Number" required>
                    </div>

                    <button type="submit" class="btn btn-custom w-100">
                        <i class="fa-solid fa-location-dot"></i> Track Now
                    </button>

                </form>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>