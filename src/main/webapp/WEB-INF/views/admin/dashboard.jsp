<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            background: #f0f2f5;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            padding: 1rem 2rem;
        }
        .navbar-brand {
            color: white;
            font-weight: 700;
            font-size: 1.3rem;
        }
        .card{
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        .profile-header {
            background: linear-gradient(135deg,#1a1a2e,#0f3460);
            color: #fff;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 1.5rem;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 700;
            border: 3px solid rgba(255,255,255,0.4);
        }
        .info-label{
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #6c757d;
            font-weight: 600;
            letter-spacing: 0.05em;
        }
        .info-value{
            font-size: 1rem;
            font-weight: 500;
            color: #1a1a2e;
        }
        .btn-edit{
            background: #0f3460;
            color: #fff;
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
        }
        .btn-edit:hover{
            background: #1a1a2e;
            color: #fff;
        }
        .btn-delete{
            background: #fff;
            color: #dc3545;
            border: 2px solid #dc3545;
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
        }
        .btn-delete:hover{
            background: #dc3545;
            color: #fff;
        }
        .badge-role{
            color: #fff;
            background: rgba(255,255,255,0.2);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            border: 1px solid rgba(255,255,255,0.4);
        }
        .footer {
            background: #0d1b2a;
            color: rgba(255,255,255,0.7);
            padding: 3rem 0 2rem;
            margin-top: 4rem;
            border-top: 2px solid #00b4d8;
        }
        .footer-brand { color: #fff; font-weight: 700; font-size: 1.25rem; margin-bottom: 0.5rem; display: block; text-decoration: none; }
        .footer-link { color: rgba(255,255,255,0.6); text-decoration: none; transition: 0.3s; display: block; margin-bottom: 0.5rem; font-size: 0.85rem; }
        .footer-link:hover { color: #00b4d8; }
        .footer-heading { color: #fff; font-weight: 700; margin-bottom: 1.2rem; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 1.5px; opacity: 0.9; }
        .footer-info-text { font-size: 0.85rem; line-height: 1.6; }
        .footer-info-label { color: #fff; font-weight: 600; font-size: 0.8rem; margin-top: 1rem; margin-bottom: 0.2rem; display: block; opacity: 0.8; }
    </style>
</head>
<body>

<nav class="navbar">
    <span class="navbar-brand">
        <i class="bi bi-shield-check me-2 fs-2 text-warning"></i>
        <span class="fs-4 fw-bolder">Admin Panel</span>
    </span>
    <div class="ms-auto d-flex align-items-center">
        <!-- Admin Notification Dropdown -->
        <div class="dropdown me-4">
            <a href="#" class="text-white text-decoration-none position-relative" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-bell-fill fs-5"></i>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                    5
                    <span class="visually-hidden">unread notifications</span>
                </span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-3 p-0" style="width: 320px; border-radius: 15px; overflow: hidden;">
                <li class="bg-primary text-white px-3 py-3" style="background: linear-gradient(135deg, #1a1a2e, #0f3460) !important;">
                    <div class="d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold mb-0">Admin Alerts</h6>
                        <span class="badge bg-white text-dark rounded-pill" style="font-size: 0.7rem;">5 New</span>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item py-3 border-bottom px-3" href="#">
                        <div class="d-flex align-items-center">
                            <div class="bg-warning bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="bi bi-person-plus text-warning"></i>
                            </div>
                            <div style="white-space: normal;">
                                <div class="small fw-bold text-dark">New Tutor Registration</div>
                                <div class="small text-muted">Alex Rivera has applied to be a Math tutor.</div>
                                <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">10 mins ago</div>
                            </div>
                        </div>
                    </a>
                </li>
                <li>
                    <a class="dropdown-item py-3 border-bottom px-3" href="#">
                        <div class="d-flex align-items-center">
                            <div class="bg-danger bg-opacity-10 p-2 rounded-circle me-3">
                                <i class="bi bi-exclamation-triangle text-danger"></i>
                            </div>
                            <div style="white-space: normal;">
                                <div class="small fw-bold text-dark">System Alert</div>
                                <div class="small text-muted">Database backup completed with 2 warnings.</div>
                                <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">1 hour ago</div>
                            </div>
                        </div>
                    </a>
                </li>
                <li class="text-center bg-light">
                    <a href="#" class="dropdown-item small py-2 text-primary fw-bold">View All Admin Logs</a>
                </li>
            </ul>
        </div>
        <span class="text-white me-3">
            <i class="bi bi-person-circle me-1"></i>${sessionScope.adminName}
        </span>
        <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-light btn-sm">
            <i class="bi bi-box-arrow-right me-1"></i>Logout
        </a>
    </div>
</nav>
<div class="container py-4">
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible">
            <i class="bi bi-check-circle me-2"></i>${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <div class="profile-header">
        <div class="d-flex align-items-center gap-3">
            <div class="profile-avatar">${admin.name.charAt(0)}</div>
            <div>
                <h4 class="fw-bold mb-1">${admin.name}</h4>
                <span class="badge-role">
                    <i class="bi bi-shield-fill me-1"></i>${admin.role}
                </span>
            </div>
        </div>
    </div>
    <div class="card mb-4">
        <div class="card-body p-4">
            <h5 class="fw-bold mb-4" style="color: #0f3460">
                <i class="bi bi-person-fill me-2"></i>My Profile
            </h5>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="p-3 rounded" style="background: #f8f9fa">
                        <div class="info-label">Full Name</div>
                        <div class="info-value">
                            <i class="bi bi-person me-2 text-muted"></i>${admin.name}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 rounded" style="background: #f8f9fa">
                        <div class="info-label">Email Address</div>
                        <div class="info-value">
                            <i class="bi bi-envelope me-2 text-muted"></i>${admin.email}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 rounded" style="background: #f8f9fa">
                        <div class="info-label">Phone Number</div>
                        <div class="info-value">
                            <i class="bi bi-telephone me-2 text-muted"></i>${admin.phone}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 rounded" style="background: #f8f9fa">
                        <div class="info-label">Role</div>
                        <div class="info-value">
                            <i class="bi bi-person-badge-fill me-2 text-muted"></i>${admin.role}
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-3 mt-4">
                <a href="${pageContext.request.contextPath}/admin/edit" class="btn-edit">
                    <i class="bi bi-pencil-square me-2"></i>Edit Profile
                </a>
                <form method="post" action="${pageContext.request.contextPath}/admin/delete" onsubmit="return confirm('Are you sure you want to delete you account? This cannot be undone!')">
                    <button type="submit" class="btn btn-delete">
                        <i class="bi bi-trash me-2"></i>Delete My Account
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <a href="#" class="footer-brand">
                        <i class="bi bi-mortarboard-fill me-2 text-info"></i>Tutor Booking
                    </a>
                    <p class="footer-info-text mb-0 opacity-50 small">
                        This is a academic project developed for<br>
                        <strong>SE1020 - OOP Module at SLIIT</strong> by Group WD204
                    </p>
                </div>
                <div class="col-6 col-lg-2 mb-5 mb-lg-0">
                    <h6 class="footer-heading">Admin Links</h6>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="footer-link">Admin Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/edit" class="footer-link">Edit Admin Profile</a>
                </div>
                <div class="col-lg-6">
                    <h6 class="footer-heading">Contact Us</h6>
                    <div class="footer-info-text">
                        <span class="footer-info-label">Address</span>
                        SLIIT, New Kandy Road, Malabe,<br>Colombo, Sri Lanka
                        <p class="mt-2 text-info opacity-75 small italic mb-4">
                            <i class="bi bi-info-circle me-1"></i> Meet at the university premises
                        </p>
                        <hr class="opacity-10">
                        <p class="mb-0 opacity-50 small">&copy; 2026 WD204 | SLIIT | All Rights Reserved</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>