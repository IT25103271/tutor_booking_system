<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>${pageTitle != null ? pageTitle : 'Student Portal'} — TutorBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <style>
        /* ── Root ── */
        :root {
            --sidebar-width: 240px;
            --sidebar-collapsed: 68px;
            --primary: #4f6ef7;
            --primary2: #3d5ce5;
            --accent: #38bdf8;
            --danger: #e94560;
            --success: #2dc653;
            --warning: #ffc107;
            --sidebar-text: rgba(255,255,255,0.82);
            --sidebar-hover: rgba(255,255,255,0.10);
            --sidebar-active: rgba(56,189,248,0.18);
        }
        *, *::before, *::after { box-sizing: border-box; }
        body { margin: 0; background: #f0f2f5; font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif; }

        /* ── Sidebar ── */
        #sidebar {
            position: fixed; top: 0; left: 0; height: 100vh; width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--primary) 0%, var(--primary2) 100%);
            border-right: 1px solid rgba(255,255,255,0.07);
            display: flex; flex-direction: column;
            transition: width 0.25s ease; overflow: hidden; z-index: 1040;
        }
        #sidebar.collapsed { width: var(--sidebar-collapsed); }

        /* Brand */
        .sb-brand {
            display: flex; align-items: center; gap: 12px;
            padding: 1.1rem 1.1rem 1rem;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            text-decoration: none; white-space: nowrap; overflow: hidden;
        }
        .sb-brand-icon {
            min-width: 36px; height: 36px; background: var(--accent);
            border-radius: 10px; display: flex; align-items: center;
            justify-content: center; font-size: 1.2rem; color: #fff; flex-shrink: 0;
        }
        .sb-brand-text { color: #fff; font-weight: 700; font-size: 1rem; line-height: 1.2; }
        .sb-brand-sub  { color: rgba(255,255,255,0.45); font-size: 0.68rem; }

        /* Toggle button */
        .sb-toggle {
            background: none; border: none;
            padding: 0.5rem 1.1rem; cursor: pointer; display: flex;
            align-items: center; justify-content: flex-end;
            font-size: 1.1rem; transition: color 0.2s;
        }
        .sb-toggle:hover { color: var(--accent); }
        #sidebar.collapsed .sb-toggle { justify-content: center; }

        /* Nav items */
        .sb-nav { list-style: none; padding: 0.5rem 0; margin: 0; flex: 1; overflow-y: auto; overflow-x: hidden; }
        .sb-nav li a {
            display: flex; align-items: center; gap: 14px;
            padding: 0.7rem 1.1rem; color: var(--sidebar-text);
            text-decoration: none; white-space: nowrap; overflow: hidden;
            border-radius: 0; transition: background 0.18s, color 0.18s;
            font-size: 0.875rem;
        }
        .sb-nav li a:hover  { background: var(--sidebar-hover); color: #fff; }
        .sb-nav li a.active { background: var(--sidebar-active); color: var(--accent); border-right: 3px solid var(--accent); }
        .sb-nav li a i { font-size: 1.1rem; flex-shrink: 0; min-width: 22px; text-align: center; }
        .sb-nav .nav-label { opacity: 1; transition: opacity 0.2s; }
        #sidebar.collapsed .nav-label { opacity: 0; width: 0; }

        /* Section divider */
        .sb-divider { border-top: 1px solid rgba(255,255,255,0.08); margin: 0.5rem 0; }

        /* Bottom user area */
        .sb-user {
            padding: 0.9rem 1.1rem;
            border-top: 1px solid rgba(255,255,255,0.08);
            display: flex; align-items: center; gap: 10px; overflow: hidden;
        }
        .sb-avatar {
            min-width: 34px; height: 34px; background: var(--primary2);
            border: 2px solid var(--accent); border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 700; font-size: 0.85rem; flex-shrink: 0;
        }
        .sb-user-info { overflow: hidden; }
        .sb-user-name { color: #fff; font-size: 0.8rem; font-weight: 600; white-space: nowrap; }
        .sb-user-role { color: rgba(255,255,255,0.4); font-size: 0.7rem; }

        /* ── Topbar ── */
        #topbar {
            position: fixed; top: 0; left: var(--sidebar-width); right: 0; height: 60px;
            background: #fff; border-bottom: 1px solid #e9ecef;
            display: flex; align-items: center; padding: 0 1.5rem;
            gap: 1rem; z-index: 1030;
            transition: left 0.25s ease;
            box-shadow: 0 1px 8px rgba(0,0,0,0.06);
        }
        #topbar.collapsed { left: var(--sidebar-collapsed); }
        .topbar-title { font-weight: 700; color: var(--primary); font-size: 1rem; }
        .topbar-breadcrumb { font-size: 0.78rem; color: #adb5bd; margin-left: 4px; }
        .topbar-actions { margin-left: auto; display: flex; align-items: center; gap: 0.75rem; }
        .topbar-avatar {
            width: 34px; height: 34px; background: var(--primary2);
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; color: #fff; font-weight: 700; font-size: 0.85rem; cursor: pointer;
        }

        /* ── Main content ── */
        #main-content {
            margin-left: var(--sidebar-width);
            margin-top: 60px;
            padding: 1.75rem;
            min-height: calc(100vh - 60px);
            transition: margin-left 0.25s ease;
        }
        #main-content.collapsed { margin-left: var(--sidebar-collapsed); }

        /* ── Cards ── */
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.07); }
        .card-header-custom {
            background: linear-gradient(135deg, var(--primary), var(--primary2));
            color: #fff; padding: 0.9rem 1.25rem;
            border-radius: 12px 12px 0 0; font-weight: 600; font-size: 0.9rem;
            display: flex; align-items: center; justify-content: space-between;
        }

        /* ── Alerts ── */
        .alert { border-radius: 10px; font-size: 0.875rem; }

        /* ── Buttons ── */
        .btn-primary-soft { background: var(--primary); border-color: var(--primary); color: #fff; }
        .btn-primary-soft:hover { background: var(--primary2); border-color: var(--primary2); color: #fff; }
        .btn-outline-primary-soft { border-color: var(--primary); color: var(--primary); }
        .btn-outline-primary-soft:hover { background: var(--primary); color: #fff; }

        /* ── Status badges ── */
        .badge-PENDING   { background: #fff3cd; color: #856404; }
        .badge-CONFIRMED { background: #cff4fc; color: #055160; }
        .badge-COMPLETED { background: #d1e7dd; color: #0a3622; }
        .badge-CANCELLED { background: #f8d7da; color: #842029; }

        /* ── Tables ── */
        .table-hover tbody tr:hover { background-color: rgba(79,110,247,0.04); }
        .table thead th {
            font-weight: 600; font-size: 0.85rem;
            text-transform: uppercase; letter-spacing: 0.05em;
            color: #6c757d; border-bottom: 2px solid #e9ecef;
        }

        /* ── Stat cards ── */
        .stat-card { border-left: 4px solid var(--primary2); transition: transform 0.18s; }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-number { font-size: 1.9rem; font-weight: 700; color: var(--primary2); }

        /* ── Section title ── */
        .section-title {
            color: var(--primary); font-weight: 700;
            border-left: 4px solid var(--primary2); padding-left: 10px;
            margin: 1.75rem 0 1rem; font-size: 1rem;
        }

        /* ── Form focus ── */
        .form-control:focus, .form-select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.2rem rgba(56,189,248,0.25);
        }

        /* ── Tooltip for collapsed sidebar ── */
        #sidebar.collapsed .sb-nav li { position: relative; }
        #sidebar.collapsed .sb-nav li a::after {
            content: attr(data-label);
            position: absolute; left: calc(var(--sidebar-collapsed) + 8px); top: 50%;
            transform: translateY(-50%);
            background: var(--primary); color: #fff; padding: 4px 10px;
            border-radius: 6px; font-size: 0.78rem; white-space: nowrap;
            opacity: 0; pointer-events: none; transition: opacity 0.15s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.25); z-index: 9999;
        }
        #sidebar.collapsed .sb-nav li a:hover::after { opacity: 1; }
    </style>
</head>
<body>

<!-- ══════════ SIDEBAR ══════════ -->
<div id="sidebar">

    <!-- Brand -->
    <a href="${pageContext.request.contextPath}/student/dashboard" class="sb-brand">
        <div class="sb-brand-icon"><i class="bi bi-mortarboard-fill"></i></div>
        <div>
            <div class="sb-brand-text">TutorBooking</div>
            <div class="sb-brand-sub">Student Portal</div>
        </div>
    </a>

    <!-- Nav -->
    <ul class="sb-nav">
        <li>
            <a href="${pageContext.request.contextPath}/student/dashboard"
               class="${activePage == 'dashboard' ? 'active' : ''}"
               data-label="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="nav-label">Dashboard</span>
            </a>
        </li>
        <li class="sb-divider"></li>
        <li>
            <a href="${pageContext.request.contextPath}/student/view-subjects"
               class="${activePage == 'subjects' ? 'active' : ''}"
               data-label="Browse Subjects">
                <i class="bi bi-journal-bookmark"></i>
                <span class="nav-label">Browse Subjects</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/student/view-tutors"
               class="${activePage == 'tutors' ? 'active' : ''}"
               data-label="View Tutors">
                <i class="bi bi-people"></i>
                <span class="nav-label">View Tutors</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/student/my-bookings"
               class="${activePage == 'bookings' ? 'active' : ''}"
               data-label="My Bookings">
                <i class="bi bi-calendar-check"></i>
                <span class="nav-label">My Bookings</span>
            </a>
        </li>
        <li class="sb-divider"></li>
        <li>
            <a href="${pageContext.request.contextPath}/student/profile"
               class="${activePage == 'profile' ? 'active' : ''}"
               data-label="My Profile">
                <i class="bi bi-person-gear"></i>
                <span class="nav-label">My Profile</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/student/logout" data-label="Logout" style="color:rgba(255,100,100,0.85)">
                <i class="bi bi-box-arrow-right"></i>
                <span class="nav-label">Logout</span>
            </a>
        </li>
    </ul>

    <!-- Bottom user -->
    <div class="sb-user">
        <div class="sb-avatar">
            <c:choose>
                <c:when test="${not empty sessionScope.studentName}">${sessionScope.studentName.charAt(0)}</c:when>
                <c:otherwise>S</c:otherwise>
            </c:choose>
        </div>
        <div class="sb-user-info">
            <div class="sb-user-name">${sessionScope.studentName}</div>
            <div class="sb-user-role">Student</div>
        </div>
    </div>
</div>

<!-- ══════════ TOPBAR ══════════ -->
<div id="topbar">
    <button class="sb-toggle" id="sidebarToggle" title="Toggle sidebar">
        <i class="bi bi-list fs-5"></i>
    </button>
    <div>
        <span class="topbar-title">
            <c:if test="${not empty pageIcon}"><i class="bi bi-${pageIcon} me-1"></i></c:if>
            ${pageTitle != null ? pageTitle : 'Dashboard'}
        </span>
        <span class="topbar-breadcrumb">/ Student</span>
    </div>
    <div class="topbar-actions">
        <span class="text-muted small d-none d-md-inline">${student.email}</span>
    </div>
</div>

<!-- ══════════ MAIN CONTENT WRAPPER ══════════ -->
<div id="main-content">

<!-- Global alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mb-3">
        <i class="bi bi-check-circle me-2"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show mb-3">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>