<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings | Tutor Booking</title>
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
            overflow-x: hidden;
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

        .card-custom {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 2.5rem;
            animation: fadeInUp 0.8s ease-out both;
            max-width: 600px;
            margin: 0 auto;
        }

        .danger-zone {
            border: 2px solid rgba(233, 69, 96, 0.2);
            background-color: rgba(233, 69, 96, 0.02);
            border-radius: 20px;
            padding: 2rem;
        }

        .btn-danger-custom {
            background-color: var(--accent-red);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-danger-custom:hover {
            background-color: #d43d56;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(233, 69, 96, 0.3);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .footer {
            background: var(--dark-navy);
            color: rgba(255,255,255,0.6);
            padding: 4rem 0 2rem;
            margin-top: 5rem;
            border-top: 3px solid var(--accent-red);
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/tutor/dashboard">
                <i class="bi bi-mortarboard-fill me-2 fs-3 text-white"></i>
                <span class="fs-4">Tutor Booking <span class="text-white-50 fs-6 fw-normal">| Tutor Portal</span></span>
            </a>
            <div class="ms-auto">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item me-3">
                        <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/tutor/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold text-navy-blue display-6">Account Settings</h1>
            <p class="text-muted">Manage your account preferences and security</p>
        </div>
        
        <div class="card-custom">
            <div class="danger-zone">
                <h4 class="fw-bold text-danger mb-3">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> Danger Zone
                </h4>
                <p class="text-muted mb-4 small">
                    Deleting your account will permanently remove all your profile information, teaching history, and scheduled availability. This action is irreversible.
                </p>
                
                <form action="${pageContext.request.contextPath}/tutor/deleteAccount" method="post" onsubmit="return confirm('Are you absolutely sure you want to delete your account? This will remove all your data.');">
                    <button type="submit" class="btn-danger-custom">
                        <i class="bi bi-person-x-fill me-2"></i>Permanently Deactivate My Account
                    </button>
                </form>
            </div>

            <div class="mt-5 text-center">
                <a href="${pageContext.request.contextPath}/tutor/dashboard" class="text-decoration-none text-muted fw-bold">
                    <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container text-center">
            <h5 class="text-white fw-bold mb-2">Tutor Booking</h5>
            <p class="mb-0 small text-white-50">&copy; 2026 Tutor Booking | Developed for Education</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
