<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #1a1a2e, #16213e); padding: 1rem 2rem; border-bottom: 2px solid #e94560; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .card-header-custom {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: #fff;
            padding: 1.5rem;
            border-radius: 15px 15px 0 0;
            font-weight: 700;
            border-bottom: 3px solid #e94560;
        }
        .form-label { font-weight: 700; color: #1a1a2e; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .input-group-text { background: #f8f9fa; border-right: none; color: #e94560; }
        .form-control { border-left: none; padding: 0.75rem; }
        .form-control:focus { border-color: #ced4da; box-shadow: none; border-left: none; }
        .btn-save { background: #1a1a2e; color: #fff; border: none; border-radius: 10px; padding: 0.8rem 2rem; font-weight: 600; transition: 0.3s; }
        .btn-save:hover { background: #e94560; transform: translateY(-2px); color: #fff; }
        .btn-cancel { border-radius: 10px; padding: 0.8rem 2rem; font-weight: 600; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-lock-fill me-2 fs-2 text-danger"></i>
            <span class="fs-4 fw-bolder">Admin Panel</span>
        </a>
        <div class="ms-auto d-flex align-items-center">
            <!-- Admin Notification Dropdown -->
            <div class="dropdown me-4">
                <a href="#" class="text-white text-decoration-none position-relative" id="notifDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-bell-fill fs-5"></i>
                    <span id="notif-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                        5
                    </span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-3 p-0" style="width: 320px; border-radius: 15px; overflow: hidden;" aria-labelledby="notifDropdown" onclick="event.stopPropagation()">
                    <li class="bg-primary text-white px-3 py-3" style="background: linear-gradient(135deg, #1a1a2e, #0f3460) !important;">
                        <div class="d-flex justify-content-between align-items-center">
                            <h6 class="fw-bold mb-0">System Alerts</h6>
                            <a href="javascript:void(0)" onclick="markAllRead()" class="text-white opacity-75 small text-decoration-none">Mark all as read</a>
                        </div>
                    </li>
                    <!-- Notification items remain the same -->
                    <li>
                        <div class="dropdown-item py-3 border-bottom px-3 notification-item" id="admin-notif-1">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="bg-warning bg-opacity-10 p-2 rounded-circle me-3">
                                        <i class="bi bi-person-plus text-warning"></i>
                                    </div>
                                    <div style="white-space: normal;">
                                        <div class="small fw-bold text-dark">New Tutor Registration</div>
                                        <div class="small text-muted">Alex Rivera has applied to be a Math tutor.</div>
                                    </div>
                                </div>
                                <button onclick="markAsRead(event, 'admin-notif-1')" class="btn btn-sm text-primary p-0 ms-2"><i class="bi bi-check2-all fs-5"></i></button>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="dropdown-item py-3 border-bottom px-3 notification-item" id="admin-notif-2">
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center">
                                    <div class="bg-danger bg-opacity-10 p-2 rounded-circle me-3">
                                        <i class="bi bi-exclamation-triangle text-danger"></i>
                                    </div>
                                    <div style="white-space: normal;">
                                        <div class="small fw-bold text-dark">System Alert</div>
                                        <div class="small text-muted">Database backup completed.</div>
                                    </div>
                                </div>
                                <button onclick="markAsRead(event, 'admin-notif-2')" class="btn btn-sm text-primary p-0 ms-2"><i class="bi bi-check2-all fs-5"></i></button>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <span class="text-white me-4 fw-semibold">${sessionScope.adminName}</span>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light btn-sm rounded-pill px-3 me-2">
                <i class="bi bi-speedometer2 me-1"></i>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <c:if test="${not empty error}"><div class="alert alert-danger shadow-sm border-0 mb-4">${error}</div></c:if>
            <c:if test="${not empty success}"><div class="alert alert-success shadow-sm border-0 mb-4">${success}</div></c:if>
            <div class="card shadow-lg">
                <div class="card-header-custom">
                    <i class="bi bi-pencil-square me-2"></i>Edit Admin Profile
                </div>
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/edit">
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" name="name" value="${admin.name}" required/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="text" class="form-control" name="email" value="${admin.email}" required/>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                <input type="text" class="form-control" name="phone" value="${admin.phone}" required/>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Update Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" name="password" id="pwd" value="${admin.password}" required/>
                                <button type="button" class="btn btn-light border" onclick="togglePwd()"><i class="bi bi-eye" id="eyeIcon"></i></button>
                            </div>
                        </div>
                        <div class="d-flex gap-2 mt-4">
                            <button type="submit" class="btn btn-save flex-grow-1"><i class="bi bi-save me-2"></i>Save Changes</button>
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary btn-cancel flex-grow-1 text-center text-decoration-none">Cancel</a>
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
    document.addEventListener('DOMContentLoaded', function() {
        const readNotifications = JSON.parse(localStorage.getItem('adminReadNotifications') || '[]');
        readNotifications.forEach(id => {
            const item = document.getElementById(id);
            if (item) item.classList.add('d-none');
        });
        updateBadgeCount();
    });
    function markAsRead(event, id) {
        if (event) event.stopPropagation();
        const item = document.getElementById(id);
        if (!item || item.classList.contains('d-none')) return;
        item.style.opacity = '0.5';
        setTimeout(() => {
            item.classList.add('d-none');
            const readNotifications = JSON.parse(localStorage.getItem('adminReadNotifications') || '[]');
            if (!readNotifications.includes(id)) {
                readNotifications.push(id);
                localStorage.setItem('adminReadNotifications', JSON.stringify(readNotifications));
            }
            updateBadgeCount();
        }, 300);
    }
    function markAllRead() {
        const items = document.querySelectorAll('.notification-item:not(.d-none)');
        const readNotifications = JSON.parse(localStorage.getItem('adminReadNotifications') || '[]');
        items.forEach(item => {
            const id = item.id;
            if (!readNotifications.includes(id)) readNotifications.push(id);
            item.classList.add('d-none');
        });
        localStorage.setItem('adminReadNotifications', JSON.stringify(readNotifications));
        updateBadgeCount();
    }
    function updateBadgeCount() {
        const badge = document.getElementById('notif-badge');
        if (!badge) return;
        const visibleItems = document.querySelectorAll('.notification-item:not(.d-none)');
        const count = visibleItems.length;
        if (count <= 0) badge.classList.add('d-none');
        else {
            badge.innerText = count;
            badge.classList.remove('d-none');
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>