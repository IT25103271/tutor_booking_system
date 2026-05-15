<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Tutor Booking</title>
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

        .nav-link:hover {
            color: var(--accent-red) !important;
        }

        /* Profile Header */
        .profile-header {
            background: linear-gradient(135deg, var(--dark-navy) 0%, var(--navy-blue) 100%);
            color: white;
            border-radius: 20px;
            padding: 3.5rem 2.5rem;
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
            border-bottom: 5px solid var(--accent-red);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            animation: fadeInDown 0.8s ease-out;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 25px;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            font-weight: 800;
            border: 3px solid var(--accent-red);
            backdrop-filter: blur(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .card-custom {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 2.5rem;
            animation: fadeInUp 0.8s ease-out both;
        }

        .info-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            margin-bottom: 4px;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-navy);
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-weight: 800;
            color: var(--dark-navy);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: var(--accent-red);
        }

        .btn-custom {
            border-radius: 12px;
            padding: 0.8rem 1.5rem;
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

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
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
        <c:if test="${param.updated}">
            <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> Profile updated successfully!
            </div>
        </c:if>

        <div class="profile-header shadow-lg">
            <div class="row align-items-center g-4">
                <div class="col-auto">
                    <div class="profile-avatar">${tutor.fullName.substring(0, 1)}</div>
                </div>
                <div class="col">
                    <p class="text-white-50 fw-semibold mb-1" style="letter-spacing: 1px;">TUTOR PROFILE</p>
                    <h1 class="fw-bold mb-2 display-5">${tutor.fullName}</h1>
                    <div class="d-flex flex-wrap align-items-center gap-3">
                        <span class="badge bg-danger rounded-pill px-3 py-2" style="font-size: 0.8rem;">
                            <i class="bi bi-patch-check-fill me-1"></i> ${tutor.subject} Specialist
                        </span>
                        <span class="text-white-50 small">
                            <i class="bi bi-mortarboard-fill me-1"></i> ${tutor.qualification}
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-custom">
            <div class="row g-5">
                <div class="col-lg-6">
                    <h4 class="section-title"><i class="bi bi-person-lines-fill"></i> Contact Information</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Email Address</div>
                            <div class="info-value">${tutor.email}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value">${tutor.phoneNumber}</div>
                        </div>
                        <div class="col-12">
                            <div class="info-label">Tutor ID</div>
                            <div class="info-value">#${tutor.tutorId}</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <h4 class="section-title"><i class="bi bi-book-half"></i> Academic Details</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-label">Experience</div>
                            <div class="info-value">${tutor.experience} Years</div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-label">Hourly Rate</div>
                            <div class="info-value">Rs ${tutor.hourlyRate}/hr</div>
                        </div>
                        <div class="col-12">
                            <div class="info-label">Availability</div>
                            <div class="info-value">${tutor.availableDays}</div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <h4 class="section-title"><i class="bi bi-info-circle-fill"></i> About Me</h4>
                    <div class="bg-light p-4 rounded-4 text-muted" style="line-height: 1.8;">
                        ${tutor.aboutTutor}
                    </div>
                </div>
            </div>

            <div class="mt-5 d-flex gap-3">
                <a href="${pageContext.request.contextPath}/tutor/editProfile" class="btn btn-navy btn-custom px-5">
                    <i class="bi bi-pencil-square me-2"></i>Edit Profile
                </a>
                <a href="${pageContext.request.contextPath}/tutor/dashboard" class="btn btn-outline-secondary btn-custom px-5">
                    <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
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
