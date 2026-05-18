<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A secure, university-approved portal connecting undergraduate students with top-rated personal instructors. Developed for SLIIT by Group WD204.">
    <title>Home Tutor Booking System | Elite SLIIT Landing Portal</title>
    
    <!-- Google Web Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        /* ==========================================================================
           1. CORE PREMIUM DESIGN SYSTEM & COLOR TOKENS
           ========================================================================== */
        :root {
            --color-primary-dark: #0d1e2d;
            --color-container-white: #ffffff;
            --color-body-bg: #f4f7fa;
            --color-accent-teal: #00a896;
            --color-accent-neon: #00ced1;
            --color-text-dark: #1e293b;
            --color-text-muted: #64748b;
            --color-text-light: #94a3b8;
            --color-border: rgba(0, 0, 0, 0.05);
            
            /* Enhanced 3D Animation Cubic-Bezier curve */
            --transition-premium: all 0.4s cubic-bezier(0.2, 0.8, 0.2, 1);
            --transition-fast: all 0.2s ease;
            --font-family: 'Inter', sans-serif;
        }

        /* ==========================================================================
           2. GLOBAL RESETS & BASE STYLES
           ========================================================================== */
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: var(--font-family);
            background-color: var(--color-body-bg);
            color: var(--color-text-dark);
            line-height: 1.6;
            letter-spacing: -0.01em;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
            color: inherit;
            transition: var(--transition-fast);
        }

        ul {
            list-style: none;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* ==========================================================================
           3. TOP NAVIGATION BAR (<nav>)
           ========================================================================== */
        .navbar {
            background-color: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--color-border);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 16px 0;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.01);
            transition: var(--transition-premium);
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1340px;
            margin: 0 auto;
            width: 100%;
            padding: 0 24px;
        }

        /* Logo Layout */
        .logo-block {
            display: flex;
            align-items: center;
            gap: 14px;
            cursor: pointer;
            transition: var(--transition-premium);
        }

        .logo-block:hover {
            transform: translateY(-1px);
        }

        .logo-box {
            background-color: var(--color-accent-neon);
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 14px rgba(0, 206, 209, 0.3);
            transition: var(--transition-premium);
        }

        /* Highly Styled Graduation Cap Unicode symbol */
        .logo-box span {
            font-size: 24px;
            color: #ffffff;
            font-weight: 700;
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition-premium);
        }

        .logo-block:hover .logo-box span {
            transform: scale(1.15) rotate(-8deg);
        }

        .logo-text-stack {
            display: flex;
            flex-direction: column;
            line-height: 1.1;
        }

        .logo-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--color-primary-dark);
            letter-spacing: -0.03em;
        }

        .logo-subtitle {
            font-size: 13px;
            color: var(--color-text-muted);
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        /* Nav Menu Links */
        .nav-links {
            display: flex;
            align-items: center;
            gap: 32px;
        }

        .nav-link-item a {
            font-size: 15px;
            font-weight: 500;
            color: var(--color-primary-dark);
            position: relative;
            padding: 6px 0;
            transition: var(--transition-fast);
        }

        .nav-link-item a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: var(--color-accent-neon);
            transition: var(--transition-fast);
        }

        .nav-link-item a:hover {
            color: var(--color-accent-neon);
        }

        .nav-link-item a:hover::after {
            width: 100%;
        }

        /* ==========================================================================
           4. HIGH-END HERO BANNER (<header>)
           ========================================================================== */
        .hero-banner {
            position: relative;
            padding: 90px 0;
            /* Deeper immersive soft radial gradient for premium studio backdrop depth */
            background: radial-gradient(120% 120% at 50% 0%, rgba(0, 206, 209, 0.08) 0%, rgba(13, 30, 45, 0.01) 50%, rgba(244, 247, 250, 1) 100%);
            border-bottom: 1px solid rgba(0, 0, 0, 0.02);
            text-align: center;
            overflow: hidden;
        }

        /* Studio lighting glow overlays */
        .hero-banner::before {
            content: '';
            position: absolute;
            top: -40%;
            left: -10%;
            width: 600px;
            height: 600px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 206, 209, 0.1) 0%, transparent 65%);
            z-index: 0;
            pointer-events: none;
        }

        .hero-banner::after {
            content: '';
            position: absolute;
            bottom: -40%;
            right: -10%;
            width: 600px;
            height: 600px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 168, 150, 0.08) 0%, transparent 65%);
            z-index: 0;
            pointer-events: none;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 850px;
            margin: 0 auto;
        }

        .hero-heading {
            font-size: 52px;
            font-weight: 800;
            color: var(--color-primary-dark);
            line-height: 1.25;
            margin-bottom: 24px;
            letter-spacing: -0.04em;
            animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .hero-subheading {
            font-size: 18px;
            color: var(--color-text-muted);
            margin-bottom: 42px;
            line-height: 1.75;
            font-weight: 400;
            padding: 0 45px;
            letter-spacing: -0.01em;
            animation: fadeInUp 1s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .hero-btn {
            display: inline-block;
            background-color: var(--color-primary-dark);
            color: #ffffff;
            padding: 18px 40px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            box-shadow: 0 4px 14px rgba(13, 30, 45, 0.25);
            transition: var(--transition-premium);
            animation: fadeInUp 1.2s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        /* Lift and Glow under-shadow upon user interaction */
        .hero-btn:hover {
            background-color: var(--color-accent-neon);
            box-shadow: 0 8px 24px rgba(0, 206, 209, 0.45);
            transform: translateY(-8px) scale(1.015);
        }

        /* ==========================================================================
           5. THE PORTAL GATEWAY CARDS GRID (<main>)
           ========================================================================== */
        .main-section {
            padding: 90px 0;
            flex-grow: 1;
        }

        .cards-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }

        .portal-card {
            background-color: var(--color-container-white);
            border: 1px solid var(--color-border);
            border-radius: 18px;
            padding: 44px 34px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            position: relative;
            transition: var(--transition-premium);
        }

        /* Modern 3D micro-lifting animations */
        .portal-card:hover {
            transform: translateY(-8px) scale(1.015);
            box-shadow: 0 20px 45px rgba(13, 30, 45, 0.08);
            border-color: rgba(0, 206, 209, 0.25);
        }

        .card-icon-wrapper {
            width: 72px;
            height: 72px;
            border-radius: 16px;
            background-color: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin-bottom: 28px;
            transition: var(--transition-premium);
        }

        .portal-card:nth-child(1) .card-icon-wrapper {
            background-color: rgba(0, 168, 150, 0.08);
        }

        .portal-card:nth-child(2) .card-icon-wrapper {
            background-color: rgba(0, 206, 209, 0.08);
        }

        .portal-card:nth-child(3) .card-icon-wrapper {
            background-color: rgba(13, 30, 45, 0.05);
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--color-primary-dark);
            margin-bottom: 14px;
            letter-spacing: -0.02em;
        }

        .card-description {
            font-size: 14px;
            color: var(--color-text-muted);
            line-height: 1.65;
            margin-bottom: 32px;
            min-height: 76px;
        }

        .card-cta-btn {
            width: 100%;
            text-align: center;
            padding: 13px 20px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 15px;
            color: var(--color-primary-dark);
            border: 1.5px solid var(--color-primary-dark);
            background-color: transparent;
            margin-top: auto;
            /* Instantly shift color matched to the rich #00ced1 shade on card-hover */
            transition: background-color 0s, border-color 0s, color 0s, box-shadow 0.2s ease;
        }

        /* Button hover match effect */
        .portal-card:hover .card-cta-btn {
            background-color: var(--color-accent-neon);
            border-color: var(--color-accent-neon);
            color: #ffffff;
            box-shadow: 0 6px 18px rgba(0, 206, 209, 0.3);
        }

        /* ==========================================================================
           6. PREMIUM ACADEMIC DETAILS BLOCK (<section>)
           ========================================================================== */
        .about-section {
            background-color: var(--color-container-white);
            border-top: 1px solid var(--color-border);
            padding: 90px 0;
            position: relative;
        }

        .about-content {
            max-width: 850px;
            margin: 0 auto;
            text-align: center;
        }

        .about-title-wrapper {
            display: inline-block;
            margin-bottom: 24px;
            position: relative;
        }

        .about-heading {
            font-size: 28px;
            font-weight: 700;
            color: var(--color-primary-dark);
            padding-bottom: 12px;
            letter-spacing: -0.02em;
        }

        /* Elegant accent divider line */
        .about-title-wrapper::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background-color: var(--color-accent-neon);
            border-radius: 2px;
        }

        .about-description {
            font-size: 15px;
            line-height: 1.85;
            color: var(--color-text-muted);
            margin-bottom: 38px;
        }

        /* Capsule-shaped Pill Labels */
        .badges-list {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .badge-pill {
            background-color: #f1f5f9;
            border: 1px solid #e2e8f0;
            color: var(--color-text-dark);
            padding: 10px 22px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition-premium);
            cursor: default;
        }

        .badge-pill:hover {
            background-color: #e2e8f0;
            color: var(--color-primary-dark);
            transform: translateY(-2px);
        }

        /* ==========================================================================
           7. INTEGRATED GLOBAL SYSTEM FOOTER (<footer>)
           ========================================================================== */
        .footer {
            background-color: var(--color-primary-dark);
            color: #ffffff;
            position: relative;
            border-top: 4px solid var(--color-accent-teal);
        }

        .footer-columns-grid {
            display: grid;
            grid-template-columns: 1.8fr 1fr 1.2fr;
            gap: 50px;
            padding: 60px 0 45px 0;
        }

        /* Footer Column 1: Branding */
        .footer-branding-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Replicated Logo for Footer with Custom Sub-label 'Admin Panel' */
        .footer-logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .footer-logo-box {
            background-color: var(--color-accent-neon);
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(0, 206, 209, 0.15);
        }

        .footer-logo-box span {
            font-size: 24px;
            color: #ffffff;
            font-weight: 700;
            line-height: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .footer-logo-text {
            display: flex;
            flex-direction: column;
            line-height: 1.1;
        }

        .footer-logo-title {
            font-size: 22px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.03em;
        }

        .footer-logo-subtitle {
            font-size: 13px;
            color: var(--color-text-light);
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        .footer-tracking-text {
            font-size: 14px;
            color: var(--color-text-light);
            line-height: 1.65;
            max-width: 320px;
        }

        /* Footer Column 2: Navigation Map */
        .footer-links-column {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .footer-col-title {
            font-size: 14px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            position: relative;
            padding-bottom: 8px;
        }

        .footer-col-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 30px;
            height: 2px;
            background-color: var(--color-accent-teal);
        }

        .footer-vertical-links {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .footer-vertical-links li a {
            font-size: 14px;
            color: var(--color-text-light);
            transition: var(--transition-fast);
        }

        .footer-vertical-links li a:hover {
            color: var(--color-accent-neon);
            padding-left: 4px;
        }

        /* Footer Column 3: Contact Info */
        .footer-contact-column {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .contact-details {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .address-box {
            font-size: 14px;
            color: var(--color-text-light);
            line-height: 1.6;
        }

        .address-header {
            font-weight: 700;
            color: #ffffff;
            display: block;
            margin-bottom: 4px;
        }

        .meeting-note {
            font-size: 13px;
            font-weight: 600;
            color: var(--color-accent-teal);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Base Copyright Bar */
        .footer-bottom-line {
            border-top: 1px solid rgba(255, 255, 255, 0.06);
            padding: 24px 0;
            text-align: center;
        }

        .copyright-text {
            font-size: 13px;
            color: var(--color-text-light);
            font-weight: 400;
        }

        /* ==========================================================================
           8. ANIMATIONS & RESPONSIVE MEDIA QUERIES
           ========================================================================== */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Layout Breaks */
        @media (max-width: 992px) {
            .cards-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 24px;
            }
            .hero-heading {
                font-size: 42px;
            }
            .footer-columns-grid {
                grid-template-columns: 1fr 1fr;
                gap: 40px;
            }
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 18px;
                padding: 6px 24px;
            }
            .nav-links {
                gap: 20px;
            }
            .hero-banner {
                padding: 70px 0 50px 0;
            }
            .hero-heading {
                font-size: 34px;
            }
            .hero-subheading {
                font-size: 15px;
                padding: 0 10px;
            }
            .cards-grid {
                grid-template-columns: 1fr;
            }
            .footer-columns-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            .footer-tracking-text {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- ==========================================================================
       A. TOP NAVIGATION BAR (<nav>)
       ========================================================================== -->
    <nav class="navbar" id="main-nav">
        <div class="nav-container">
            <!-- Left Side Logo -->
            <a href="${contextPath}/" class="logo-block" aria-label="TutorBooking Portal Home">
                <div class="logo-box">
                    <span>&#127891;</span>
                </div>
                <div class="logo-text-stack">
                    <span class="logo-title">TutorBooking</span>
                    <span class="logo-subtitle">Portal</span>
                </div>
            </a>
            
            <!-- Right Side Links -->
            <ul class="nav-links">
                <li class="nav-link-item"><a href="${contextPath}/">Home</a></li>
                <li class="nav-link-item"><a href="${contextPath}/student/view-tutors">Browse Tutors</a></li>
                <li class="nav-link-item"><a href="#about">About</a></li>
                <li class="nav-link-item"><a href="#footer">Contact</a></li>
            </ul>
        </div>
    </nav>

    <!-- ==========================================================================
       B. HIGH-END HERO BANNER (<header>)
       ========================================================================== -->
    <header class="hero-banner" id="hero">
        <div class="container hero-content">
            <h1 class="hero-heading">Find the Perfect Expert Tutor for Your Studies</h1>
            <p class="hero-subheading">A secure, university-approved portal connecting undergraduate students with top-rated personal instructors.</p>
            <a href="${contextPath}/student/view-tutors" class="hero-btn" id="hero-cta-btn">Explore Tutors Now</a>
        </div>
    </header>

    <!-- ==========================================================================
       C. THE PORTAL GATEWAY CARDS GRID (<main>)
       ========================================================================== -->
    <main class="main-section" id="main-content">
        <div class="container">
            <div class="cards-grid">
                
                <!-- Card 1: Student Portal -->
                <article class="portal-card" id="student-portal-card">
                    <div class="card-icon-wrapper" aria-hidden="true">📖</div>
                    <h3 class="card-title">Student Portal</h3>
                    <p class="card-description">Looking for personal help? Find expert tutors, choose schedules, and book your session instantly.</p>
                    <a href="${contextPath}/student/login" class="card-cta-btn" id="student-login-btn">Student Login / Register</a>
                </article>

                <!-- Card 2: Tutor Portal -->
                <article class="portal-card" id="tutor-portal-card">
                    <div class="card-icon-wrapper" aria-hidden="true">👨‍🏫</div>
                    <h3 class="card-title">Tutor Portal</h3>
                    <p class="card-description">Are you an educator? Join our system, sync your operational availability, and manage student tracks.</p>
                    <a href="${contextPath}/tutor/login" class="card-cta-btn" id="tutor-login-btn">Tutor Login</a>
                </article>

                <!-- Card 3: Admin Panel -->
                <article class="portal-card" id="admin-panel-card">
                    <div class="card-icon-wrapper" aria-hidden="true">⚙️</div>
                    <h3 class="card-title">Admin Panel</h3>
                    <p class="card-description">Authorized institutional administrative management and structural system control access parameters only.</p>
                    <a href="${contextPath}/admin/login" class="card-cta-btn" id="admin-login-btn">Admin Panel</a>
                </article>

            </div>
        </div>
    </main>

    <!-- ==========================================================================
       D. PREMIUM ACADEMIC DETAILS BLOCK (<section>)
       ========================================================================== -->
    <section class="about-section" id="about">
        <div class="container about-content">
            <div class="about-title-wrapper">
                <h2 class="about-heading">About Our Project</h2>
            </div>
            <p class="about-description">
                The Home Tutor Booking System is an enterprise-grade web application designed as the core group submission for the software evaluation module framework. Engineered using decoupled Model-View-Controller patterns, the system facilitates role-based control limits to bridge learning boundaries safely.
            </p>
            
            <!-- Metadata Badges -->
            <div class="badges-list" role="list">
                <span class="badge-pill" role="listitem">Cohort: Y1S2</span>
                <span class="badge-pill" role="listitem">Module: SE1020 - OOP</span>
                <span class="badge-pill" role="listitem">Group: WD204</span>
                <span class="badge-pill" role="listitem">Sub-Group: 11.01</span>
            </div>
        </div>
    </section>

    <!-- ==========================================================================
       E. INTEGRATED GLOBAL SYSTEM FOOTER (<footer>)
       ========================================================================== -->
    <footer class="footer" id="footer">
        <div class="container">
            
            <!-- 3 Responsive Columns -->
            <div class="footer-columns-grid">
                
                <!-- Column 1: Branding -->
                <div class="footer-branding-column">
                    <div class="footer-logo">
                        <div class="footer-logo-box">
                            <span>&#127891;</span>
                        </div>
                        <div class="footer-logo-text">
                            <span class="footer-logo-title">TutorBooking</span>
                            <span class="footer-logo-subtitle">Admin Panel</span>
                        </div>
                    </div>
                    <p class="footer-tracking-text">
                        This is an academic project developed for SE1020 - OOP Module at SLIIT by Group WD204.
                    </p>
                </div>

                <!-- Column 2: Navigation Map -->
                <div class="footer-links-column">
                    <h4 class="footer-col-title">QUICK LINKS</h4>
                    <ul class="footer-vertical-links">
                        <li><a href="${contextPath}/student/dashboard">Dashboard</a></li>
                        <li><a href="${contextPath}/student/view-tutors">Find Tutors</a></li>
                        <li><a href="${contextPath}/student/my-bookings">My Bookings</a></li>
                        <li><a href="${contextPath}/student/profile">Profile</a></li>
                    </ul>
                </div>

                <!-- Column 3: Institutional Context -->
                <div class="footer-contact-column">
                    <h4 class="footer-col-title">CONTACT US</h4>
                    <div class="contact-details">
                        <p class="address-box">
                            <span class="address-header">Address</span>
                            SLIIT, New Kandy Road, Malabe, Colombo, Sri Lanka.
                        </p>
                        <p class="meeting-note">
                            <span style="color: var(--color-accent-teal); font-size: 16px;">ⓘ</span> Meet at the university premises
                        </p>
                    </div>
                </div>

            </div>

            <!-- Bottom Border Layout Line & Copyright -->
            <div class="footer-bottom-line">
                <p class="copyright-text">© 2026 WD204 | SLIIT | All Rights Reserved</p>
            </div>

        </div>
    </footer>

</body>
</html>
