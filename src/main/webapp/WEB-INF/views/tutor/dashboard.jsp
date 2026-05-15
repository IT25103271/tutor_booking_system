<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Dashboard | Tutor Booking</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --dark-navy: #1a1a2e;
            --navy-blue: #16213e;
            --accent-red: #e94560;
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --text-light: #f8fafc;
            --text-muted: #94a3b8;
        }

        body {
            background: #f0f2f5;
            font-family: 'Inter', sans-serif;
            color: #1a1a2e;
            overflow-x: hidden;
        }

        /* Navbar Styles */
        .navbar {
            background: linear-gradient(135deg, var(--dark-navy), var(--navy-blue));
            padding: 1rem 2rem;
            border-bottom: 2px solid var(--accent-red);
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 800;
            letter-spacing: -0.5px;
            color: white !important;
        }

        .nav-link {
            color: rgba(255,255,255,0.8) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--accent-red) !important;
        }

        /* Profile Header */
        .profile-header {
            background: linear-gradient(135deg, var(--dark-navy) 0%, var(--navy-blue) 100%);
            color: white;
            border-radius: 20px;
            padding: 3.5rem 2.5rem;
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
            border-bottom: 5px solid var(--accent-red);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            animation: fadeInDown 0.8s ease-out;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(233, 69, 96, 0.1) 0%, transparent 70%);
            border-radius: 50%;
        }

        .profile-avatar {
            width: 110px;
            height: 110px;
            border-radius: 25px;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: 800;
            border: 3px solid var(--accent-red);
            backdrop-filter: blur(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* Stat Cards */
        .stat-card {
            background: white;
            border: none;
            border-radius: 18px;
            padding: 1.5rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            border-left: 5px solid transparent;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            animation: fadeInUp 0.8s ease-out both;
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .stat-icon {
            width: 55px;
            height: 55px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            margin-bottom: 1.2rem;
            transition: all 0.3s ease;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--dark-navy);
            line-height: 1.2;
        }

        .stat-label {
            font-size: 0.85rem;
            color: #64748b;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .students-card { border-left-color: #4361ee; }
        .sessions-card { border-left-color: #4cc9f0; }
        .pending-card { border-left-color: #ff9f1c; }
        .completed-card { border-left-color: #10b981; }

        /* Dashboard Widgets */
        .dashboard-widget {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            height: 100%;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .widget-header {
            padding: 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .widget-body {
            padding: 1.5rem;
        }

        .btn-custom {
            border-radius: 12px;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-navy {
            background: var(--dark-navy);
            color: white;
            border: none;
        }

        .btn-navy:hover {
            background: var(--navy-blue);
            color: white;
            transform: translateY(-2px);
        }

        .btn-accent {
            background: var(--accent-red);
            color: white;
            border: none;
        }

        .btn-accent:hover {
            background: #d43d56;
            color: white;
            transform: translateY(-2px);
        }

        /* Profile Info Box */
        .info-box {
            background: #f8fafc;
            padding: 1.2rem;
            border-radius: 15px;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .info-box:hover {
            border-color: var(--accent-red);
            background: white;
        }

        .info-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--dark-navy);
        }

        /* Notifications */
        .notif-item {
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid transparent;
        }

        .notif-item:hover {
            background: #f8fafc;
            border-color: #e2e8f0;
        }

        .notif-unread {
            background: rgba(233, 69, 96, 0.05);
            border-left: 4px solid var(--accent-red);
        }

        /* Animations */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Footer */
        .footer {
            background: var(--dark-navy);
            color: rgba(255,255,255,0.6);
            padding: 4rem 0 2rem;
            margin-top: 5rem;
            border-top: 3px solid var(--accent-red);
        }

        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }
        ::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 5px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/tutor/dashboard">
                <i class="bi bi-mortarboard-fill me-2 fs-3 text-white"></i>
                <span class="fs-4">Tutor Booking <span class="text-white-50 fs-6 fw-normal">| Tutor Portal</span></span>
            </a>
            
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item me-3">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/tutor/dashboard">
                            <i class="bi bi-grid-1x2-fill me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item me-3">
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/profile">
                            <i class="bi bi-person-fill me-1"></i> My Profile
                        </a>
                    </li>
                    <li class="nav-item me-3">
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/schedule">
                            <i class="bi bi-calendar-event-fill me-1"></i> Schedule
                        </a>
                    </li>
                    
                    <!-- Notification Dropdown -->
                    <li class="nav-item dropdown me-4">
                        <a class="nav-link position-relative" href="#" id="notifDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-bell-fill fs-5"></i>
                            <span id="notif-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                                3
                            </span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end shadow-lg border-0 p-0 mt-3" style="width: 350px; border-radius: 18px; overflow: hidden;">
                            <div class="p-3 text-white d-flex justify-content-between align-items-center" style="background: linear-gradient(135deg, var(--dark-navy), var(--navy-blue));">
                                <h6 class="mb-0 fw-bold">Recent Notifications</h6>
                                <button onclick="markAllRead()" class="btn btn-sm btn-link text-white text-decoration-none p-0 opacity-75 small">Mark all read</button>
                            </div>
                            <div class="p-2" id="notif-container" style="max-height: 400px; overflow-y: auto;">
                                <!-- Notification Items -->
                                <div class="notif-item notif-unread" id="notif-1">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="bg-primary bg-opacity-10 p-2 rounded-circle">
                                            <i class="bi bi-person-plus-fill text-primary"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <p class="small mb-0 fw-bold">New Student Request</p>
                                                <button onclick="markAsRead(event, 'notif-1')" class="btn btn-sm p-0"><i class="bi bi-x text-muted"></i></button>
                                            </div>
                                            <p class="small text-muted mb-1">A new student is interested in Math sessions.</p>
                                            <span class="very-small text-primary" style="font-size: 0.7rem;">5 mins ago</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="notif-item notif-unread" id="notif-2">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="bg-warning bg-opacity-10 p-2 rounded-circle">
                                            <i class="bi bi-calendar-check text-warning"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <p class="small mb-0 fw-bold">Session Reminder</p>
                                                <button onclick="markAsRead(event, 'notif-2')" class="btn btn-sm p-0"><i class="bi bi-x text-muted"></i></button>
                                            </div>
                                            <p class="small text-muted mb-1">Your session starts in 30 minutes.</p>
                                            <span class="very-small text-primary" style="font-size: 0.7rem;">25 mins ago</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="notif-item" id="notif-3">
                                    <div class="d-flex align-items-start gap-3">
                                        <div class="bg-info bg-opacity-10 p-2 rounded-circle">
                                            <i class="bi bi-info-circle text-info"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <p class="small mb-0 fw-bold">System Update</p>
                                                <button onclick="markAsRead(event, 'notif-3')" class="btn btn-sm p-0"><i class="bi bi-x text-muted"></i></button>
                                            </div>
                                            <p class="small text-muted mb-1">Weekly progress report is now available.</p>
                                            <span class="very-small text-primary" style="font-size: 0.7rem;">2 hours ago</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="d-block text-center p-2 text-primary small fw-bold text-decoration-none border-top bg-light">View All Notifications</a>
                        </div>
                    </li>

                    <!-- User Profile -->
                    <li class="nav-item">
                        <div class="d-flex align-items-center bg-white bg-opacity-10 rounded-pill p-1 pe-3 border border-white border-opacity-10">
                            <div class="bg-white text-navy-blue rounded-circle d-flex align-items-center justify-content-center me-2 fw-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                <c:choose>
                                    <c:when test="${not empty tutor.fullName}">${tutor.fullName.charAt(0)}</c:when>
                                    <c:otherwise>${loggedInTutor.fullName.charAt(0)}</c:otherwise>
                                </c:choose>
                            </div>
                            <span class="text-white small fw-semibold">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.tutorName}">${sessionScope.tutorName}</c:when>
                                    <c:when test="${not empty tutor.fullName}">${tutor.fullName}</c:when>
                                    <c:otherwise>${loggedInTutor.fullName}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </li>
                    <li class="nav-item ms-3">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <!-- Header Section -->
        <div class="profile-header shadow-lg">
            <div class="row align-items-center g-4">
                <div class="col-auto">
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty tutor.fullName}">${tutor.fullName.charAt(0)}</c:when>
                            <c:otherwise>${loggedInTutor.fullName.charAt(0)}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col">
                    <p class="text-white-50 fw-semibold mb-1" style="letter-spacing: 1px;">WELCOME BACK, TUTOR</p>
                    <h1 class="fw-bold mb-2 display-5">
                        <c:choose>
                            <c:when test="${not empty tutor.fullName}">${tutor.fullName}</c:when>
                            <c:otherwise>${loggedInTutor.fullName}</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="d-flex flex-wrap align-items-center gap-3">
                        <span class="badge bg-danger rounded-pill px-3 py-2" style="font-size: 0.8rem;">
                            <i class="bi bi-patch-check-fill me-1"></i> 
                            <c:choose>
                                <c:when test="${not empty tutor.subject}">${tutor.subject}</c:when>
                                <c:otherwise>${loggedInTutor.subject}</c:otherwise>
                            </c:choose>
                            Specialization
                        </span>
                        <span class="text-white-50 small">
                            <i class="bi bi-envelope-fill me-1"></i> 
                            <c:choose>
                                <c:when test="${not empty tutor.email}">${tutor.email}</c:when>
                                <c:otherwise>${loggedInTutor.email}</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="text-white-50 small">
                            <i class="bi bi-star-fill text-warning me-1"></i> 4.9 Rating
                        </span>
                        <span class="badge bg-success bg-opacity-25 text-success rounded-pill px-3 py-1 border border-success border-opacity-25" style="font-size: 0.75rem;">
                            <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i> Online
                        </span>
                    </div>
                </div>
                <div class="col-lg-auto ms-auto text-end d-none d-lg-block">
                    <div class="glass p-3 rounded-4 border border-white border-opacity-10 text-center" style="width: 150px;">
                        <h6 class="text-white-50 small mb-1">EXPERIENCE</h6>
                        <h3 class="fw-bold text-white mb-0">
                            <c:choose>
                                <c:when test="${not empty tutor.experience}">${tutor.experience}</c:when>
                                <c:otherwise>${loggedInTutor.experience}</c:otherwise>
                            </c:choose> Years
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="stat-card students-card" style="animation-delay: 0.1s;">
                    <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-value">${not empty totalStudents ? totalStudents : '12'}</div>
                    <div class="stat-label">Total Students</div>
                    <p class="text-muted small mt-2 mb-0">+2 new this month</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card sessions-card" style="animation-delay: 0.2s;">
                    <div class="stat-icon bg-info bg-opacity-10 text-info">
                        <i class="bi bi-camera-video-fill"></i>
                    </div>
                    <div class="stat-value">${not empty totalSessions ? totalSessions : '48'}</div>
                    <div class="stat-label">Total Sessions</div>
                    <p class="text-muted small mt-2 mb-0">Across 5 subjects</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card pending-card" style="animation-delay: 0.3s;">
                    <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <div class="stat-value">${not empty pendingRequests ? pendingRequests : '5'}</div>
                    <div class="stat-label">Pending Requests</div>
                    <p class="text-muted small mt-2 mb-0">Needs your response</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card completed-card" style="animation-delay: 0.4s;">
                    <div class="stat-icon bg-success bg-opacity-10 text-success">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                    <div class="stat-value">${not empty completedSessions ? completedSessions : '32'}</div>
                    <div class="stat-label">Completed Sessions</div>
                    <p class="text-muted small mt-2 mb-0">Excellent track record</p>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left Column: Management Widgets -->
            <div class="col-lg-8">
                <div class="row g-4">
                    <!-- Schedule Widget -->
                    <div class="col-12">
                        <div class="dashboard-widget">
                            <div class="widget-header">
                                <h5 class="fw-bold mb-0 text-navy-blue">
                                    <i class="bi bi-calendar-check me-2 text-accent-red"></i> Upcoming Available Slots
                                </h5>
                                <a href="${pageContext.request.contextPath}/tutor/schedule" class="btn btn-navy btn-sm btn-custom">
                                    Manage All
                                </a>
                            </div>
                            <div class="widget-body">
                                <c:choose>
                                    <c:when test="${not empty schedules}">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th class="border-0 rounded-start">Date</th>
                                                        <th class="border-0">Time Slot</th>
                                                        <th class="border-0 text-center">Status</th>
                                                        <th class="border-0 text-end rounded-end">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${schedules}" var="sch" varStatus="loop">
                                                        <c:if test="${loop.index < 4}">
                                                            <tr>
                                                                <td class="fw-semibold text-navy-blue">${sch.availableDate}</td>
                                                                <td><span class="badge bg-info bg-opacity-10 text-info px-3">${sch.timeSlot}</span></td>
                                                                <td class="text-center"><span class="badge bg-success px-3">Available</span></td>
                                                                <td class="text-end">
                                                                    <button class="btn btn-sm btn-outline-primary rounded-pill px-3">Edit</button>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <div class="bg-light rounded-circle d-inline-flex p-4 mb-3">
                                                <i class="bi bi-calendar-x fs-1 text-muted"></i>
                                            </div>
                                            <p class="text-muted">No schedules added yet.</p>
                                            <a href="${pageContext.request.contextPath}/tutor/schedule" class="btn btn-accent btn-custom">Add Availability Now</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Management Grid -->
                    <div class="col-md-6">
                        <div class="dashboard-widget p-4 text-center">
                            <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-3">
                                <i class="bi bi-chat-left-dots-fill fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Manage Student Requests</h6>
                            <p class="small text-muted mb-4">Review and accept incoming booking requests from students.</p>
                            <a href="#" class="btn btn-navy w-100 btn-custom">View Requests</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="dashboard-widget p-4 text-center">
                            <div class="bg-info bg-opacity-10 text-info rounded-circle d-inline-flex p-3 mb-3">
                                <i class="bi bi-file-earmark-text-fill fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Teaching Materials</h6>
                            <p class="small text-muted mb-4">Upload and organize study guides, notes, and exercises.</p>
                            <a href="#" class="btn btn-navy w-100 btn-custom">Manage Materials</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="dashboard-widget p-4 text-center">
                            <div class="bg-success bg-opacity-10 text-success rounded-circle d-inline-flex p-3 mb-3">
                                <i class="bi bi-wallet2 fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Earnings Overview</h6>
                            <p class="small text-muted mb-4">Track your income summary and payment history.</p>
                            <a href="#" class="btn btn-navy w-100 btn-custom">View Earnings</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="dashboard-widget p-4 text-center">
                            <div class="bg-danger bg-opacity-10 text-danger rounded-circle d-inline-flex p-3 mb-3">
                                <i class="bi bi-gear-fill fs-3"></i>
                            </div>
                            <h6 class="fw-bold">Account Settings</h6>
                            <p class="small text-muted mb-4">Update your profile settings and security preferences.</p>
                            <a href="${pageContext.request.contextPath}/tutor/settings" class="btn btn-navy w-100 btn-custom">Go to Settings</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Profile Panel -->
            <div class="col-lg-4">
                <div class="dashboard-widget">
                    <div class="widget-header">
                        <h5 class="fw-bold mb-0 text-navy-blue">
                            <i class="bi bi-info-square-fill me-2 text-accent-red"></i> Profile Information
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="info-box">
                            <div class="info-label">Full Name</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty tutor.fullName}">${tutor.fullName}</c:when>
                                    <c:when test="${not empty tutor.name}">${tutor.name}</c:when>
                                    <c:otherwise>${loggedInTutor.fullName}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Email Address</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty tutor.email}">${tutor.email}</c:when>
                                    <c:otherwise>${loggedInTutor.email}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty tutor.phoneNumber}">${tutor.phoneNumber}</c:when>
                                    <c:when test="${not empty tutor.phone}">${tutor.phone}</c:when>
                                    <c:otherwise>${loggedInTutor.phoneNumber}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Subject Specialization</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty tutor.subject}">${tutor.subject}</c:when>
                                    <c:otherwise>${loggedInTutor.subject}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Qualification</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty tutor.qualification}">${tutor.qualification}</c:when>
                                    <c:otherwise>${loggedInTutor.qualification}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Hourly Rate</div>
                            <div class="info-value">Rs. 
                                <c:choose>
                                    <c:when test="${not empty tutor.hourlyRate}">${tutor.hourlyRate}</c:when>
                                    <c:otherwise>${loggedInTutor.hourlyRate}</c:otherwise>
                                </c:choose>/hour
                            </div>
                        </div>
                        <div class="info-box">
                            <div class="info-label">Bio</div>
                            <div class="info-value small fw-normal text-muted">
                                <c:choose>
                                    <c:when test="${not empty tutor.aboutTutor}">${tutor.aboutTutor}</c:when>
                                    <c:otherwise>${loggedInTutor.aboutTutor}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-3 mt-4">
                            <a href="${pageContext.request.contextPath}/tutor/editProfile" class="btn btn-navy btn-custom">
                                <i class="bi bi-pencil-square me-2"></i>Edit Profile
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-custom" onclick="confirmDelete()">
                                <i class="bi bi-trash3-fill me-2"></i>Delete Account
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <h5 class="text-white fw-bold mb-2">Tutor Booking</h5>
                    <p class="mb-0 small text-white-50">Premium Online Tutoring Management System</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="mb-1 small">&copy; 2026 Tutor Booking | Developed for Education</p>
                    <p class="mb-0 very-small text-white-50" style="font-size: 0.7rem;">System Version 3.1.0-Stable | Built with Spring Boot & Bootstrap 5</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Notification System
        document.addEventListener('DOMContentLoaded', function() {
            const readNotifications = JSON.parse(localStorage.getItem('tutorReadNotifications') || '[]');
            readNotifications.forEach(id => {
                const item = document.getElementById(id);
                if (item) item.remove();
            });
            updateBadgeCount();
        });

        function markAsRead(event, id) {
            if (event) event.stopPropagation();
            const item = document.getElementById(id);
            if (!item) return;

            item.style.opacity = '0';
            item.style.transform = 'translateX(20px)';
            
            setTimeout(() => {
                const readNotifications = JSON.parse(localStorage.getItem('tutorReadNotifications') || '[]');
                if (!readNotifications.includes(id)) {
                    readNotifications.push(id);
                    localStorage.setItem('tutorReadNotifications', JSON.stringify(readNotifications));
                }
                item.remove();
                updateBadgeCount();
            }, 300);
        }

        function markAllRead() {
            const items = document.querySelectorAll('.notif-item');
            const readNotifications = JSON.parse(localStorage.getItem('tutorReadNotifications') || '[]');
            
            items.forEach(item => {
                const id = item.id;
                if (!readNotifications.includes(id)) readNotifications.push(id);
                item.style.opacity = '0';
                item.style.transform = 'translateX(20px)';
            });

            setTimeout(() => {
                items.forEach(item => item.remove());
                localStorage.setItem('tutorReadNotifications', JSON.stringify(readNotifications));
                updateBadgeCount();
            }, 300);
        }

        function updateBadgeCount() {
            const badge = document.getElementById('notif-badge');
            if (!badge) return;
            const visibleItems = document.querySelectorAll('.notif-item').length;
            if (visibleItems <= 0) {
                badge.style.display = 'none';
                const container = document.getElementById('notif-container');
                if (container && container.children.length === 0) {
                    container.innerHTML = '<div class="p-4 text-center text-muted small">No new notifications</div>';
                }
            } else {
                badge.innerText = visibleItems;
                badge.style.display = 'block';
            }
        }

        // Delete Account Confirmation
        function confirmDelete() {
            if (confirm('Are you absolutely sure you want to delete your tutor account? This action cannot be undone and all your session data will be permanently lost.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/tutor/delete';
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
