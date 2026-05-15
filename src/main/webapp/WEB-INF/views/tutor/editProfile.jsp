<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | Tutor Booking</title>
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

        .nav-link {
            color: rgba(255,255,255,0.8) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .card-custom {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 2.5rem;
            animation: fadeInUp 0.8s ease-out both;
            max-width: 900px;
            margin: 0 auto;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1.2rem;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
            font-weight: 500;
            color: var(--dark-navy);
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: var(--accent-red);
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
            outline: none;
        }

        .section-header {
            border-bottom: 2px solid #f1f5f9;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-header i {
            color: var(--accent-red);
            font-size: 1.5rem;
        }

        .section-header h4 {
            margin-bottom: 0;
            font-weight: 800;
            color: var(--dark-navy);
        }

        .btn-custom {
            border-radius: 12px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-navy {
            background: var(--dark-navy);
            color: white;
            border: none;
        }

        .btn-navy:hover {
            background: var(--navy-blue);
            color: white;
            transform: translateY(-2px);
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/dashboard">Dashboard</a>
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
            <h1 class="fw-bold text-navy-blue display-6">Edit Your Profile</h1>
            <p class="text-muted">Keep your information up to date to attract more students</p>
        </div>

        <div class="card-custom">
            <form action="${pageContext.request.contextPath}/tutor/updateProfile" method="post">
                <div class="section-header">
                    <i class="bi bi-person-badge-fill"></i>
                    <h4>Basic Information</h4>
                </div>
                
                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="${tutor.fullName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email (Immutable)</label>
                        <input type="email" class="form-control" value="${tutor.email}" disabled style="opacity: 0.6; cursor: not-allowed;">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phoneNumber" class="form-control" value="${tutor.phoneNumber}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Subject Specialization</label>
                        <input type="text" name="subject" class="form-control" value="${tutor.subject}" required>
                    </div>
                </div>

                <div class="section-header">
                    <i class="bi bi-mortarboard-fill"></i>
                    <h4>Professional Details</h4>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <label class="form-label">Qualification</label>
                        <input type="text" name="qualification" class="form-control" value="${tutor.qualification}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Experience (Years)</label>
                        <input type="number" name="experience" class="form-control" value="${tutor.experience}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Hourly Rate (Rs)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 rounded-start-4">Rs.</span>
                            <input type="number" name="hourlyRate" class="form-control border-start-0 rounded-end-4" value="${tutor.hourlyRate}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Available Days</label>
                        <input type="text" name="availableDays" class="form-control" value="${tutor.availableDays}" required>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Available Time Window</label>
                        <input type="text" name="availableTime" class="form-control" value="${tutor.availableTime}" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">About Your Teaching Style</label>
                        <textarea name="aboutTutor" class="form-control" rows="5" required>${tutor.aboutTutor}</textarea>
                    </div>
                </div>

                <div class="section-header">
                    <i class="bi bi-shield-lock-fill"></i>
                    <h4>Security</h4>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" value="${tutor.password}" required>
                        <div class="form-text text-muted">Update your password if needed.</div>
                    </div>
                </div>

                <div class="d-flex gap-3 justify-content-end mt-5 border-top pt-4">
                    <a href="${pageContext.request.contextPath}/tutor/profile" class="btn btn-outline-secondary btn-custom">
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-navy btn-custom px-5">
                        <i class="bi bi-save2 me-2"></i>Save Changes
                    </button>
                </div>
            </form>
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
