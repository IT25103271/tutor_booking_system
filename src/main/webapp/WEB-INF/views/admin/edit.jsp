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
    </style>
</head>
<body>
<nav class="navbar">
    <span class="navbar-brand">
        <i class="bi bi-shield-check me-2 fs-2 text-warning"></i>
        <span class="fs-4 fw-bolder">Admin Panel</span>
    </span>
    <div class="ms-auto d-flex align-items-center">
        <a href="#" class="text-white me-3 text-decoration-none position-relative">
            <i class="bi bi-bell-fill fs-5"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                5
                <span class="visually-hidden">unread notifications</span>
            </span>
        </a>
        <span class="text-white me-3">
            <i class="bi bi-person-circle me-1"></i>${sessionScope.adminName}
        </span>
        <a href="/admin/dashboard" class="btn btn-outline-light btn-sm me-2">
            <i class="bi bi-speedometer2 me-1"></i>Dashboard
        </a>
        <a href="/admin/logout" class="btn btn-outline-light btn-sm">
            <i class="bi bi-box-arrow-right me-1"></i>Logout
        </a>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>