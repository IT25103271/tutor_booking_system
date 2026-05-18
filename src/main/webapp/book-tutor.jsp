<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "tutors"); %>
<% request.setAttribute("pageTitle", "Book a Session"); %>
<% request.setAttribute("pageIcon", "calendar-plus"); %>
<%@ include file="../layout/student-layout.jsp" %>

<style>
    .tutor-panel {
        background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 60%, var(--accent) 100%);
        color: white; border-radius: 16px; padding: 2rem; text-align: center;
        box-shadow: 0 8px 28px rgba(79,110,247,0.22);
    }
    .tutor-panel-icon { font-size: 4rem; opacity: 0.9; margin-bottom: 1rem; }
    .tutor-panel h4 { font-weight: 800; margin-bottom: 0.5rem; }
    .tutor-panel-info { font-size: 0.87rem; opacity: 0.88; display: flex; align-items: center; justify-content: center; gap: 6px; margin-bottom: 6px; }
    .info-chip {
        background: rgba(255,255,255,0.18); border-radius: 8px;
        padding: 0.6rem 1rem; font-size: 0.82rem; font-weight: 600;
        display: flex; align-items: center; gap: 6px;
        margin-top: 0.75rem;
    }

    .booking-form-card {
        border: 1px solid #e8ebf0; border-radius: 16px; background: white;
        box-shadow: 0 1px 8px rgba(79,110,247,0.06);
    }

    .schedule-slot {
        border: 1.5px solid #e8ebf0; border-radius: 12px;
        padding: 0.9rem; cursor: pointer; transition: all 0.2s; text-align: center;
        background: #fafbff;
    }
    .schedule-slot:hover { border-color: var(--primary); background: #eef0fe; }
    .schedule-slot.selected { border-color: var(--primary); background: #eef0fe; }
    .schedule-slot input[type="radio"] { display: none; }
    .schedule-slot .slot-date { font-weight: 700; color: var(--primary); font-size: 0.88rem; }
    .schedule-slot .slot-time { font-size: 0.8rem; color: #64748b; margin-top: 2px; }

    .form-label { font-weight: 600; color: #475569; font-size: 0.85rem; margin-bottom: 7px; }
    .form-control {
        border-radius: 11px; padding: 11px 14px;
        border: 1px solid #dde3f0; background: #f8faff; font-size: 0.9rem;
        transition: all 0.25s;
    }
    .form-control:focus {
        border-color: var(--primary); background: #fff;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.12);
    }

    .btn-confirm {
        background: linear-gradient(135deg, var(--primary), var(--primary2));
        color: white; border: none; border-radius: 11px;
        font-weight: 700; padding: 0.7rem 1.75rem; transition: all 0.25s;
        box-shadow: 0 4px 14px rgba(79,110,247,0.26);
    }
    .btn-confirm:hover {
        background: linear-gradient(135deg, var(--primary2), #2d4ad0);
        color: white; transform: translateY(-2px);
    }
    .btn-back { border: 1px solid #dde3f0; color: #64748b; border-radius: 10px; font-size: 0.85rem; padding: 0.5rem 1rem; transition: all 0.2s; background: #fff; }
    .btn-back:hover { background: #f1f4ff; border-color: var(--primary); color: var(--primary); }
</style>

<h3 class="fw-bold" style="color:var(--primary);margin-bottom:1.5rem;">
    <i class="bi bi-calendar-plus me-2"></i>Book a Session
</h3>

<div class="row g-4">
    <!-- Tutor Info Panel -->
    <div class="col-md-4">
        <div class="tutor-panel">
            <div class="tutor-panel-icon"><i class="bi bi-person-circle"></i></div>
            <h4>${tutor.name}</h4>
            <div class="info-chip"><i class="bi bi-journal-bookmark"></i>${tutor.subject}</div>
            <div class="info-chip"><i class="bi bi-cash-stack"></i>Rs. ${tutor.hourlyRate}/hr</div>
            <div class="info-chip"><i class="bi bi-geo-alt"></i>${tutor.location}</div>
        </div>
    </div>

    <!-- Booking Form -->
    <div class="col-md-8">
        <div class="booking-form-card p-4">
            <h6 class="fw-bold mb-3" style="color:#1e293b;">
                <i class="bi bi-clock-history me-2 text-primary"></i>Select a Time Slot
            </h6>

            <c:if test="${empty schedules}">
                <div class="alert" style="background:#fff7ed;color:#92400e;border-radius:12px;border:none;">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    No available time slots for this tutor. Please check back later.
                </div>
            </c:if>

            <c:if test="${not empty schedules}">
                <form action="${pageContext.request.contextPath}/student/book-tutor" method="post">
                    <input type="hidden" name="tutorId" value="${tutor.id}">
                    <input type="hidden" name="subjectId" value="${subject.id}">

                    <div class="row g-3 mb-4">
                        <c:forEach var="schedule" items="${schedules}">
                            <div class="col-6 col-md-4">
                                <label class="schedule-slot w-100">
                                    <input type="radio" name="scheduleId" value="${schedule.scheduleId}" required>
                                    <div class="slot-date">${schedule.availableDate}</div>
                                    <div class="slot-time">${schedule.timeSlot}</div>
                                </label>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Additional Notes (Optional)</label>
                        <textarea name="notes" class="form-control" rows="3"
                                  placeholder="Any specific topics you want to cover..."></textarea>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/student/view-tutors?subject=${tutor.subject}"
                           class="btn btn-back text-decoration-none">
                            <i class="bi bi-arrow-left me-1"></i>Back
                        </a>
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted small">
                                <i class="bi bi-info-circle me-1"></i>Tutor will confirm your booking
                            </span>
                            <button type="submit" class="btn btn-confirm">
                                <i class="bi bi-calendar-check me-2"></i>Confirm Booking
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>

            <c:if test="${empty schedules}">
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/student/view-tutors?subject=${tutor.subject}"
                       class="btn btn-back text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i>Back to Tutors
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.schedule-slot').forEach(slot => {
        slot.addEventListener('click', function() {
            document.querySelectorAll('.schedule-slot').forEach(s => s.classList.remove('selected'));
            this.classList.add('selected');
            this.querySelector('input[type="radio"]').checked = true;
        });
    });
</script>

<%@ include file="../layout/student-layout-footer.jsp" %>