<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setAttribute("activePage", "schedule"); %>
<% request.setAttribute("pageTitle", "Manage Availability"); %>
<% request.setAttribute("pageIcon", "calendar-week"); %>
<%@ include file="../layout/tutor_layout.jsp" %>

<style>
    .schedule-card {
        background: #fff;
        border-radius: 12px;
        border: 1px solid #f0f2f5;
        box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        padding: 1.5rem;
        height: 100%;
    }

    .form-label-custom {
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: #6c757d;
        margin-bottom: 0.5rem;
    }

    .form-control-custom {
        border-radius: 10px;
        border: 1px solid #e2e8f0;
        padding: 0.75rem 1rem;
        font-size: 0.9rem;
        background: #f8fafc;
    }

    .form-control-custom:focus {
        border-color: var(--accent);
        box-shadow: 0 0 0 3px rgba(0, 180, 216, 0.1);
        background: #fff;
    }

    .btn-primary-custom {
        background: var(--navy);
        border: none;
        border-radius: 10px;
        padding: 0.75rem 1.5rem;
        font-size: 0.9rem;
        font-weight: 600;
        width: 100%;
        color: #fff;
        transition: all 0.25s;
    }

    .btn-primary-custom:hover {
        background: var(--navy2);
        transform: translateY(-2px);
    }

    .slot-card {
        background: #fff;
        border-radius: 10px;
        border: 1px solid #f0f2f5;
        padding: 1rem 1.25rem;
        margin-bottom: 0.75rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: all 0.2s;
    }

    .slot-card:hover {
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .slot-info {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .slot-date {
        background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
        border-radius: 10px;
        padding: 0.5rem 0.75rem;
        text-align: center;
        min-width: 60px;
        color: #fff;
    }

    .slot-date .day {
        font-size: 1.25rem;
        font-weight: 700;
        line-height: 1;
    }

    .slot-date .month {
        font-size: 0.7rem;
        text-transform: uppercase;
        opacity: 0.9;
    }

    .slot-time {
        font-weight: 600;
        color: var(--navy);
        font-size: 0.95rem;
    }

    .slot-status {
        font-size: 0.75rem;
        padding: 0.35rem 0.75rem;
        border-radius: 20px;
        font-weight: 500;
    }

    .status-available {
        background: #d1fae5;
        color: #065f46;
    }

    .empty-state {
        text-align: center;
        padding: 3rem 1rem;
        color: #9ca3af;
    }

    .empty-state i {
        font-size: 3rem;
        margin-bottom: 1rem;
        display: block;
        color: #e5e7eb;
    }

    .delete-btn {
        background: #fef2f2;
        border: none;
        color: #ef4444;
        cursor: pointer;
        padding: 0.5rem;
        border-radius: 8px;
        transition: all 0.2s;
    }

    .delete-btn:hover {
        background: #fecaca;
    }
</style>

<div class="row g-4">
    <!-- Add Slot Form -->
    <div class="col-lg-4">
        <div class="schedule-card">
            <h5 class="fw-bold mb-4" style="color: var(--navy);">
                <i class="bi bi-plus-circle-fill me-2 text-danger"></i> Add New Time Slot
            </h5>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 border-0 small py-2 mb-3">${error}</div>
            </c:if>
            <c:if test="${param.added}">
                <div class="alert alert-success rounded-3 border-0 small py-2 mb-3">
                    <i class="bi bi-check-circle me-1"></i>Schedule added successfully!
                </div>
            </c:if>
            <c:if test="${param.deleted}">
                <div class="alert alert-info rounded-3 border-0 small py-2 mb-3">
                    <i class="bi bi-trash me-1"></i>Schedule removed.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/tutor/addSchedule" method="post">
                <div class="mb-3">
                    <label class="form-label-custom">Date</label>
                    <input type="date" name="availableDate" class="form-control-custom"
                           required
                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                </div>
                <div class="mb-4">
                    <label class="form-label-custom">Time Slot</label>
                    <select name="timeSlot" class="form-control-custom" required>
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
                <button type="submit" class="btn-primary-custom">
                    <i class="bi bi-calendar-plus me-2"></i>Add to Schedule
                </button>
            </form>
        </div>
    </div>

    <!-- Schedule List -->
    <div class="col-lg-8">
        <div class="schedule-card">
            <h5 class="fw-bold mb-4" style="color: var(--navy);">
                <i class="bi bi-calendar-check-fill me-2 text-danger"></i> Your Scheduled Availability
            </h5>

            <c:choose>
                <c:when test="${not empty schedules}">
                    <c:forEach items="${schedules}" var="sch">
                        <div class="slot-card">
                            <div class="slot-info">
                                <div class="slot-date">
                                    <div class="day">
                                        ${fn:substring(sch.availableDate, 8, 10)}
                                    </div>
                                    <div class="month">
                                        <c:set var="monthNum" value="${fn:substring(sch.availableDate, 5, 7)}" />
                                        <c:choose>
                                            <c:when test="${monthNum == '01'}">JAN</c:when>
                                            <c:when test="${monthNum == '02'}">FEB</c:when>
                                            <c:when test="${monthNum == '03'}">MAR</c:when>
                                            <c:when test="${monthNum == '04'}">APR</c:when>
                                            <c:when test="${monthNum == '05'}">MAY</c:when>
                                            <c:when test="${monthNum == '06'}">JUN</c:when>
                                            <c:when test="${monthNum == '07'}">JUL</c:when>
                                            <c:when test="${monthNum == '08'}">AUG</c:when>
                                            <c:when test="${monthNum == '09'}">SEP</c:when>
                                            <c:when test="${monthNum == '10'}">OCT</c:when>
                                            <c:when test="${monthNum == '11'}">NOV</c:when>
                                            <c:when test="${monthNum == '12'}">DEC</c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <div>
                                    <div class="slot-time">
                                        <i class="bi bi-clock me-1 text-muted"></i>${sch.timeSlot}
                                    </div>
                                    <div class="mt-1">
                                        <span class="slot-status status-available">Available</span>
                                    </div>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/tutor/deleteSchedule" method="post"
                                  onsubmit="return confirm('Remove this slot?');">
                                <input type="hidden" name="scheduleId" value="${sch.scheduleId}">
                                <button type="submit" class="delete-btn" title="Remove slot">
                                    <i class="bi bi-trash3"></i>
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-calendar-x"></i>
                        <h6 class="text-muted">No Availability Slots Yet</h6>
                        <p class="small text-muted">Use the form on the left to add your first time slot.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="../layout/tutor_layout-footer.jsp" %>