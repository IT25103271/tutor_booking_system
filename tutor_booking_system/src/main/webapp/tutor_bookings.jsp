<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "bookings"); %>
<% request.setAttribute("pageTitle", "Bookings"); %>
<% request.setAttribute("pageIcon", "calendar-check"); %>
<%@ include file="../layout/tutor_layout.jsp" %>

<!-- Filter Tabs -->
<ul class="nav nav-pills mb-3">
    <li class="nav-item">
        <a href="/tutor/bookings" class="nav-link ${empty selectedStatus ? 'active' : ''}">All</a>
    </li>
    <li class="nav-item">
        <a href="/tutor/bookings?status=PENDING"
           class="nav-link ${selectedStatus == 'PENDING' ? 'active' : ''}">Pending</a>
    </li>
    <li class="nav-item">
        <a href="/tutor/bookings?status=CONFIRMED"
           class="nav-link ${selectedStatus == 'CONFIRMED' ? 'active' : ''}">Confirmed</a>
    </li>
    <li class="nav-item">
        <a href="/tutor/bookings?status=COMPLETED"
           class="nav-link ${selectedStatus == 'COMPLETED' ? 'active' : ''}">Completed</a>
    </li>
    <li class="nav-item">
        <a href="/tutor/bookings?status=CANCELLED"
           class="nav-link ${selectedStatus == 'CANCELLED' ? 'active' : ''}">Cancelled</a>
    </li>
</ul>

<!-- Bookings Table -->
<div class="card border-0 shadow-sm rounded-3">
    <div class="card-header-custom d-flex justify-content-between align-items-center">
        <span><i class="bi bi-list-check me-2"></i>Booking List</span>
        <span class="badge bg-navy">${bookings.size()} found</span>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Student</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Notes</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th style="min-width: 200px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bookings}">
                    <tr>
                        <td class="text-muted small">${b.id}</td>
                        <td>
                            <div class="fw-semibold">${b.studentName}</div>
                        </td>
                        <td>${b.sessionDate}</td>
                        <td class="small text-nowrap">${b.startTime} – ${b.endTime}</td>
                        <td class="small text-muted">${not empty b.notes ? b.notes : '—'}</td>
                        <td class="fw-semibold">LKR ${b.totalAmount}</td>
                        <td>
                            <span class="badge badge-${b.status} px-2 py-1 rounded-pill">${b.status}</span>
                        </td>
                        <td>
                            <div class="d-flex gap-1 flex-nowrap">
                                <%-- PENDING: Accept + Cancel --%>
                                <c:if test="${b.status == 'PENDING'}">
                                    <form action="/tutor/bookings/${b.id}/accept" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-sm btn-navy"
                                                onclick="return confirm('Accept this booking request?')">
                                            <i class="bi bi-check-lg me-1"></i>Confirm
                                        </button>
                                    </form>
                                    <form action="/tutor/bookings/${b.id}/cancel" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                                onclick="return confirm('Cancel this booking? This cannot be undone.')">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </form>
                                </c:if>

                                <%-- CONFIRMED: Complete + Cancel --%>
                                <c:if test="${b.status == 'CONFIRMED'}">
                                    <form action="/tutor/bookings/${b.id}/complete" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-sm btn-success"
                                                onclick="return confirm('Mark this session as completed?')">
                                            <i class="bi bi-check2-all me-1"></i>Complete
                                        </button>
                                    </form>
                                    <form action="/tutor/bookings/${b.id}/cancel" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"
                                                onclick="return confirm('Cancel this confirmed booking?')">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </form>
                                </c:if>

                                <%-- COMPLETED: No actions --%>
                                <c:if test="${b.status == 'COMPLETED'}">
                                    <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Done</span>
                                </c:if>

                                <%-- CANCELLED: No actions --%>
                                <c:if test="${b.status == 'CANCELLED'}">
                                    <span class="badge bg-secondary"><i class="bi bi-x-circle me-1"></i>Cancelled</span>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                    </c:forEach>

                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-5">
                                <i class="bi bi-calendar-x fs-3 d-block mb-2"></i>
                                <p class="mb-0">No bookings found for the selected filter.</p>
                                <a href="/tutor/bookings" class="btn btn-sm btn-navy mt-2">View All</a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Status Legend -->
<div class="mt-3 p-3 bg-white rounded-3 shadow-sm">
    <small class="text-muted fw-semibold"><i class="bi bi-info-circle me-2"></i>Status Guide:</small>
    <div class="d-flex gap-3 mt-2">
        <span class="badge badge-PENDING">PENDING</span> – Awaiting your confirmation
        <span class="badge badge-CONFIRMED">CONFIRMED</span> – Upcoming session
        <span class="badge badge-COMPLETED">COMPLETED</span> – Session finished
        <span class="badge badge-CANCELLED">CANCELLED</span> – Cancelled
    </div>
</div>

<%@ include file="../layout/tutor_layout-footer.jsp" %>