<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #0d1b2a, #1b263b); padding: 1rem 2rem; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .badge-role {
            color: #fff;
            background: #00b4d8;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .profile-header { 
            background: linear-gradient(135deg, #0d1b2a 0%, #1b263b 100%); 
            color: #fff; 
            border-radius: 20px; 
            padding: 4.5rem 3rem; 
            margin-top: 1rem;
            margin-bottom: 2.5rem; 
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(13, 27, 42, 0.2);
        }
        .avatar-container { position: relative; width: fit-content; }
        .profile-avatar { 
            width: 110px; 
            height: 110px; 
            border-radius: 50%; 
            background: rgba(255,255,255,0.15); 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 3rem; 
            font-weight: 700; 
            border: 4px solid #fff; 
        }
        .camera-overlay {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #00b4d8;
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            border: 3px solid #0d1b2a;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .camera-overlay:hover { background: #0077b6; transform: scale(1.1); }
        .info-label { font-size: 0.8rem; text-transform: uppercase; color: #6c757d; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 2px; }
        .info-value { font-size: 1.1rem; font-weight: 700; color: #0d1b2a; }
        .info-box {
            background: #fff;
            padding: 1.2rem;
            border-radius: 12px;
            border: 1px solid #eef0f2;
            border-left: 5px solid #00b4d8;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            height: 100%;
        }
        .info-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            background: #fcfdfe;
        }
        .info-icon {
            width: 45px;
            height: 45px;
            background: rgba(0, 180, 216, 0.1);
            color: #00b4d8;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            margin-right: 18px;
            flex-shrink: 0;
        }
        .btn-custom { border-radius: 12px; padding: 0.8rem 2rem; font-weight: 700; transition: all 0.4s ease; }
        .btn-edit-profile { 
            background: #0d1b2a; 
            color: #fff; 
            border: none;
        }
        .btn-edit-profile:hover { 
            background: #00b4d8; 
            color: #fff; 
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 180, 216, 0.4);
        }
        .btn-delete-account { 
            background: #dc3545 !important; 
            color: #fff !important; 
            border: none;
        }
        .btn-delete-account:hover { 
            background: #bb2d3b !important; 
            color: #fff !important;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
        }
        .stat-card {
            background: #fff;
            border-radius: 15px;
            padding: 1.5rem;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            height: 100%;
            width: 100%;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-right: 15px;
        }
        .stat-value { font-size: 1.4rem; font-weight: 800; color: #0d1b2a; line-height: 1; }
        .stat-label { font-size: 0.8rem; color: #6c757d; font-weight: 600; margin-top: 4px; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-card.active-card { border-top: 5px solid #00b4d8 !important; }
        .stat-card.completed-card { border-top: 5px solid #198754 !important; }
        .stat-card.pending-card { border-top: 5px solid #ffc107 !important; }
        .sidebar-link { 
            display: flex; 
            align-items: center; 
            padding: 12px 20px; 
            color: #415a77; 
            text-decoration: none; 
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            margin-bottom: 2px;
        }
        .sidebar-link:hover { 
            background: #f8f9fa; 
            color: #0d1b2a; 
            border-left: 4px solid #778da9;
            padding-left: 25px;
        }
        .sidebar-link.active { 
            background: #0d1b2a !important; 
            color: #fff !important; 
            font-weight: 600; 
            border-left: 4px solid #00b4d8; 
        }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .sidebar-divider { height: 1px; background: #eee; margin: 5px 0; }
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
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm px-4">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/student/dashboard">
                <i class="bi bi-mortarboard-fill me-2 fs-2 text-info"></i>
                <span class="fs-4 fw-bolder">Tutor Booking</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarContent">
                <div class="ms-auto d-flex align-items-center">
                    <!-- Notification Dropdown -->
                    <div class="dropdown me-4">
                        <a href="#" class="text-white text-decoration-none position-relative" id="notifDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-bell-fill fs-5"></i>
                            <span id="notif-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.5rem; padding: 0.25em 0.4em;">
                                2
                            </span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-3 p-0" style="width: 320px; border-radius: 15px; overflow: hidden;" aria-labelledby="notifDropdown" onclick="event.stopPropagation()">
                            <li class="bg-dark-navy text-white px-3 py-3" style="background: #0d1b2a !important;">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="fw-bold mb-0">Notifications</h6>
                                    <a href="javascript:void(0)" onclick="markAllRead()" class="text-white opacity-75 small text-decoration-none">Mark all as read</a>
                                </div>
                            </li>
                            <li>
                                <div class="dropdown-item py-3 border-bottom px-3 notification-item" id="notif-1">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary bg-opacity-10 p-2 rounded-circle me-3">
                                                <i class="bi bi-calendar-check text-primary"></i>
                                            </div>
                                            <div style="white-space: normal;">
                                                <div class="small fw-bold text-dark">Booking Confirmed</div>
                                                <div class="small text-muted">Your session with Sarah Jenkins is confirmed.</div>
                                                <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">2 hours ago</div>
                                            </div>
                                        </div>
                                        <button onclick="markAsRead(event, 'notif-1')" class="btn btn-sm text-primary p-0 ms-2" title="Mark as read">
                                            <i class="bi bi-check2-all fs-5"></i>
                                        </button>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="dropdown-item py-3 border-bottom px-3 notification-item" id="notif-2">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-info bg-opacity-10 p-2 rounded-circle me-3">
                                                <i class="bi bi-star text-info"></i>
                                            </div>
                                            <div style="white-space: normal;">
                                                <div class="small fw-bold text-dark">Review Request</div>
                                                <div class="small text-muted">Leave a review for Mike Ross.</div>
                                                <div class="very-small text-primary mt-1" style="font-size: 0.7rem;">5 hours ago</div>
                                            </div>
                                        </div>
                                        <button onclick="markAsRead(event, 'notif-2')" class="btn btn-sm text-primary p-0 ms-2" title="Mark as read">
                                            <i class="bi bi-check2-all fs-5"></i>
                                        </button>
                                    </div>
                                </div>
                            </li>
                            <li class="text-center bg-light">
                                <a href="#" class="dropdown-item small py-2 text-primary fw-bold">View All Notifications</a>
                            </li>
                        </ul>
                    </div>

                    <a href="${pageContext.request.contextPath}/student/profile" class="text-white me-4 text-decoration-none d-flex align-items-center">
                        <i class="bi bi-person-circle me-2 fs-5"></i>
                        <span class="fw-semibold">${sessionScope.studentName}</span>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/student/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>
    </nav>

    <div class="container py-5">
        <div class="row">
            <div class="col-lg-3">
                <div class="card p-0 overflow-hidden mb-4">
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="sidebar-link">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <div class="sidebar-divider"></div>
                    <a href="${pageContext.request.contextPath}/student/view-tutors" class="sidebar-link">
                        <i class="bi bi-search"></i> View Tutors
                    </a>
                    <div class="sidebar-divider"></div>
                    <a href="${pageContext.request.contextPath}/student/my-bookings" class="sidebar-link">
                        <i class="bi bi-calendar-check"></i> My Bookings
                    </a>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="profile-header shadow-lg">
                    <div class="d-flex align-items-center gap-4">
                        <div class="avatar-container">
                            <div class="profile-avatar">${student.name.charAt(0)}</div>
                            <div class="camera-overlay" title="Upload Photo">
                                <i class="bi bi-camera-fill"></i>
                            </div>
                        </div>
                        <div>
                            <p class="small text-white-50 mb-1">Welcome back,</p>
                            <h1 class="fw-bold mb-2" style="font-size: 2.5rem;">${student.name}</h1>
                            <span class="badge-role">
                                <i class="bi bi-mortarboard-fill me-2"></i> STUDENT
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="stat-card active-card">
                            <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <div>
                                <div class="stat-value">${confirmedCount}</div>
                                <div class="stat-label">Active Bookings</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card completed-card">
                            <div class="stat-icon bg-success bg-opacity-10 text-success">
                                <i class="bi bi-check-all"></i>
                            </div>
                            <div>
                                <div class="stat-value">0</div>
                                <div class="stat-label">Completed</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card pending-card">
                            <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                                <i class="bi bi-hourglass-split"></i>
                            </div>
                            <div>
                                <div class="stat-value">${pendingCount}</div>
                                <div class="stat-label">Pending Approval</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card p-4">
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4">
                            <i class="bi bi-check-circle me-2"></i> ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <h4 class="fw-bold mb-4" style="color: #0d1b2a">
                        <i class="bi bi-person-lines-fill me-2 text-primary"></i> Profile Information
                    </h4>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-hash"></i></div>
                                <div>
                                    <div class="info-label">Student ID</div>
                                    <div class="info-value">STU-1000${student.id}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-person-fill"></i></div>
                                <div>
                                    <div class="info-label">Full Name</div>
                                    <div class="info-value">${student.name}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-envelope-fill"></i></div>
                                <div>
                                    <div class="info-label">Email Address</div>
                                    <div class="info-value">${student.email}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-telephone-fill"></i></div>
                                <div>
                                    <div class="info-label">Phone Number</div>
                                    <div class="info-value">${student.phone}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-geo-alt-fill"></i></div>
                                <div>
                                    <div class="info-label">Location / Address</div>
                                    <div class="info-value">${student.address}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-box shadow-sm">
                                <div class="info-icon"><i class="bi bi-calendar-event-fill"></i></div>
                                <div>
                                    <div class="info-label">Date Joined</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty student.createdAt}">
                                                <fmt:parseDate value="${student.createdAt.toString()}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy" />
                                            </c:when>
                                            <c:otherwise>01 May 2026</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-3 mt-5">
                        <a href="${pageContext.request.contextPath}/student/edit-profile" class="btn btn-custom btn-edit-profile text-decoration-none">
                            <i class="bi bi-pencil-square me-2"></i> Edit Profile
                        </a>
                        <form action="${pageContext.request.contextPath}/student/delete" method="post" onsubmit="return confirm('Are you sure? This will permanently delete your account.')">
                            <button type="submit" class="btn btn-custom btn-delete-account">
                                <i class="bi bi-trash3 me-2"></i> Delete My Account
                            </button>
                        </form>
                    </div>
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
                    <h6 class="footer-heading">Quick Links</h6>
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="footer-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/student/view-tutors" class="footer-link">Find Tutors</a>
                    <a href="${pageContext.request.contextPath}/student/my-bookings" class="footer-link">My Bookings</a>
                    <a href="${pageContext.request.contextPath}/student/profile" class="footer-link">Profile</a>
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Notification persistence logic
            const readNotifications = JSON.parse(localStorage.getItem('readNotifications') || '[]');
            readNotifications.forEach(id => {
                const item = document.getElementById(id);
                if (item) {
                    item.classList.add('d-none');
                }
            });
            updateBadgeCount();
        });

        function markAsRead(event, id) {
            if (event) event.stopPropagation();
            const item = document.getElementById(id);
            if (!item || item.classList.contains('d-none')) return;

            item.style.opacity = '0.5';
            item.style.background = '#f8f9fa';
            
            setTimeout(() => {
                item.classList.add('d-none');
                
                // Persist to localStorage
                const readNotifications = JSON.parse(localStorage.getItem('readNotifications') || '[]');
                if (!readNotifications.includes(id)) {
                    readNotifications.push(id);
                    localStorage.setItem('readNotifications', JSON.stringify(readNotifications));
                }
                
                updateBadgeCount();
            }, 300);
        }

        function markAllRead() {
            const items = document.querySelectorAll('.notification-item:not(.d-none)');
            const readNotifications = JSON.parse(localStorage.getItem('readNotifications') || '[]');
            
            items.forEach(item => {
                const id = item.id;
                item.style.opacity = '0.5';
                if (!readNotifications.includes(id)) {
                    readNotifications.push(id);
                }
                setTimeout(() => item.classList.add('d-none'), 300);
            });
            
            localStorage.setItem('readNotifications', JSON.stringify(readNotifications));
            
            setTimeout(() => {
                updateBadgeCount();
            }, 400);
        }

        function updateBadgeCount() {
            const badge = document.getElementById('notif-badge');
            if (!badge) return;
            
            const visibleItems = document.querySelectorAll('.notification-item:not(.d-none)');
            const count = visibleItems.length;
            
            if (count <= 0) {
                badge.classList.add('d-none');
            } else {
                badge.innerText = count;
                badge.classList.remove('d-none');
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
