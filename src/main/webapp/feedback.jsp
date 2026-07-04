<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Feedback</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    body {
        background: linear-gradient(135deg, #0f3b7a, #1e4a8f);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .card-custom {
        width: 100%;
        max-width: 500px;
        border-radius: 20px;
        padding: 30px;
        background: #ffffff;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        transition: 0.3s;
    }

    .card-custom:hover {
        transform: translateY(-5px);
    }

    .title {
        text-align: center;
        font-weight: bold;
        color: #1e3a8a;
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 10px;
    }

    .btn-custom {
        width: 100%;
        border-radius: 30px;
        padding: 10px;
        font-weight: 600;
        background: linear-gradient(135deg, #16a34a, #15803d);
        border: none;
        color: white;
    }

    .btn-custom:hover {
        background: linear-gradient(135deg, #15803d, #14532d);
    }

    .icon {
        font-size: 50px;
        color: #16a34a;
        text-align: center;
        margin-bottom: 10px;
    }

    textarea {
        resize: none;
    }
</style>

</head>

<body>

<div class="card-custom">

    <!-- Icon -->
    <div class="icon">
        <i class="fa-solid fa-star"></i>
    </div>

    <!-- Title -->
    <h3 class="title">Give Your Feedback</h3>

    <!-- Form -->
    <form action="<%=request.getContextPath()%>/submitFeedback" method="post">

        <!-- Message -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-comment"></i> Your Message
            </label>
            <textarea name="message" class="form-control" rows="4" placeholder="Write your feedback..." required></textarea>
        </div>

        <!-- Rating -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-star-half-stroke"></i> Rating
            </label>
            <select name="rating" class="form-control">
                <option value="5">⭐⭐⭐⭐⭐ Excellent</option>
                <option value="4">⭐⭐⭐⭐ Good</option>
                <option value="3">⭐⭐⭐ Average</option>
                <option value="2">⭐⭐ Poor</option>
                <option value="1">⭐ Very Bad</option>
            </select>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-custom">
            <i class="fa-solid fa-paper-plane"></i> Submit Feedback
        </button>

    </form>

</div>

</body>
</html>