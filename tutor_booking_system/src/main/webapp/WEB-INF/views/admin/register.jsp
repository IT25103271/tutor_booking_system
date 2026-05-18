<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"/>
    <style>
        body{
            background: #f8f9fa;
        }
        .navbar{
            background: #0f3460
        }
        .navbar-brand{
            color: white;
            font-weight: 700;
        }
        .card{
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            max-width: 550px;
            margin: 2rem auto;
        }
        .card-header{
            background: #0f3460;
            color: white;
            font-weight: 600;
            border-radius: 12px 12px 0 0 !important;
        }
        .btn-save{
            background: #1a1a2e;
            color: white;
        }
        .btn-save:hover{
            background: #1a1a2e;
            color: white;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg px-4">
    <span class="navbar-brand">Home Tutor Admin</span>
    <div class="ms-auto">
        <a href="/admin/dashboard" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
        <a href="/admin/logout" class="btn btn-outline-light btn-sm me">Logout</a>
    </div>
</nav>
<div class="container">
    <div class="card-header">
        Register New Admin
    </div>
    <div class="card-body p-4">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <form method="post" action="/admin/register">
            <div class="mb-3">
                <label class="form-label fw-semibold">Full Name *</label>
                <input type="text" class="form-control" name="name" placeholder="Enter full name" required/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Email *</label>
                <input type="text" class="form-control" name="email" placeholder="Enter email" required/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Password *</label>
                <input type="password" class="form-control" name="password" placeholder="Enter password" required/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Phone *</label>
                <input type="text" class="form-control" name="phone" placeholder="Enter phone number" required/>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Role *</label>
                <select name="role" class="form-select" required>
                    <option value="">Select role...</option>
                    <option value="SUPER_ADMIN">Super Admin</option>
                    <option value="ADMIN">Admin</option>
                    <option value="MODERATOR">Moderator</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-save">Save</button>
                <a href="/admin/dashboard" class="btn btn-outline-secondary px-4">Cancel</a>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>