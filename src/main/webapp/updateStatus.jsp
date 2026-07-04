<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Update Courier Status</title>

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
        background: linear-gradient(135deg, #2563eb, #1e40af);
        border: none;
    }

    .btn-custom:hover {
        background: linear-gradient(135deg, #1e40af, #1e3a8a);
    }

    .icon {
        font-size: 50px;
        color: #2563eb;
        text-align: center;
        margin-bottom: 10px;
    }
</style>

</head>

<body>

<div class="card-custom">

    <!-- Icon -->
    <div class="icon">
        <i class="fa-solid fa-truck-fast"></i>
    </div>

    <!-- Title -->
    <h3 class="title">Update Courier Status</h3>

    <!-- Form -->
    <form action="<%=request.getContextPath()%>/UpdateStatusServlet" method="post">

        <!-- Tracking Number -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-barcode"></i> Tracking Number
            </label>
            <input type="text" name="tracking" class="form-control" placeholder="Enter tracking number" required>
        </div>

        <!-- Status -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-location-dot"></i> Status
            </label>
            <select name="status" class="form-control">
                <option>Booked</option>
                <option>In Transit</option>
                <option>Delivered</option>
            </select>
        </div>

        <!-- Button -->
        <button type="submit" class="btn btn-custom">
            <i class="fa-solid fa-pen"></i> Update Status
        </button>

    </form>

</div>

</body>
</html>