<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor Reviews</title>
    
    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Arial,sans-serif}
        body{background:#f2f4f8;color:#0b1b2d}
        .navbar{height:72px;background:#0d1b2a;color:white;display:flex;align-items:center;justify-content:space-between;padding:0 34px;box-shadow:0 4px 18px rgba(0,0,0,.15)}
        .logo{font-size:27px;font-weight:900;letter-spacing:-1px;display:flex;gap:12px;align-items:center}
        .logo-mark{width:34px;height:26px;border-radius:8px;background:#08c8e8;color:#0d1b2a;display:grid;place-items:center;font-weight:900;font-size:14px}
        .nav-right{display:flex;align-items:center;gap:20px;font-weight:700}
        .nav-dot{width:34px;height:34px;border-radius:50%;background:#17273b;display:grid;place-items:center;color:#08c8e8;font-weight:900}
        .logout{border:1px solid rgba(255,255,255,.75);padding:9px 19px;border-radius:22px;color:white;text-decoration:none}
        .layout{display:grid;grid-template-columns:265px 1fr;gap:32px;max-width:1320px;margin:42px auto 90px;padding:0 18px}
        .sidebar{background:white;border-radius:15px;box-shadow:0 8px 24px rgba(10,30,50,.09);overflow:hidden;height:max-content}
        .side-item{display:flex;align-items:center;gap:14px;padding:22px 24px;border-bottom:1px solid #e9edf2;color:#51687b;text-decoration:none;font-size:18px}
        .side-ico{width:28px;height:28px;border-radius:8px;border:2px solid #8aa0b5;display:grid;place-items:center;font-size:12px;font-weight:900}
        .side-item.active{background:#0d1b2a;color:white;border-left:5px solid #09c6e8;font-weight:800}
        .side-item.active .side-ico{border-color:white;color:white}
        .content{min-width:0}
        .hero{background:linear-gradient(135deg,#071827,#142239);border-radius:14px;padding:38px 42px;color:white;box-shadow:0 22px 45px rgba(11,27,45,.22);margin-bottom:30px}
        .hero-small{color:#9ba8b8;font-size:15px;margin-bottom:8px}
        .hero h1{font-size:40px;line-height:1.1;margin-bottom:12px}
        .badge{display:inline-flex;align-items:center;gap:7px;background:#08bfdc;color:white;border-radius:30px;padding:8px 18px;font-weight:800;font-size:13px;margin-top:5px}
        .stats{display:grid;grid-template-columns:repeat(3,1fr);gap:18px;margin-bottom:28px}
        .stat{background:white;border-radius:15px;padding:24px 27px;display:flex;align-items:center;gap:18px;box-shadow:0 8px 22px rgba(10,30,50,.08);border-top:5px solid #08c8e8}
        .stat.green{border-top-color:#1c9562}.stat.gold{border-top-color:#f3bb29}
        .stat-icon{width:48px;height:48px;border-radius:13px;background:#e9faff;color:#08b8d6;display:grid;place-items:center;font-size:17px;font-weight:900}
        .stat.green .stat-icon{background:#eaf8f1;color:#168756}.stat.gold .stat-icon{background:#fff8df;color:#d29a00}
        .stat strong{font-size:25px}.stat span{display:block;color:#71808f;font-size:13px;font-weight:800;letter-spacing:1px;margin-top:4px}
        .panel{background:white;border-radius:15px;box-shadow:0 8px 22px rgba(10,30,50,.08);padding:30px}
        .panel-title{display:flex;align-items:center;justify-content:space-between;margin-bottom:24px}
        .panel-title h2{font-size:29px}
        .btn{border:0;background:#0d1b2a;color:white;text-decoration:none;border-radius:8px;padding:13px 22px;font-size:15px;font-weight:800;cursor:pointer;display:inline-block}
        .btn:hover{background:#09c6e8}
        .form-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
        .form-group.full{grid-column:1/-1}
        label{display:block;margin-bottom:9px;color:#6b7785;font-weight:800;text-transform:uppercase;font-size:12px;letter-spacing:.7px}
        input,select,textarea{width:100%;padding:15px 16px;border:1px solid #dbe2ea;border-radius:12px;font-size:15px;background:#fff;outline:none}
        input:focus,select:focus,textarea:focus{border-color:#08c8e8;box-shadow:0 0 0 3px rgba(8,200,232,.14)}
        textarea{resize:none}
        .actions{display:flex;gap:13px;margin-top:24px}
        .btn-light{background:#eef5f8;color:#0d1b2a}
        .review-card{border:1px solid #e7edf3;border-left:5px solid #08c8e8;border-radius:14px;padding:22px;margin-bottom:17px;box-shadow:0 5px 16px rgba(10,30,50,.05)}
        .review-top{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}
        .review-name{font-size:20px;font-weight:900}
        .stars{color:#f6ae00;font-size:22px;letter-spacing:2px}
        .comment{color:#5c6875;line-height:1.7}
        .empty{text-align:center;padding:55px;color:#687787}
        .empty-icon{width:58px;height:58px;border:3px solid #687787;border-radius:14px;display:grid;place-items:center;margin:0 auto 14px;font-size:24px;font-weight:900}
        .footer{background:#0d1b2a;color:white;border-top:4px solid #08c8e8;padding:45px 90px}
        .footer-grid{display:grid;grid-template-columns:1.5fr 1fr 1.6fr;gap:45px;max-width:1250px;margin:auto}
        .footer h3{margin-bottom:17px}.footer p,.footer a{color:#9faebe;text-decoration:none;display:block;margin-bottom:9px}
        @media(max-width:900px){.layout{grid-template-columns:1fr}.stats{grid-template-columns:1fr}.form-grid{grid-template-columns:1fr}.footer-grid{grid-template-columns:1fr}.navbar{padding:0 18px}.nav-right span{display:none}}
    </style>

</head>
<body>

<div class="navbar">
    <div class="logo"><span class="logo-mark">TB</span> Tutor Booking</div>
    <div class="nav-right">
        <span class="nav-dot">N</span>
        <span>Testing</span>
        <a class="logout" href="#">Logout</a>
    </div>
</div>

<div class="layout">
    <div class="sidebar">
        <a class="side-item" href="#"><span class="side-ico">D</span> Dashboard</a>
        <a class="side-item" href="#"><span class="side-ico">S</span> View Tutors</a>
        <a class="side-item" href="#"><span class="side-ico">B</span> My Bookings</a>
        <a class="side-item active" href="/reviews/tutor/${tutorId}"><span class="side-ico">R</span> Reviews</a>
    </div>

    <div class="content">
        <div class="hero">
            <div class="hero-small">Welcome back,</div>
            <h1>Tutor Reviews</h1>
            <span class="badge">STUDENT FEEDBACK</span>
        </div>

        <div class="stats">
            <div class="stat">
                <div class="stat-icon">REV</div>
                <div><strong>${reviews.size()}</strong><span>TOTAL REVIEWS</span></div>
            </div>
            <div class="stat green">
                <div class="stat-icon">ON</div>
                <div><strong>Active</strong><span>REVIEW PAGE</span></div>
            </div>
            <div class="stat gold">
                <div class="stat-icon">5</div>
                <div><strong>5</strong><span>MAX RATING</span></div>
            </div>
        </div>

        <div class="panel">
            <div class="panel-title">
                <h2>Review List</h2>
                <a class="btn" href="/reviews/add?tutorId=${tutorId}">Add Review</a>
            </div>

            <c:if test="${empty reviews}">
                <div class="empty">
                    <div class="empty-icon">R</div>
                    <h3>No reviews yet</h3>
                    <p>Be the first student to add a tutor review.</p>
                    <br>
                    <a class="btn" href="/reviews/add?tutorId=${tutorId}">Add First Review</a>
                </div>
            </c:if>

            <c:forEach var="review" items="${reviews}">
                <div class="review-card">
                    <div class="review-top">
                        <div class="review-name">${review.studentName}</div>
                        <div class="stars">
                            <c:choose>
                                <c:when test="${review.rating == 5}">★★★★★</c:when>
                                <c:when test="${review.rating == 4}">★★★★☆</c:when>
                                <c:when test="${review.rating == 3}">★★★☆☆</c:when>
                                <c:when test="${review.rating == 2}">★★☆☆☆</c:when>
                                <c:otherwise>★☆☆☆☆</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <p class="comment">${review.comment}</p>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="footer">
    <div class="footer-grid">
        <div>
            <h3>Tutor Booking</h3>
            <p>This is an academic project developed for SE1020 - OOP Module at SLIIT by Group WD204</p>
        </div>
        <div>
            <h3>Quick Links</h3>
            <a href="#">Dashboard</a>
            <a href="#">Find Tutors</a>
            <a href="#">My Bookings</a>
            <a href="/reviews/tutor/${tutorId}">Reviews</a>
        </div>
        <div>
            <h3>Contact Us</h3>
            <p>SLIIT, New Kandy Road, Malabe, Colombo, Sri Lanka</p>
            <p>Meet at the university premises</p>
        </div>
    </div>
</div>

</body>
</html>
