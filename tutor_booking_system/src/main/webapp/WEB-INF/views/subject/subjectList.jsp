<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Subjects | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #1a1a2e, #16213e); padding: 1rem 2rem; border-bottom: 2px solid #e94560; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .page-header { 
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); 
            color: #fff; 
            border-radius: 15px; 
            padding: 2rem; 
            margin-bottom: 2rem; 
            border-bottom: 4px solid #e94560;
        }
        .btn-custom { border-radius: 10px; padding: 0.6rem 1.2rem; font-weight: 600; transition: 0.3s; }
        .btn-dark-navy { background: #1a1a2e; color: #fff; border: none; }
        .btn-dark-navy:hover { background: #16213e; color: #fff; transform: translateY(-2px); }
        .search-box { border-radius: 10px; border: 1px solid #dee2e6; padding: 0.6rem 1rem; }
        .table { border-collapse: separate; border-spacing: 0 10px; }
        .table thead th { border: none; color: #6c757d; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px; padding: 1rem; }
        .table tbody tr { background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.02); border-radius: 10px; transition: 0.3s; }
        .table tbody tr:hover { transform: scale(1.01); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .table tbody td { padding: 1.2rem 1rem; vertical-align: middle; border: none; }
        .table tbody td:first-child { border-top-left-radius: 10px; border-bottom-left-radius: 10px; }
        .table tbody td:last-child { border-top-right-radius: 10px; border-bottom-right-radius: 10px; }
        .status-badge { border-radius: 20px; padding: 0.4rem 1rem; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; }
        .badge-active { background: #d1fae5; color: #065f46; }
        .badge-inactive { background: #fee2e2; color: #991b1b; }
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
    <div class="page-header d-flex justify-content-between align-items-center shadow-lg">
        <div>
            <p class="small text-white-50 mb-1">System Management</p>
            <h1 class="fw-bold mb-0">Manage Subjects</h1>
        </div>
        <a href="${pageContext.request.contextPath}/subject/add" class="btn btn-light btn-custom">
            <i class="bi bi-plus-circle-fill me-2"></i>Add New Subject
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm rounded-4 mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card p-4 shadow-sm mb-4">
        <form action="${pageContext.request.contextPath}/subject/search" method="get" class="row g-3">
            <div class="col-md-10">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 search-box">
                        <i class="bi bi-search text-muted"></i>
                    </span>
                    <input type="text" name="q" class="form-control border-start-0 search-box" placeholder="Search by name, category or grade..." value="${keyword}">
                </div>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-dark-navy w-100 btn-custom">Search</button>
            </div>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Subject Name</th>
                    <th>Category</th>
                    <th>Grade Level</th>
                    <th>Status</th>
                    <th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="subject" items="${subjects}">
                    <tr>
                        <td><span class="fw-bold text-muted">#${subject.id}</span></td>
                        <td>
                            <div class="fw-bold text-dark">${subject.subjectName}</div>
                            <div class="small text-muted text-truncate" style="max-width: 200px;">${subject.description}</div>
                        </td>
                        <td><span class="badge bg-light text-dark border">${subject.category}</span></td>
                        <td><span class="badge bg-info bg-opacity-10 text-info">${subject.gradeLevel}</span></td>
                        <td>
                            <span class="status-badge ${subject.status == 'Active' ? 'badge-active' : 'badge-inactive'}">
                                ${subject.status}
                            </span>
                        </td>
                        <td class="text-end">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/subject/edit?id=${subject.id}" class="btn btn-sm btn-outline-primary rounded-start-pill px-3">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/subject/delete?id=${subject.id}" 
                                   class="btn btn-sm btn-outline-danger rounded-end-pill px-3"
                                   onclick="return confirm('Are you sure you want to delete this subject?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty subjects}">
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <i class="bi bi-inbox display-4 text-muted mb-3 d-block"></i>
                            <p class="text-muted">No subjects found matching your search.</p>
                            <a href="${pageContext.request.contextPath}/subject/list" class="btn btn-sm btn-outline-secondary mt-2">Clear Search</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
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
