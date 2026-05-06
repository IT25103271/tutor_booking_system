<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #1a1a2e, #16213e); padding: 1rem 2rem; border-bottom: 2px solid #e94560; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .profile-header { 
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); 
            color: #fff; 
            border-radius: 15px; 
            padding: 3rem 2rem; 
            margin-bottom: 2rem; 
            position: relative;
            overflow: hidden;
            border-bottom: 4px solid #e94560;
        }
        .profile-avatar { 
            width: 100px; 
            height: 100px; 
            border-radius: 50%; 
            background: rgba(255,255,255,0.1); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 2.5rem; 
            font-weight: 700; 
            border: 4px solid #e94560; 
        }
        .stat-card {
            background: #fff;
            border-radius: 15px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            height: 100%;
            border-left: 5px solid transparent;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .stat-value { font-size: 1.8rem; font-weight: 800; color: #1a1a2e; }
        .stat-label { font-size: 0.85rem; color: #6c757d; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
        
        .students-card { border-left-color: #4361ee; }
        .tutors-card { border-left-color: #4cc9f0; }
        .bookings-card { border-left-color: #f72585; }
        .pending-card { border-left-color: #ff9f1c; }
        
        .info-box {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #eee;
        }
        .info-label { font-size: 0.75rem; text-transform: uppercase; color: #6c757d; font-weight: 700; margin-bottom: 5px; }
        .info-value { font-size: 1rem; font-weight: 600; color: #1a1a2e; }
        
        .btn-custom { border-radius: 10px; padding: 0.7rem 1.5rem; font-weight: 600; transition: 0.3s; }
        .btn-dark-navy { background: #1a1a2e; color: #fff; border: none; }
        .btn-dark-navy:hover { background: #16213e; color: #fff; transform: translateY(-2px); }
        
        .footer {
            background: #1a1a2e;
            color: rgba(255,255,255,0.7);
            padding: 3rem 0 2rem;
            margin-top: 4rem;
            border-top: 2px solid #e94560;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-lock-fill me-2 fs-2 text-danger"></i>
            <span class="fs-4 fw-bolder">Admin Dashboard</span>
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
                                        <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">10 mins ago</div>
                                    </div>
                                </div>
                                <button onclick="markAsRead(event, 'admin-notif-1')" class="btn btn-sm text-primary p-0 ms-2" title="Mark as read">
                                    <i class="bi bi-check2-all fs-5"></i>
                                </button>
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
                                        <div class="small text-muted">Database backup completed with 2 warnings.</div>
                                        <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">1 hour ago</div>
                                    </div>
                                </div>
                                <button onclick="markAsRead(event, 'admin-notif-2')" class="btn btn-sm text-primary p-0 ms-2" title="Mark as read">
                                    <i class="bi bi-check2-all fs-5"></i>
                                </button>
                            </div>
                        </div>
                    </li>
                    <li class="text-center bg-light">
                        <a href="#" class="dropdown-item small py-2 text-primary fw-bold">View All Logs</a>
                    </li>
                </ul>
            </div>
            <span class="text-white me-4 d-flex align-items-center">
                <i class="bi bi-person-circle me-2 fs-5"></i>
                <span class="fw-semibold">${sessionScope.adminName}</span>
            </span>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="profile-header shadow-lg">
        <div class="d-flex align-items-center gap-4">
            <div class="profile-avatar">${admin.name.charAt(0)}</div>
            <div>
                <p class="small text-white-50 mb-1">Administrator Control Panel</p>
                <h1 class="fw-bold mb-2" style="font-size: 2.5rem;">${admin.name}</h1>
                <div class="d-flex align-items-center gap-3">
                    <span class="badge bg-danger rounded-pill px-3 py-2" style="font-size: 0.7rem;">
                        <i class="bi bi-shield-fill-check me-1"></i> SUPER ADMIN
                    </span>
                    <span class="text-white opacity-75 small">
                        <i class="bi bi-envelope-fill me-1"></i> ${admin.email}
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stat-card students-card shadow-sm">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                    <i class="bi bi-people-fill"></i>
                </div>
                <div class="stat-value">${studentCount}</div>
                <div class="stat-label">Total Students</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card tutors-card shadow-sm">
                <div class="stat-icon bg-info bg-opacity-10 text-info">
                    <i class="bi bi-person-workspace"></i>
                </div>
                <div class="stat-value">${tutorCount}</div>
                <div class="stat-label">Total Tutors</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card bookings-card shadow-sm">
                <div class="stat-icon bg-danger bg-opacity-10 text-danger">
                    <i class="bi bi-calendar-check-fill"></i>
                </div>
                <div class="stat-value">${totalBookings}</div>
                <div class="stat-label">Total Bookings</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card pending-card shadow-sm">
                <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                    <i class="bi bi-hourglass-split"></i>
                </div>
                <div class="stat-value">${pendingBookings}</div>
                <div class="stat-label">Pending Approval</div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0" style="color: #1a1a2e">
                        <i class="bi bi-gear-fill me-2 text-primary"></i> System Management
                    </h4>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="card p-3 border h-100 text-center">
                            <i class="bi bi-people display-6 text-primary mb-3"></i>
                            <h6>Manage Students</h6>
                            <p class="small text-muted">View and manage registered student accounts.</p>
                            <a href="#" class="btn btn-outline-primary btn-sm mt-auto">View All</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card p-3 border h-100 text-center">
                            <i class="bi bi-person-badge display-6 text-info mb-3"></i>
                            <h6>Manage Tutors</h6>
                            <p class="small text-muted">Review tutor applications and manage profiles.</p>
                            <a href="#" class="btn btn-outline-info btn-sm mt-auto">View All</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card p-3 border h-100 text-center">
                            <i class="bi bi-calendar-event display-6 text-danger mb-3"></i>
                            <h6>Booking Reports</h6>
                            <p class="small text-muted">Generate and view all session reports.</p>
                            <a href="#" class="btn btn-outline-danger btn-sm mt-auto">View Reports</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card p-3 border h-100 text-center">
                            <i class="bi bi-graph-up display-6 text-success mb-3"></i>
                            <h6>System Health</h6>
                            <p class="small text-muted">Monitor database and server performance.</p>
                            <a href="#" class="btn btn-outline-success btn-sm mt-auto">View Health</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card p-4 h-100">
                <h4 class="fw-bold mb-4" style="color: #1a1a2e">
                    <i class="bi bi-person-circle me-2 text-danger"></i> Profile Info
                </h4>
                <div class="info-box">
                    <div class="info-label">Full Name</div>
                    <div class="info-value">${admin.name}</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Email Address</div>
                    <div class="info-value">${admin.email}</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Phone Number</div>
                    <div class="info-value">${admin.phone}</div>
                </div>
                <div class="info-box">
                    <div class="info-label">Admin Role</div>
                    <div class="info-value">${admin.role}</div>
                </div>
                <div class="d-flex gap-2 mt-4">
                    <a href="${pageContext.request.contextPath}/admin/edit" class="btn btn-dark-navy w-100 btn-custom">
                        <i class="bi bi-pencil-square me-2"></i>Edit
                    </a>
                    <form method="post" action="${pageContext.request.contextPath}/admin/delete" class="w-100" onsubmit="return confirm('Delete admin account?')">
                        <button type="submit" class="btn btn-outline-danger w-100 btn-custom">
                            <i class="bi bi-trash me-2"></i>Delete
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-2 fw-bold text-white">Tutor Booking System | Admin Portal</p>
        <p class="mb-0 opacity-50 small">&copy; 2026 WD204 | SLIIT | System Version 2.4.0</p>
    </div>
</footer>

<script>
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
</body>
</html>