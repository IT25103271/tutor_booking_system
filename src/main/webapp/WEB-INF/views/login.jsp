<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Login | Tutor Booking</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --dark-navy: #1a1a2e;
            --navy-blue: #16213e;
            --accent-red: #e94560;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
        }

        body {
            background: #f0f2f5;
            font-family: 'Inter', sans-serif;
            color: #1a1a2e;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar Styles */
        .navbar {
            background: linear-gradient(135deg, var(--dark-navy), var(--navy-blue));
            padding: 1rem 2rem;
            border-bottom: 2px solid var(--accent-red);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.5px;
            color: white !important;
        }

        .auth-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 4rem 1rem;
        }

        .card-custom {
            background: white;
            border-radius: 24px;
            border: none;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 3.5rem;
            width: 100%;
            max-width: 480px;
            animation: fadeInUp 0.8s ease-out both;
        }

        .logo-icon {
            width: 60px;
            height: 60px;
            background: var(--accent-red);
            border-radius: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-size: 0.8rem;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-control {
            border-radius: 12px;
            padding: 0.8rem 1.2rem;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background-color: white;
            border-color: var(--accent-red);
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
            outline: none;
        }

        .btn-navy {
            background: var(--dark-navy);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-weight: 700;
            width: 100%;
            margin-top: 1.5rem;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-navy:hover {
            background: var(--navy-blue);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(26, 26, 46, 0.2);
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .footer {
            background: var(--dark-navy);
            color: rgba(255,255,255,0.6);
            padding: 3rem 0;
            border-top: 3px solid var(--accent-red);
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/login">
                <i class="bi bi-mortarboard-fill me-2 fs-3 text-white"></i>
                <span class="fs-4">Tutor Booking</span>
            </a>
            <div class="ms-auto">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-sm rounded-pill px-4">
                    Join as Tutor
                </a>
            </div>
        </div>
    </nav>

    <div class="auth-container">
        <div class="card-custom text-center">
            <div class="logo-icon">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <h2 class="fw-bold text-navy-blue mb-1">  Welcome </h2>
            <p class="text-muted mb-4">Please enter your details to login</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-custom mb-4 py-2 small" role="alert">
                    <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                </div>
            </c:if>
            <c:if test="${param.registered}">
                <div class="alert alert-success alert-custom mb-4 py-2 small" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> Registration successful!
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="text-start">
                <div class="mb-4">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" required placeholder="name@example.com">
                </div>
                <div class="mb-4">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required placeholder="••••••••">
                </div>
                
                <button type="submit" class="btn-navy">
                    Sign In <i class="bi bi-arrow-right ms-2"></i>
                </button>
            </form>
            
            <p class="mt-4 mb-0 text-muted small">
                Don't have an account? <a href="${pageContext.request.contextPath}/register" class="text-accent-red fw-bold text-decoration-none" style="color: var(--accent-red);">Register here</a>
            </p>
        </div>
    </div>

    <!-- Footer -->
    <!-- Main content -->
    <div class="main-content">
        <!-- Your booking content, tables, etc. -->
    </div>

    <!-- Footer moved above the photo -->
    <footer style="background:#0f172a;color:#fff;padding:3rem 2rem 1.5rem;font-family:sans-serif;">
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:2rem;margin-bottom:2rem;">

            <!-- Column 1: Brand -->
            <div>
                <div style="display:flex;align-items:center;gap:10px;margin-bottom:0.75rem;">
                    🎓
                    <span style="font-size:18px;font-weight:600;">Tutor Booking</span>
                </div>
                <p style="font-size:14px;color:rgba(255,255,255,0.6);margin:0 0 0.4rem;">This is an academic project developed for</p>
                <p style="font-size:14px;color:rgba(255,255,255,0.6);margin:0;"><strong style="color:#fff;">SE1020 – OOP Module at SLIIT</strong> by Group WD204</p>
            </div>




            <!-- Column 2: Contact Us -->
            <div>
                <p style="font-size:13px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#fff;margin:0 0 1rem;">Contact Us</p>
                <p style="font-size:14px;font-weight:600;color:#fff;margin:0 0 0.25rem;">Address</p>
                <p style="font-size:14px;color:rgba(255,255,255,0.6);margin:0 0 0.5rem;">SLIIT, New Kandy Road, Malabe,<br>Colombo, Sri Lanka</p>
                <a href="#" style="display:inline-flex;align-items:center;gap:5px;color:#38bdf8;font-size:14px;text-decoration:none;">ℹ️ Meet at the university premises</a>
            </div>

        </div>
        <hr style="border:none;border-top:0.5px solid rgba(255,255,255,0.12);margin:0 0 1.25rem;">
        <p style="text-align:center;font-size:13px;color:rgba(255,255,255,0.4);margin:0;">© 2026 WD204 | SLIIT | All Rights Reserved</p>
    </footer>

    <style>
        footer a:hover { color: #38bdf8 !important; }
    </style>




</body>
</html>
