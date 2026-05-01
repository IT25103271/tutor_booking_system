<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #0d1b2a, #1b263b); padding: 1rem 2rem; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .profile-header { 
            background: linear-gradient(135deg, #0d1b2a 0%, #1b263b 100%); 
            color: #fff; 
            border-radius: 15px; 
            padding: 3.5rem 2.5rem; 
            margin-bottom: 2rem; 
            position: relative;
            overflow: hidden;
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
        .action-card {
            border: none;
            border-radius: 20px;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            overflow: hidden;
            background: #fff;
            position: relative;
        }
        .action-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.12);
        }
        .action-card::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, #0d1b2a, #00b4d8);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }
        .action-card:hover::after {
            transform: scaleX(1);
        }
        .action-icon {
            width: 60px;
            height: 60px;
            background: #f8f9fa;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #0d1b2a;
            margin-bottom: 1.5rem;
            transition: 0.3s;
        }
        .action-card:hover .action-icon {
            background: #0d1b2a;
            color: #fff;
            transform: rotate(-10deg);
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
        .info-label { font-size: 0.8rem; text-transform: uppercase; color: #6c757d; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 4px; }
        .info-value { font-size: 1.1rem; font-weight: 500; color: #0d1b2a; }
        .btn-custom { border-radius: 10px; padding: 0.7rem 1.5rem; font-weight: 600; transition: 0.3s; }
        .btn-dark-navy { background: #0d1b2a; color: #fff; }
        .btn-dark-navy:hover { background: #1b263b; color: #fff; }
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
        .action-card {
            transition: all 0.3s ease;
            border-bottom: 4px solid transparent !important;
        }
        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
            border-bottom: 4px solid #00b4d8 !important;
        }
        .action-card i { transition: transform 0.3s ease; }
        .action-card:hover i { transform: scale(1.2); }
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

    <div class="container py-5">
        <div class="row">
            <div class="col-lg-3">
                <div class="card p-0 overflow-hidden mb-4">
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="sidebar-link active">
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
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <span class="badge-role">
                                    <i class="bi bi-mortarboard-fill me-2"></i> STUDENT
                                </span>
                                <c:if test="${not empty sessionScope.lastLoginTime}">
                                    <span class="text-white opacity-75 small">
                                        <i class="bi bi-clock-history me-1"></i> Last login: ${sessionScope.lastLoginTime.toString().replace('T', ' ').substring(0, 16)}
                                    </span>
                                </c:if>
                            </div>
                            <p class="mb-0 opacity-75">Manage your tutoring sessions and discover new learning opportunities.</p>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card p-4 h-100 text-center action-card">
                            <div class="mb-3">
                                <i class="bi bi-search text-primary display-4"></i>
                            </div>
                            <h4 class="fw-bold">Find a Tutor</h4>
                            <p class="text-muted">Browse our list of expert tutors and find the perfect match for your needs.</p>
                            <a href="${pageContext.request.contextPath}/student/view-tutors" class="btn btn-dark-navy mt-auto">Browse Tutors</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card p-4 h-100 text-center action-card">
                            <div class="mb-3">
                                <i class="bi bi-calendar-check text-success display-4"></i>
                            </div>
                            <h4 class="fw-bold">My Bookings</h4>
                            <p class="text-muted">View your current booking status and manage your upcoming sessions.</p>
                            <a href="${pageContext.request.contextPath}/student/my-bookings" class="btn btn-dark-navy mt-auto">View Bookings</a>
                        </div>
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
            const now = new Date();
            const hours = now.getHours();
            let greeting = 'Welcome';
            
            if (hours >= 5 && hours < 12) {
                greeting = 'Good Morning';
            } else if (hours >= 12 && hours < 17) {
                greeting = 'Good Afternoon';
            } else if (hours >= 17 && hours < 21) {
                greeting = 'Good Evening';
            } else {
                greeting = 'Good Night';
            }
            
            document.getElementById('timeGreeting').innerText = greeting;
        });

        function markAsRead(event, id) {
            if (event) event.stopPropagation();
            const item = document.getElementById(id);
            if (!item || item.classList.contains('d-none')) return;

            item.style.opacity = '0.5';
            item.style.background = '#f8f9fa';
            
            setTimeout(() => {
                item.classList.add('d-none');
                updateBadgeCount(-1);
                checkEmptyNotifs();
            }, 300);
        }

        function markAllRead() {
            const items = document.querySelectorAll('.notification-item:not(.d-none)');
            const count = items.length;
            items.forEach(item => {
                item.style.opacity = '0.5';
                setTimeout(() => item.classList.add('d-none'), 300);
            });
            setTimeout(() => {
                updateBadgeCount(-count);
                checkEmptyNotifs();
            }, 400);
        }

        function updateBadgeCount(delta) {
            const badge = document.getElementById('notif-badge');
            if (!badge) return;
            
            let currentCount = parseInt(badge.innerText) || 0;
            currentCount += delta;
            
            if (currentCount <= 0) {
                badge.classList.add('d-none');
            } else {
                badge.innerText = currentCount;
                badge.classList.remove('d-none');
            }
        }

        function checkEmptyNotifs() {
            const items = document.querySelectorAll('.notification-item:not(.d-none)');
            if (items.length === 0) {
                // Optional: show "No new notifications" message
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
