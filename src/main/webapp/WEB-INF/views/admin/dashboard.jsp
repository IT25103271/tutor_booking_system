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
    </style>
</head>
<body>

<nav class="navbar">
    <span class="navbar-brand">
        <i class="bi bi-shield-check me-2"></i>Admin Panel
    </span>
    <div class="ms-auto">
        <span class="text-white me-3">
            <i class="bi bi-person-circle me-1"></i>${sessionScope.adminName}
        </span>
        <a href="/admin/logout" class="btn btn-outline-light btn-sm">
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
                <a href="/admin/edit" class="btn-edit">
                    <i class="bi bi-pencil-square me-2"></i>Edit Profile
                </a>
                <form method="post" action="/admin/delete" onsubmit="return confirm('Are you sure you want to delete you account? This cannot be undone!')">
                    <button type="submit" class="btn btn-delete">
                        <i class="bi bi-trash me-2"></i>Delete My Account
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>