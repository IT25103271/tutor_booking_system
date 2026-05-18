<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "tutors"); %>
<% request.setAttribute("pageTitle", "View Tutors"); %>
<% request.setAttribute("pageIcon", "people"); %>
<%@ include file="../layout/student-layout.jsp" %>

<style>
    .filter-banner {
        background: #eef0fe; border: 1px solid #c7d0fb;
        border-radius: 12px; padding: 0.85rem 1.25rem;
        display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.5rem;
    }
    .filter-banner i { color: var(--primary); font-size: 1.1rem; }

    .tutor-card {
        border: 1px solid #e8ebf0; border-radius: 16px;
        background: white; transition: all 0.25s;
        box-shadow: 0 1px 8px rgba(79,110,247,0.06); overflow: hidden;
    }
    .tutor-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 36px rgba(79,110,247,0.14);
        border-color: #c7d0fb;
    }
    .card-header-strip {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 60%, var(--accent) 100%);
        height: 90px; display: flex; align-items: center;
        justify-content: center; color: white; font-size: 2.25rem;
        position: relative;
    }
    .tutor-avatar {
        width: 68px; height: 68px; background: white;
        border-radius: 50%; display: flex; align-items: center;
        justify-content: center; margin: -34px auto 0;
        box-shadow: 0 4px 16px rgba(79,110,247,0.15);
        position: relative; z-index: 10;
        border: 3px solid white;
    }
    .tutor-avatar i { color: var(--primary); font-size: 1.8rem; }
    .rating-stars { color: #f59e0b; }
    .verified-badge { color: #10b981; font-size: 0.82rem; font-weight: 600; }
    .unverified-badge { color: #f59e0b; font-size: 0.82rem; font-weight: 600; }
    .info-pill {
        background: #f8faff; border: 1px solid #e8ebf0;
        border-radius: 8px; padding: 4px 10px;
        font-size: 0.78rem; color: #64748b; display: inline-flex; align-items: center; gap: 5px;
    }
    .info-pill i { color: var(--primary); }
    .btn-book {
        background: var(--primary); color: white; border: none;
        border-radius: 10px; font-weight: 700; transition: all 0.2s;
        font-size: 0.875rem; padding: 0.6rem;
        box-shadow: 0 2px 10px rgba(79,110,247,0.2);
    }
    .btn-book:hover { background: var(--primary2); color: white; box-shadow: 0 4px 18px rgba(79,110,247,0.32); }

    .empty-state { text-align: center; padding: 4rem 2rem; background: #fff; border-radius: 14px; border: 1px solid #e8ebf0; }
    .empty-icon { width: 72px; height: 72px; background: #eef0fe; border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2rem; color: var(--primary); margin: 0 auto 1.25rem; }
</style>

<div class="d-flex align-items-center justify-content-between mb-4">
    <h3 class="fw-bold" style="color:var(--primary);"><i class="bi bi-people me-2"></i>Available Tutors</h3>
</div>

<!-- Filter Banner -->
<c:if test="${not empty selectedSubject}">
    <div class="filter-banner">
        <i class="bi bi-funnel-fill"></i>
        <div>
            <strong style="color:var(--primary);">Filtered by:</strong>
            <span style="color:var(--primary);font-weight:600;margin-left:6px;">${selectedSubject.subjectName}</span>
            <span class="badge ms-2" style="background:var(--primary);font-size:0.72rem;">${tutors.size()} tutor(s)</span>
            <a href="${pageContext.request.contextPath}/student/view-tutors" class="ms-3 text-decoration-none" style="color:#64748b;font-size:0.85rem;">
                <i class="bi bi-x-circle me-1"></i>Clear filter
            </a>
        </div>
    </div>
</c:if>

<div class="row g-4">
    <c:forEach var="tutor" items="${tutors}">
        <div class="col-md-6 col-xl-4">
            <div class="tutor-card h-100">
                <div class="card-header-strip">
                    <i class="bi bi-person-workspace"></i>
                </div>
                <div class="tutor-avatar">
                    <i class="bi bi-person-fill"></i>
                </div>
                <div class="card-body text-center pt-2 pb-3 px-3">
                    <h5 class="fw-bold mb-1" style="color:#1e293b;">${tutor.name}</h5>
                    <p class="mb-2" style="color:var(--primary);font-weight:600;font-size:0.88rem;">${tutor.subject}</p>

                    <div class="mb-2">
                        <span class="rating-stars">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="bi bi-star${i <= tutor.rating.intValue() ? '-fill' : ''}"></i>
                            </c:forEach>
                        </span>
                        <small class="text-muted ms-1">(${tutor.rating})</small>
                    </div>

                    <p class="text-muted small mb-3">
                        <i class="bi bi-mortarboard me-1 text-primary"></i>${tutor.qualification}
                    </p>

                    <div class="d-flex justify-content-center gap-2 mb-3 flex-wrap">
                        <span class="info-pill"><i class="bi bi-cash-stack"></i>Rs. ${tutor.hourlyRate}/hr</span>
                        <span class="info-pill"><i class="bi bi-geo-alt"></i>${tutor.location}</span>
                    </div>

                    <p class="text-muted small mb-3" style="height:38px;overflow:hidden;">"${tutor.bio}"</p>

                    <c:choose>
                        <c:when test="${tutor.verified}">
                            <span class="verified-badge d-block mb-2">
                                <i class="bi bi-patch-check-fill me-1"></i>Verified Tutor
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="unverified-badge d-block mb-2">
                                <i class="bi bi-clock me-1"></i>Pending Verification
                            </span>
                        </c:otherwise>
                    </c:choose>

                    <a href="${pageContext.request.contextPath}/student/book-tutor?id=${tutor.id}&subjectId=${selectedSubject.id}"
                       class="btn btn-book w-100">
                        <i class="bi bi-calendar-plus me-2"></i>Book Now
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty tutors}">
        <div class="col-12">
            <div class="empty-state">
                <div class="empty-icon"><i class="bi bi-people"></i></div>
                <h5 class="fw-bold mb-2">No tutors available for this subject</h5>
                <p class="text-muted small mb-3">Try browsing other subjects to find a tutor.</p>
                <a href="${pageContext.request.contextPath}/student/view-subjects"
                   class="btn btn-primary-soft">
                    Browse Other Subjects
                </a>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../layout/student-layout-footer.jsp" %>