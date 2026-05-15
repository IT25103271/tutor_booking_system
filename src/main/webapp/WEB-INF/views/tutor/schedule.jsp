<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Schedule | Tutor Booking</title>
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
        }

        .card-custom {
            background: white;
            border-radius: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 2rem;
            height: 100%;
            animation: fadeInUp 0.8s ease-out both;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: #64748b;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1.2rem;
            border: 1px solid #e2e8f0;
            background-color: #f8fafc;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-red);
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
        }

        .btn-custom {
            border-radius: 12px;
            padding: 0.7rem 1.5rem;
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

        .table-custom {
            border-radius: 15px;
            overflow: hidden;
        }

        .table-custom thead {
            background-color: #f8fafc;
        }

        .table-custom th {
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            color: #64748b;
            padding: 1.2rem;
            border: none;
        }

        .table-custom td {
            padding: 1.2rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .footer {
            background: var(--dark-navy);
            color: rgba(255,255,255,0.6);
            padding: 4rem 0 2rem;
            margin-top: 5rem;
            border-top: 3px solid var(--accent-red);
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/tutor/dashboard">
                <i class="bi bi-mortarboard-fill me-2 fs-3 text-white"></i>
                <span class="fs-4">Tutor Booking <span class="text-white-50 fs-6 fw-normal">| Tutor Portal</span></span>
            </a>
            <div class="ms-auto">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item me-3">
                        <a class="nav-link" href="${pageContext.request.contextPath}/tutor/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row g-4 align-items-end mb-4">
            <div class="col-md-8">
                <h1 class="fw-bold text-navy-blue display-6">Manage Your Availability</h1>
                <p class="text-muted mb-0">Set and update your teaching slots for students to book.</p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="${pageContext.request.contextPath}/tutor/dashboard" class="text-decoration-none text-muted small fw-bold">
                    <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>
        
        <div class="row g-4">
            <!-- Add Slot Form -->
            <div class="col-lg-4">
                <div class="card-custom">
                    <h5 class="fw-bold mb-4 text-navy-blue d-flex align-items-center">
                        <i class="bi bi-plus-circle-fill me-2 text-accent-red"></i> Add New Time Slot
                    </h5>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger rounded-4 border-0 small py-2">${error}</div>
                    </c:if>
                    <c:if test="${param.added}">
                        <div class="alert alert-success rounded-4 border-0 small py-2">Schedule added successfully!</div>
                    </c:if>
                    <c:if test="${param.deleted}">
                        <div class="alert alert-info rounded-4 border-0 small py-2">Schedule removed.</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/tutor/addSchedule" method="post">
                        <div class="mb-3">
                            <label class="form-label">Date</label>
                            <input type="date" name="availableDate" class="form-control" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Time Slot</label>
                            <select name="timeSlot" class="form-select" required>
                                <option value="">Select a slot</option>
                                <option>09:00 AM - 10:00 AM</option>
                                <option>10:00 AM - 11:00 AM</option>
                                <option>11:00 AM - 12:00 PM</option>
                                <option>12:00 PM - 01:00 PM</option>
                                <option>02:00 PM - 03:00 PM</option>
                                <option>03:00 PM - 04:00 PM</option>
                                <option>04:00 PM - 05:00 PM</option>
                                <option>05:00 PM - 06:00 PM</option>
                                <option>06:00 PM - 07:00 PM</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-navy btn-custom w-100">
                            <i class="bi bi-calendar-plus me-2"></i>Add to Schedule
                        </button>
                    </form>
                </div>
            </div>

            <!-- Schedule List -->
            <div class="col-lg-8">
                <div class="card-custom">
                    <h5 class="fw-bold mb-4 text-navy-blue d-flex align-items-center">
                        <i class="bi bi-calendar-check-fill me-2 text-accent-red"></i> Your Scheduled Availability
                    </h5>
                    <c:choose>
                        <c:when test="${not empty schedules}">
                            <div class="table-responsive">
                                <table class="table table-custom align-middle">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Time Slot</th>
                                            <th class="text-end">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${schedules}" var="sch">
                                            <tr>
                                                <td class="fw-semibold">${sch.availableDate}</td>
                                                <td>
                                                    <span class="badge bg-info bg-opacity-10 text-info px-3 py-2 rounded-pill">
                                                        <i class="bi bi-clock me-1"></i> ${sch.timeSlot}
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <form action="${pageContext.request.contextPath}/tutor/deleteSchedule" method="post" onsubmit="return confirm('Remove this slot?');">
                                                        <input type="hidden" name="scheduleId" value="${sch.scheduleId}">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill px-3">
                                                            <i class="bi bi-trash me-1"></i> Remove
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
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
                                <p class="text-muted">You haven't added any specific availability slots yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container text-center">
            <h5 class="text-white fw-bold mb-2">Tutor Booking</h5>
            <p class="mb-0 small text-white-50">&copy; 2026 Tutor Booking | Developed for Education</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
