
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Courier Management System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
</head>

<body>
<%@ include file="components/navbar.jsp" %>

<!-- HERO SECTION -->

<section class="hero">

<div>

<h1>Fast & Reliable Courier Services</h1>

<p>Send, Track and Manage your courier easily.</p>

<a href="register.jsp">
<button class="btn text-white">Get Started</button>
</a>

</div>

</section>

<!-- --------- About section  -->
<!-- --------- About Section --------- -->
<section class="container py-5">

<div class="row align-items-center">

    <!-- LEFT IMAGE -->
    <div class="col-lg-6 col-md-12 text-center mb-4">

        <img src="${pageContext.request.contextPath}/image/about-image.png" 
             class="img-fluid about-img"
             alt="Courier Service">

    </div>

    <!-- RIGHT CONTENT -->
    <div class="col-lg-6 col-md-12">

        <h2 class="fw-bold mb-3">About Our Courier System</h2>

        <p class="text-muted">
            Our Courier Management System is designed to simplify courier booking, 
            tracking, and management. It provides users with a seamless experience 
            to send packages and monitor delivery status in real time.
        </p>

        <p class="text-muted">
            With advanced features like tracking, secure payments, and complaint handling, 
            we ensure reliable and efficient delivery services.
        </p>

        <!-- Features -->
        <ul class="about-list">
            <li><i class="fa-solid fa-check"></i> Easy Courier Booking</li>
            <li><i class="fa-solid fa-check"></i> Real-Time Tracking</li>
            <li><i class="fa-solid fa-check"></i> Fast & Secure Delivery</li>
            <li><i class="fa-solid fa-check"></i> Customer Support System</li>
        </ul>

        <a href="register.jsp" class="btn btn-primary mt-3">
            Get Started
        </a>

    </div>

</div>

</section>

<!-- Services Section - fully responsive, card-based, with attractive images/icons -->
<section class="services-section">
    <div class="container">
        <!-- Section Header -->
        <div class="section-title">
            <h2><i class="fas fa-boxes me-2" style="background: none; color: #2563EB; font-size: 2rem;"></i> Our Premium Services</h2>
            <div class="title-underline"></div>
            <p class="section-sub">Fast, reliable & tech-enabled courier solutions tailored for your business</p>
        </div>

        <!-- Bootstrap row with g-4 gap -->
        <div class="row g-4">
            <!-- Service 1: Courier Booking -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h4>Courier Booking</h4>
                    <p>Seamless online booking with instant confirmation. Schedule pickups in just a few clicks.</p>
                    <!-- optional decorative badge -->
                    <div class="badge-service">Instant</div>
                </div>
            </div>

            <!-- Service 2: Real-Time Tracking (Live Tracking) -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <h4>Live Tracking</h4>
                    <p>Real-time GPS tracking with accurate ETAs and live location updates for every parcel.</p>
                </div>
            </div>

            <!-- Service 3: Fast Delivery -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-truck-fast"></i>
                    </div>
                    <h4>Fast Delivery</h4>
                    <p>Same-day & express delivery options. Optimized routes for speed and reliability.</p>
                </div>
            </div>

            <!-- Service 4: Secure Payment -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-credit-card"></i>
                    </div>
                    <h4>Secure Payment</h4>
                    <p>Multiple gateways: cards, UPI, wallets. End-to-end encrypted transactions.</p>
                </div>
            </div>

            <!-- Service 5: Order Management -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h4>Order Management</h4>
                    <p>Centralized dashboard to view, edit, and analyze all your shipments and history.</p>
                </div>
            </div>

            <!-- Service 6: Support & Complaint -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="service-card">
                    <div class="icon-wrapper">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4>Support System</h4>
                    <p>24/7 dedicated support & automated complaint resolution for hassle-free experience.</p>
                </div>
            </div>
        </div>

        <!-- optional extra call-to-action or decorative text -->
        <div class="text-center mt-5 pt-3">
            <a href="#" class="btn btn-primary rounded-pill px-4 py-2" style="background: #2563EB; border: none; font-weight: 500;">
                <i class="fas fa-rocket me-2"></i> Explore All Services
            </a>
        </div>
    </div>

    <!-- decorative floating image (abstract delivery illustration) -->
   	
</section>

<!-- FEATURES -->

<section class="features container my-2">
<div class="row">
<div class="feature-card col-lg-4">

<h3><i class="fa-solid fa-box"></i>Easy Booking</h3>

<p>Book your courier in seconds with our simple interface.</p>

</div>


<div class="feature-card col-lg-4">

<h3><i class="fa-solid fa-location-dot"></i> Live Tracking</h3>

<p>Track your package status in real-time.</p>

</div>


<div class="feature-card col-lg-4">

<h3><i class="fa-solid fa-bolt"></i> Fast Delivery</h3>

<p>Reliable and fast courier delivery service.</p>

</div>

</div>


</section>


<%@ include file="components/footer.jsp" %>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</html>