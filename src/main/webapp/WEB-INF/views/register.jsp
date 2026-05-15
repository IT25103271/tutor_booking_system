<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Registration | Tutor Booking</title>
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
            padding: 4rem 1rem;
            display: flex;
            justify-content: center;
        }

        .card-custom {
            background: white;
            border-radius: 24px;
            border: none;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            padding: 3.5rem;
            width: 100%;
            max-width: 900px;
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
            font-size: 0.75rem;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-control {
            border-radius: 12px;
            padding: 0.75rem 1.2rem;
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

        .section-tag {
            color: var(--accent-red);
            font-size: 0.7rem;
            font-weight: 800;
            letter-spacing: 2px;
            margin-bottom: 1.5rem;
            display: block;
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 0.5rem;
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
                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm rounded-pill px-4">
                    Already a Tutor? Login
                </a>
            </div>
        </div>
    </nav>

    <div class="auth-container">
        <div class="card-custom">
            <div class="text-center mb-5">
                <div class="logo-icon">
                    <i class="bi bi-person-plus-fill"></i>
                </div>
                <h2 class="fw-bold text-navy-blue mb-1">Join as a Tutor</h2>
                <p class="text-muted">Create your professional profile and start teaching</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-4 border-0 py-2 small mb-4">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="row g-4">
                    <div class="col-12"><span class="section-tag">PERSONAL INFORMATION</span></div>
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" required placeholder="John Doe">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" required placeholder="john@example.com">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phoneNumber" class="form-control" required placeholder="1234567890">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Subject Specialization</label>
                        <input type="text" name="subject" class="form-control" required placeholder="Mathematics, Physics">
                    </div>

                    <div class="col-12 mt-5"><span class="section-tag">PROFESSIONAL DETAILS</span></div>
                    <div class="col-md-6">
                        <label class="form-label">Qualification</label>
                        <input type="text" name="qualification" class="form-control" required placeholder="M.Sc. Mathematics">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Experience (Years)</label>
                        <input type="number" name="experience" class="form-control" required placeholder="5">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Hourly Rate (Rs)</label>
                        <input type="number" name="hourlyRate" class="form-control" required placeholder="500">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Available Days</label>
                        <input type="text" name="availableDays" class="form-control" required placeholder="Mon, Wed, Fri">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Available Time</label>
                        <input type="text" name="availableTime" class="form-control" required placeholder="10:00 AM - 04:00 PM">
                    </div>
                    <div class="col-12">
                        <label class="form-label">About You</label>
                        <textarea name="aboutTutor" class="form-control" rows="3" required placeholder="Describe your background and teaching style..."></textarea>
                    </div>

                    <div class="col-12 mt-5"><span class="section-tag">SECURITY</span></div>
                    <div class="col-md-6">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="••••••••">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" required placeholder="••••••••">
                    </div>
                </div>

                <button type="submit" class="btn-navy mt-5">
                    Create Account <i class="bi bi-chevron-right ms-2"></i>
                </button>
            </form>
            
            <div class="text-center mt-4">
                <p class="text-muted small">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="text-accent-red fw-bold text-decoration-none" style="color: var(--accent-red);">Login here</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Footer -->
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
