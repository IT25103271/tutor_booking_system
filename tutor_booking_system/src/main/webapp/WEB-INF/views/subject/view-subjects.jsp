<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "subjects"); %>
<% request.setAttribute("pageTitle", "Browse Subjects"); %>
<% request.setAttribute("pageIcon", "journal-bookmark"); %>
<%@ include file="../layout/student-layout.jsp" %>

<style>
    .subject-card {
        border: 1px solid #e8ebf0; border-radius: 16px;
        background: white; padding: 1.75rem;
        transition: all 0.25s; height: 100%;
        box-shadow: 0 1px 8px rgba(79,110,247,0.06);
    }
    .subject-card:hover {
        transform: translateY(-6px);
        box-shadow: 0 10px 32px rgba(79,110,247,0.13);
        border-color: #c7d0fb;
    }
    .subject-icon {
        width: 54px; height: 54px;
        background: var(--primary); border-radius: 14px;
        display: flex; align-items: center; justify-content: center;
        color: #fff; font-size: 1.35rem; margin-bottom: 1.1rem;
        transition: all 0.25s;
    }
    .subject-card:hover .subject-icon {
        background: var(--primary2); transform: rotate(-8deg) scale(1.08);
    }
    .subject-title { font-weight: 800; font-size: 1.1rem; margin-bottom: 0.5rem; color: #1e293b; }
    .badge-category {
        background: #f1f5f9; color: #475569; font-weight: 600;
        padding: 0.3em 0.8em; border-radius: 8px; font-size: 0.75rem;
        margin-right: 0.4rem; border: 1px solid #e2e8f0;
    }
    .badge-grade {
        background: #eef0fe; color: var(--primary);
        font-weight: 700; padding: 0.3em 0.8em; border-radius: 8px; font-size: 0.75rem;
    }
    .subject-desc { color: #64748b; font-size: 0.875rem; margin: 0.9rem 0 1.25rem; line-height: 1.6; }
    .btn-find-tutors {
        border: 1.5px solid var(--primary); color: var(--primary); background: transparent;
        border-radius: 10px; padding: 0.55rem 1.25rem; font-weight: 700;
        width: 100%; transition: all 0.25s; font-size: 0.875rem;
    }
    .btn-find-tutors:hover { background: var(--primary); color: white; box-shadow: 0 4px 14px rgba(79,110,247,0.28); }
    .count-pill {
        background: var(--primary); color: white;
        padding: 0.45rem 1.1rem; border-radius: 20px;
        font-weight: 700; font-size: 0.875rem;
        box-shadow: 0 2px 10px rgba(79,110,247,0.22);
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold" style="color:var(--primary);"><i class="bi bi-journal-bookmark me-2"></i>Available Subjects</h3>
    <span class="count-pill">
        <i class="bi bi-collection me-1"></i>
        <c:out value="${subjects.size()}" default="0"/> Subjects
    </span>
</div>

<div class="row g-4">
    <c:forEach var="subject" items="${subjects}">
        <div class="col-md-6 col-xl-4">
            <div class="subject-card">
                <div class="subject-icon">
                    <i class="bi bi-journal-text"></i>
                </div>
                <h4 class="subject-title">${subject.subjectName}</h4>
                <div class="mb-2">
                    <span class="badge-category">${subject.category}</span>
                    <span class="badge-grade">${subject.gradeLevel}</span>
                </div>
                <p class="subject-desc">${subject.description}</p>
                <a href="${pageContext.request.contextPath}/student/view-tutors?subject=${subject.subjectName}"
                   class="btn btn-find-tutors">
                    <i class="bi bi-search me-2"></i>Find Tutors
                </a>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty subjects}">
        <div class="col-12">
            <div class="text-center py-5 bg-white rounded-3 shadow-sm">
                <i class="bi bi-journal-x fs-1 text-muted mb-3 d-block"></i>
                <h5 class="fw-bold mb-2">No subjects available</h5>
                <p class="text-muted small mb-0">Please check back later.</p>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../layout/student-layout-footer.jsp" %>