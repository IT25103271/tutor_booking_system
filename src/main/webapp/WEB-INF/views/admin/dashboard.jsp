<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #1a1a2e, #0f3460); padding: 1rem 2rem; }
        .navbar-brand { color: #fff; font-weight: 700; font-size: 1.3rem; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); }
        .card-header-custom { background: linear-gradient(135deg, #1a1a2e, #0f3460); color: #fff; padding: 1rem 1.5rem; border-radius: 12px 12px 0 0; font-weight: 600; }
        .stat-card { border-left: 4px solid #0f3460; }
        .stat-number { font-size: 2rem; font-weight: 700; color: #0f3460; }
        .badge-verified { background: #d4edda; color: #155724; }
        .badge-pending { background: #fff3cd; color: #856404; }
        .star-filled { color: #ffc107; }
        .section-title { color: #1a1a2e; font-weight: 700; border-left: 4px solid #0f3460; padding-left: 10px; margin: 2rem 0 1rem; }
        .table th { background: #f8f9fa; color: #1a1a2e; font-weight: 600; }
        .profile-avatar { width: 45px; height: 45px; background: #0f3460; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; font-weight: 700; font-size: 1.1rem; }
    </style>
</head>
<body>


<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <span class="navbar-brand"><i class="bi bi-shield-check me-2"></i>Admin Panel</span>
    <div class="ms-auto d-flex align-items-center gap-2">

        <!-- Account Dropdown -->
        <div class="dropdown">
            <a href="#" class="text-white text-decoration-none dropdown-toggle" id="accountDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i>${sessionScope.adminName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="accountDropdown">
                <li><a class="dropdown-item" href="/admin/edit"><i class="bi bi-pencil-square me-2"></i>Edit Profile</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="/admin/delete" onclick="return confirm('Are you sure you want to delete your account? This cannot be undone.')"><i class="bi bi-trash me-2"></i>Delete Account</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="/admin/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
            </ul>
        </div>

    </div>
</nav>

<div class="container-fluid py-4 px-4">

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible">
            <i class="bi bi-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Stats Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Tutors</div>
                        <div class="stat-number">${totalTutors}</div>
                        <div class="text-warning small">${pendingTutors} pending approval</div>
                    </div>
                    <i class="bi bi-person-badge" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Students</div>
                        <div class="stat-number">${totalStudents}</div>
                        <div class="text-muted small">Registered students</div>
                    </div>
                    <i class="bi bi-mortarboard" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Bookings</div>
                        <div class="stat-number">${totalBookings}</div>
                        <div class="text-muted small">All sessions</div>
                    </div>
                    <i class="bi bi-calendar-check" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Reviews</div>
                        <div class="stat-number">${totalReviews}</div>
                        <div class="text-muted small">All reviews</div>
                    </div>
                    <i class="bi bi-star" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Tutor Approval Section -->
    <h5 class="section-title"><i class="bi bi-patch-check me-2"></i>Tutor Approval</h5>
    <div class="card mb-4">
        <div class="card-header-custom">
            <i class="bi bi-people me-2"></i>All Tutors
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Tutor</th>
                        <th>Subject</th>
                        <th>Qualification</th>
                        <th>Location</th>
                        <th>Rate</th>
                        <th>Rating</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="t" items="${tutors}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="profile-avatar">${t.name.charAt(0)}</div>
                                    <div>
                                        <div class="fw-semibold">${t.name}</div>
                                        <small class="text-muted">${t.email}</small>
                                    </div>
                                </div>
                            </td>
                            <td><span class="badge bg-primary">${t.subject}</span></td>
                            <td>${t.qualification}</td>
                            <td>${t.location}</td>
                            <td class="fw-bold text-success">$${t.hourlyRate}/hr</td>
                            <td>
                                <i class="bi bi-star-fill star-filled"></i>
                                    ${t.rating} (${t.reviewCount})
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.verified}">
                                        <span class="badge badge-verified">
                                            <i class="bi bi-patch-check-fill"></i> Verified
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-pending">Pending</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${!t.verified}">
                                    <form method="post" action="/admin/tutors/${t.id}/verify">
                                        <button class="btn btn-sm btn-success">
                                            <i class="bi bi-check-lg"></i> Verify
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${t.verified}">
                                    <span class="text-muted small">✓ Verified</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty tutors}">
                        <tr><td colspan="8" class="text-center text-muted py-4">No tutors found.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Students Section -->
    <h5 class="section-title"><i class="bi bi-mortarboard me-2"></i>Students</h5>
    <div class="card mb-4">
        <div class="card-header-custom">
            <i class="bi bi-people me-2"></i>All Students
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Student</th>
                        <th>Phone</th>
                        <th>Grade Level</th>
                        <th>Subjects</th>
                        <th>Membership</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="s" items="${students}">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="profile-avatar">${s.name.charAt(0)}</div>
                                    <div>
                                        <div class="fw-semibold">${s.name}</div>
                                        <small class="text-muted">${s.email}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${s.phone}</td>
                            <td>${s.gradeLevel}</td>
                            <td>${s.subjectsNeeded}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${s.membershipType == 'PREMIUM'}">
                                        <span class="badge bg-warning text-dark">⭐ Premium</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Regular</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty students}">
                        <tr><td colspan="5" class="text-center text-muted py-4">No students found.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Reviews Section -->
    <h5 class="section-title"><i class="bi bi-star me-2"></i>Reviews</h5>
    <div class="card mb-4">
        <div class="card-header-custom">
            <i class="bi bi-chat-left-text me-2"></i>All Reviews
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Tutor</th>
                        <th>Student</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="r" items="${reviews}">
                        <tr>
                            <td class="fw-semibold">${r.tutorName}</td>
                            <td>${r.studentName}</td>
                            <td>
                                <c:forEach begin="1" end="${r.rating}" var="i">
                                    <i class="bi bi-star-fill star-filled"></i>
                                </c:forEach>
                                (${r.rating})
                            </td>
                            <td><small>${r.comment}</small></td>
                            <td><small>${r.date}</small></td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.approved}">
                                        <span class="badge bg-success">Approved</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">Hidden</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form method="post" action="/admin/reviews/${r.id}/delete"
                                      onsubmit="return confirm('Delete this review?')">
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty reviews}">
                        <tr><td colspan="7" class="text-center text-muted py-4">No reviews found.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
