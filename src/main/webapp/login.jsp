<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Login - CourierMS</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(145deg, #0B2B5E 0%, #0F3B7A 45%, #1E4A8F 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background elements (courier themed abstract parcels/lines) */
        body::before {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800" opacity="0.08"><path fill="none" stroke="%23ffffff" stroke-width="2" d="M0,400 L1200,400 M200,0 L200,800 M400,0 L400,800 M600,0 L600,800 M800,0 L800,800 M1000,0 L1000,800"/><circle cx="300" cy="250" r="40" stroke="white" stroke-width="1.5" fill="none"/><rect x="700" y="500" width="70" height="50" stroke="white" stroke-width="1.5" fill="none" /><polygon points="850,620 880,590 910,620 880,650" stroke="white" stroke-width="1.5" fill="none"/><path d="M100 650 L130 620 L160 650 L130 680 Z" stroke="white" fill="none"/><path d="M1050 180 L1080 150 L1110 180 L1080 210 Z" stroke="white" fill="none"/></svg>');
            background-repeat: repeat;
            background-size: 280px;
            pointer-events: none;
            z-index: 0;
        }

        /* floating particles / courier dots */
        body::after {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 40%, rgba(59,130,246,0.15) 0%, transparent 35%),
                        radial-gradient(circle at 85% 70%, rgba(37,99,235,0.12) 0%, transparent 40%);
            pointer-events: none;
            z-index: 0;
        }

        /* main container */
        .login-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 2;
            padding: 1.5rem;
        }

        /* modern glassmorphic card with clean white background + subtle blue border */
        .login-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(0px);
            width: 100%;
            max-width: 440px;
            padding: 2.5rem 2rem 2.8rem;
            border-radius: 2rem;
            box-shadow: 0 25px 45px -12px rgba(0, 0, 0, 0.35), 0 8px 18px rgba(0, 0, 0, 0.05);
            transition: transform 0.25s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(59, 130, 246, 0.2);
            text-align: center;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 50px -15px rgba(0, 0, 0, 0.4);
        }

        /* brand / courier icon */
        .brand-icon {
            background: linear-gradient(135deg, #2563EB, #1E40AF);
            width: 70px;
            height: 70px;
            margin: 0 auto 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 28px;
            box-shadow: 0 12px 20px -8px rgba(37, 99, 235, 0.4);
        }

        .brand-icon i {
            font-size: 2.3rem;
            color: white;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        /* title & subtitle */
        .login-title {
            font-size: 1.9rem;
            font-weight: 700;
            background: linear-gradient(135deg, #1E3A8A, #3B82F6);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            letter-spacing: -0.3px;
            margin-bottom: 0.4rem;
        }

        .login-subtitle {
            color: #4B5563;
            font-weight: 500;
            font-size: 0.95rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid #EFF6FF;
            display: inline-block;
            padding-bottom: 6px;
        }

        /* input groups with icons */
        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
            width: 100%;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #9CA3AF;
            font-size: 1.1rem;
            transition: color 0.2s ease;
            pointer-events: none;
        }

        .login-card input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            font-size: 0.95rem;
            font-weight: 500;
            font-family: 'Inter', sans-serif;
            border: 1.5px solid #E2E8F0;
            border-radius: 18px;
            background-color: #F9FAFB;
            transition: all 0.2s ease;
            color: #111827;
            outline: none;
        }

        .login-card input:focus {
            border-color: #3B82F6;
            background-color: #FFFFFF;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
        }

        .login-card input:focus + .input-icon {
            color: #2563EB;
        }

        .login-card input::placeholder {
            color: #9CA3AF;
            font-weight: 400;
        }

        /* row: remember & forgot */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0.5rem 0 1.8rem 0;
            font-size: 0.85rem;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: #4B5563;
            font-weight: 500;
        }

        .checkbox-label input {
            width: 16px;
            height: 16px;
            accent-color: #2563EB;
            margin: 0;
            cursor: pointer;
        }

        .forgot-link {
            color: #2563EB;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .forgot-link i {
            font-size: 0.75rem;
        }

        .forgot-link:hover {
            color: #1E40AF;
            text-decoration: underline;
        }

        /* modern blue button */
        .login-btn {
            width: 100%;
            padding: 14px 0;
            background: linear-gradient(105deg, #2563EB 0%, #1E40AF 100%);
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            color: white;
            cursor: pointer;
            transition: all 0.25s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 8px 18px -6px rgba(37, 99, 235, 0.4);
            letter-spacing: 0.3px;
        }

        .login-btn i {
            font-size: 1rem;
            transition: transform 0.2s;
        }

        .login-btn:hover {
            background: linear-gradient(105deg, #1E40AF 0%, #1E3A8A 100%);
            transform: scale(1.01);
            box-shadow: 0 12px 22px -8px rgba(37, 99, 235, 0.5);
        }

        .login-btn:hover i {
            transform: translateX(4px);
        }

        /* extra demo hint & footer */
        .demo-hint {
            margin-top: 2rem;
            background: #F0F9FF;
            border-radius: 40px;
            padding: 10px 12px;
            font-size: 0.7rem;
            color: #1E40AF;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            border: 1px solid rgba(37, 99, 235, 0.2);
        }

        .demo-hint i {
            font-size: 0.7rem;
            color: #3B82F6;
        }

        .secure-footer {
            margin-top: 1.6rem;
            font-size: 0.7rem;
            color: #6B7280;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .secure-footer i {
            color: #10B981;
        }

        /* responsive */
        @media (max-width: 500px) {
            .login-card {
                padding: 2rem 1.5rem;
            }
            .login-title {
                font-size: 1.6rem;
            }
            .brand-icon {
                width: 60px;
                height: 60px;
            }
            .brand-icon i {
                font-size: 2rem;
            }
            .form-options {
                flex-direction: row;
                flex-wrap: wrap;
                gap: 10px;
            }
        }
    </style>
</head>

<body>
<%@ include file="components/navbar.jsp" %>
<section>
<div class="login-container">
    <div class="login-card">
        <!-- Courier brand symbol -->
        <div class="brand-icon">
            <i class="fas fa-truck-fast"></i>
        </div>

        <!-- Heading with courier system identity -->
        <h2 class="login-title">CourierFlow</h2>
        <p class="login-subtitle">Delivery Management System</p>
        <!-- 🔴 ADD ERROR MESSAGE HERE -->
		<% String error = (String) request.getAttribute("errorMessage"); %>
		<% if (error != null) { %>
		    <div style="color:red; font-weight:bold;">
		        <%= error %>
		    </div>
		<% } %>
        <!-- LOGIN FORM (preserves original backend action) -->
        <form action="<%=request.getContextPath()%>/login" method="post">
            <!-- Email / Username field with envelope icon -->
            <div class="input-group">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" name="email" placeholder="Work email address" required autocomplete="email">
            </div>

            <!-- Password field with lock icon -->
            <div class="input-group">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
            </div>

            <!-- Options row: remember me & forgot password (improved UX) -->
            <div class="form-options">
                <label class="checkbox-label">
                    <input type="checkbox" name="remember"> Keep me signed in
                </label>
                <a href="#" class="forgot-link">
                    <i class="fas fa-key"></i> Forgot password?
                </a>
            </div>

            <!-- Sign in button with arrow icon -->
            <button type="submit" class="login-btn">
                <span>Access Dashboard</span> <i class="fas fa-arrow-right"></i>
            </button>
        </form>

        <!-- subtle demo hint for courier staff (purely design/helpful) -->
        <div class="demo-hint">
            <i class="fas fa-id-card"></i> Demo: admin@courier.com |  demo123
        </div>

        <!-- trust & courier badge -->
        <div class="secure-footer">
            <i class="fas fa-shield-alt"></i> Encrypted connection
            <span style="width:4px;height:4px;background:#CBD5E1;border-radius:50%;display:inline-block;"></span>
            <i class="fas fa-box"></i> Real-time tracking ready
        </div>
    </div>
</div>

</section>
<%@ include file="components/footer.jsp" %>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
// purely for design enhancement: if you click on demo hint it fills fields (no backend effect, just user-friendly)
const demoHint = document.querySelector('.demo-hint');
if(demoHint) {
    demoHint.style.cursor = 'pointer';
    demoHint.addEventListener('click', function(e) {
        const emailInput = document.querySelector('input[name="email"]');
        const passInput = document.querySelector('input[name="password"]');
        if(emailInput && passInput) {
            emailInput.value = 'admin@courier.com';
            passInput.value = 'demo123';
            // add little micro-feedback
            demoHint.style.backgroundColor = '#E6F0FF';
            setTimeout(() => {
                demoHint.style.backgroundColor = '#F0F9FF';
            }, 300);
        }
    });
}
</script>
</html>