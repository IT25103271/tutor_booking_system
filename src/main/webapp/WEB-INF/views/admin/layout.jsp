<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Admin — ${pageTitle != null ? pageTitle : 'Dashboard'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        /* ── Root ── */
        :root {
            --sidebar-width: 240px;
            --sidebar-collapsed: 68px;
            --navy: #1a1a2e;
            --navy2: #0f3460;
            --accent: #00b4d8;
            --sidebar-text: rgba(255,255,255,0.82);
            --sidebar-hover: rgba(255,255,255,0.10);
            --sidebar-active: rgba(0,180,216,0.18);
        }
        *, *::before, *::after { box-sizing: border-box; }
        body { margin: 0; background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }

        /* ── Sidebar ── */
        #sidebar {
            position: fixed; top: 0; left: 0; height: 100vh; width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--navy) 0%, #0d1b2a 100%);
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
            min-width: 34px; height: 34px; background: var(--navy2);
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
        .topbar-title { font-weight: 700; color: var(--navy); font-size: 1rem; }
        .topbar-breadcrumb { font-size: 0.78rem; color: #adb5bd; margin-left: 4px; }
        .topbar-actions { margin-left: auto; display: flex; align-items: center; gap: 0.75rem; }
        .topbar-avatar {
            width: 34px; height: 34px; background: var(--navy2);
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
            background: linear-gradient(135deg, var(--navy), var(--navy2));
            color: #fff; padding: 0.9rem 1.25rem;
            border-radius: 12px 12px 0 0; font-weight: 600; font-size: 0.9rem;
            display: flex; align-items: center; justify-content: space-between;
        }

        /* ── Alerts ── */
        .alert { border-radius: 10px; font-size: 0.875rem; }

        /* ── Tooltip for collapsed sidebar ── */
        #sidebar.collapsed .sb-nav li { position: relative; }
        #sidebar.collapsed .sb-nav li a::after {
            content: attr(data-label);
            position: absolute; left: calc(var(--sidebar-collapsed) + 8px); top: 50%;
            transform: translateY(-50%);
            background: #1a1a2e; color: #fff; padding: 4px 10px;
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
    <a href="/admin/dashboard" class="sb-brand">
        <div class="sb-brand-icon"><i class="bi bi-mortarboard-fill"></i></div>
        <div>
            <div class="sb-brand-text">TutorBooking</div>
            <div class="sb-brand-sub">Admin Panel</div>
        </div>
    </a>


    <!-- Nav -->
    <ul class="sb-nav">
        <li>
            <a href="/admin/dashboard"
               class="${activePage == 'dashboard' ? 'active' : ''}"
               data-label="Dashboard">
                <i class="bi bi-speedometer2"></i>
                <span class="nav-label">Dashboard</span>
            </a>
        </li>
        <li class="sb-divider"></li>
        <li>
            <a href="/admin/tutors"
               class="${activePage == 'tutors' ? 'active' : ''}"
               data-label="Tutors">
                <i class="bi bi-person-badge"></i>
                <span class="nav-label">Tutors</span>
            </a>
        </li>
        <li>
            <a href="/admin/students"
               class="${activePage == 'students' ? 'active' : ''}"
               data-label="Students">
                <i class="bi bi-mortarboard"></i>
                <span class="nav-label">Students</span>
            </a>
        </li>
        <li>
            <a href="/admin/reviews"
               class="${activePage == 'reviews' ? 'active' : ''}"
               data-label="Reviews">
                <i class="bi bi-star"></i>
                <span class="nav-label">Reviews</span>
            </a>
        </li>
        <li>
            <a href="/admin/bookings"
               class="${activePage == 'bookings' ? 'active' : ''}"
               data-label="Bookings">
                <i class="bi bi-calendar-check"></i>
                <span class="nav-label">Bookings</span>
            </a>
        </li>
        <li class="sb-divider"></li>
        <li>
            <a href="/admin/edit"
               class="${activePage == 'profile' ? 'active' : ''}"
               data-label="Edit Profile">
                <i class="bi bi-pencil-square"></i>
                <span class="nav-label">Edit Profile</span>
            </a>
        </li>
        <li>
            <a href="/admin/delete" data-label="Delete Account"
               style="color:rgba(255,100,100,0.85)"
               onclick="return confirm('Are you sure you want to delete your account? This cannot be undone.')">
                <i class="bi bi-trash"></i><span class="nav-label">Delete Account</span>
            </a>
        </li>

        <li>
            <a href="/admin/logout" data-label="Logout" style="color:rgba(255,100,100,0.85)">
                <i class="bi bi-box-arrow-right"></i>
                <span class="nav-label">Logout</span>
            </a>
        </li>
    </ul>

    <!-- Bottom user -->
    <div class="sb-user">
        <div class="sb-avatar">${sessionScope.adminName != null ? sessionScope.adminName.charAt(0) : 'A'}</div>
        <div class="sb-user-info">
            <div class="sb-user-name">${sessionScope.adminName}</div>
            <div class="sb-user-role">Administrator</div>
        </div>
    </div>
</div>

<!-- ══════════ TOPBAR ══════════ -->
<div id="topbar">
    <button class="sb-toggle" id="sidebarToggle" title="Toggle sidebar">
        <i class="bi bi-list fs-5"></i>
    </button>
    <div>
        <span class="topbar-title">${pageTitle != null ? pageTitle : 'Dashboard'}</span>
        <span class="topbar-breadcrumb">/ Admin</span>
    </div>
</div>

<!-- ══════════ MAIN CONTENT WRAPPER ══════════ -->
<div id="main-content">
