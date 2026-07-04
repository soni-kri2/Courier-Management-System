<!DOCTYPE html>
<html>
<head>
<title>User Registration</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    body {
        background: linear-gradient(135deg, #1e3a8a, #2563eb);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .card-custom {
        width: 100%;
        max-width: 500px;
        padding: 30px;
        border-radius: 20px;
        background: #fff;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        transition: 0.3s;
    }

    .card-custom:hover {
        transform: translateY(-5px);
    }

    .title {
        text-align: center;
        color: #1e3a8a;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 10px;
        padding: 10px;
    }

    textarea.form-control {
        height: 100px;
        resize: none;
    }

    .btn-custom {
        width: 100%;
        border-radius: 30px;
        padding: 10px;
        font-weight: 600;
        background: linear-gradient(135deg, #2563eb, #1e40af);
        border: none;
        color: white;
    }

    .btn-custom:hover {
        background: linear-gradient(135deg, #1e40af, #1e3a8a);
    }

    .icon {
        text-align: center;
        font-size: 50px;
        color: #2563eb;
        margin-bottom: 10px;
    }

</style>

</head>

<body>

<div class="card-custom">

    <!-- Icon -->
    <div class="icon">
        <i class="fa-solid fa-user-plus"></i>
    </div>

    <!-- Title -->
    <h3 class="title">Create Account</h3>

    <!-- Form -->
    <form action="register" method="post">

        <!-- Name -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-user"></i> Full Name
            </label>
            <input type="text" name="name" class="form-control" placeholder="Enter your name" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-envelope"></i> Email
            </label>
            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-lock"></i> Password
            </label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-phone"></i> Phone
            </label>
            <input type="text" name="phone" class="form-control" placeholder="Enter phone number">
        </div>

        <!-- Address -->
        <div class="mb-3">
            <label class="form-label">
                <i class="fa-solid fa-location-dot"></i> Address
            </label>
            <textarea name="address" class="form-control" placeholder="Enter your address"></textarea>
        </div>

        <!-- Button -->
        <button type="submit" class="btn btn-custom">
            <i class="fa-solid fa-user-check"></i> Register
        </button>

    </form>

    <!-- Login Link -->
    <div class="text-center mt-3">
        <small>Already have an account? 
            <a href="login.jsp">Login</a>
        </small>
    </div>

</div>

</body>
</html>