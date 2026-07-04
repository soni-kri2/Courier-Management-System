<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    body {
        margin: 0;
        padding: 0;
        height: 100vh;
        background: linear-gradient(135deg, #0f3b7a, #1e4a8f);
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .login-card {
        width: 100%;
        max-width: 400px;
        background: #fff;
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        transition: 0.3s;
    }

    .login-card:hover {
        transform: translateY(-5px);
    }

    .title {
        text-align: center;
        font-weight: bold;
        color: #1e3a8a;
        margin-bottom: 20px;
    }

    .icon {
        text-align: center;
        font-size: 50px;
        color: #2563eb;
        margin-bottom: 10px;
    }

    .form-control {
        border-radius: 10px;
        padding: 10px;
    }

    .btn-custom {
        width: 100%;
        border-radius: 30px;
        padding: 10px;
        font-weight: bold;
        background: linear-gradient(135deg, #2563eb, #1e40af);
        border: none;
        color: white;
    }

    .btn-custom:hover {
        background: linear-gradient(135deg, #1e40af, #1e3a8a);
    }

    .input-group-text {
        background: #2563eb;
        color: white;
        border-radius: 10px 0 0 10px;
    }

</style>

</head>

<body>

<div class="login-card">

    <!-- Icon -->
    <div class="icon">
        <i class="fa-solid fa-user-shield"></i>
    </div>

    <!-- Title -->
    <h3 class="title">Admin Login</h3>

    <!-- Form -->
    <form action="<%=request.getContextPath()%>/login" method="post">

        <!-- Email -->
        <div class="mb-3 input-group">
            <span class="input-group-text">
                <i class="fa-solid fa-envelope"></i>
            </span>
            <input type="email" name="email" class="form-control" placeholder="Enter admin email" required>
        </div>

        <!-- Password -->
        <div class="mb-3 input-group">
            <span class="input-group-text">
                <i class="fa-solid fa-lock"></i>
            </span>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <!-- Button -->
        <button type="submit" class="btn btn-custom">
            <i class="fa-solid fa-right-to-bracket"></i> Login
        </button>

    </form>

</div>

</body>
</html>