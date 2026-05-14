<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Admin</title>
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
            color: #fff;
            font-weight: 700;
            font-size: 1.3rem;
        }
        .card{
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        .card-header-custom{
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            color: #fff;
            padding: 1.2rem 1.5rem;
            border-radius: 15px 15px 0 0;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .form-control:focus{
            border-color: #0f3460;
            box-shadow: 0 0 0 0.2rem rgba(15,52,96,0.2);
        }
        .form-label{
            font-weight: 600;
            color: #1a1a2e;
            font-size: 0.85rem;
            text-transform:uppercase;
            letter-spacing:0.05em;
        }
        .btn-save{
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 0.7rem 2rem;
            font-weight: 600;
        }
        .btn-save:hover{
            opacity: 0.9;
            color: white;
        }
        .btn-cancel{
            border-radius: 10px;
            padding: 0.7rem 2rem;
            font-weight: 600;
        }
        .input-group-text{
            background: #f8f9fa;
            border-right: none;
            color: #6c757d;
        }
        .form-control{
            border-left: none;
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
        .social-icon {
            width: 35px; height: 35px; background: rgba(255,255,255,0.1);
            border-radius: 50%; display: inline-flex; align-items: center;
            justify-content: center; color: #fff; margin-right: 10px; transition: 0.3s;
        }
        .social-icon:hover { background: #00b4d8; transform: translateY(-3px); }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <span class="navbar-brand"><i class="bi bi-shield-check me-2"></i>Admin Panel</span>
    <div class="ms-auto d-flex align-items-center gap-2">

        <!-- Account Dropdown -->
        <div class="dropdown">
            <a href="#" class="text-white text-decoration-none dropdown-toggle" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i>${sessionScope.adminName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="accountDropdown">
                <li><a class="dropdown-item" href="/admin/dashboard"><i class="bi bi-speedometer2 me-1"></i>Dashboard</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="/admin/delete" onclick="return confirm('Are you sure you want to delete your account? This cannot be undone.')"><i class="bi bi-trash me-2"></i>Delete Account</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="/admin/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
            </ul>
        </div>

    </div>
</nav>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible">
                    <i class="bi bi-check-circle me-2"></i>${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <div class="card">
                <div class="card-header-custom">
                    <i class="bi bi-pencil-square me-2"></i>Edit My Profile
                </div>
                <div class="card-body p-4">
                    <form method="post" action="/admin/edit">
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>
                                <input type="text" class="form-control" name="name" value="${admin.name}" required/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>
                                <input type="text" class="form-control" name="email" value="${admin.email}" required/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Phone Number</label>
                            <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-telephone"></i>
                            </span>
                                <input type="text" class="form-control" name="phone" value="${admin.phone}" required/>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">New Password</label>
                            <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-lock"></i>
                            </span>
                                <input type="password" class="form-control" name="password" id="pwd" placeholder="Enter new password" value="${admin.password}" required/>
                                <button type="button" class="btn btn-light border" onclick="togglePwd()">
                                    <i class="bi bi-eye" id="eyeIcon"></i>
                                </button>
                            </div>
                        </div>
                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-save me-2"></i>Save Changes
                            </button>
                            <a href="/admin/dashboard" class="btn btn-outline-secondary btn-cancel">
                                <i class="bi bi-x-circle me-2"></i>Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function togglePwd(){
        const p = document.getElementById('pwd');
        const i = document.getElementById('eyeIcon');
        p.type = p.type === 'password' ? 'text' : 'password';
        i.className = p.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
    }

</script>
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
                <h6 class="footer-heading">Quick Links</h6>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="footer-link">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/edit" class="footer-link">Edit</a>
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