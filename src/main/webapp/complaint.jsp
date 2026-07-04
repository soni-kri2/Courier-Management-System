<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Raise Complaint</title>

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
        padding: 10px;
    }

    textarea.form-control {
        resize: none;
        height: 120px;
    }

    .btn-custom {
        width: 100%;
        border-radius: 30px;
        padding: 10px;
        font-weight: 600;
        background: linear-gradient(135deg, #dc2626, #991b1b);
        border: none;
        color: white;
    }

    .btn-custom:hover {
        background: linear-gradient(135deg, #991b1b, #7f1d1d);
    }

    .icon {
        font-size: 50px;
        color: #dc2626;
        text-align: center;
        margin-bottom: 10px;
    }
</style>

</head>

<body>

<div class="card-custom">

    <!-- Icon -->
    <div class="icon">
        <i class="fa-solid fa-triangle-exclamation"></i>
    </div>

    <!-- Title -->
    <h3 class="title">Raise Complaint</h3>

    <!-- Form -->
    <form action="<%=request.getContextPath()%>/submitComplaint" method="post">

        <!-- Subject -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-heading"></i> Subject
            </label>
            <input type="text" name="subject" class="form-control" placeholder="Enter complaint subject" required>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-comment-dots"></i> Description
            </label>
            <textarea name="description" class="form-control" placeholder="Describe your issue..." required></textarea>
        </div>

        <!-- Button -->
        <button type="submit" class="btn btn-custom">
            <i class="fa-solid fa-paper-plane"></i> Submit Complaint
        </button>

    </form>

</div>

</body>
</html>