<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% request.setAttribute("activePage", "bookings"); %>
<% request.setAttribute("pageTitle", "Bookings"); %>
<%@ include file="layout.jsp" %>

<style>
    .filter-bar     { background:#fff;padding:1rem 1.25rem;border-bottom:1px solid #f0f2f5; }
    .filter-bar .form-control,.filter-bar .form-select { font-size:0.85rem;border-radius:8px; }
    .btn-reset      { font-size:0.8rem;color:#6c757d;background:none;border:none;cursor:pointer; }
    .btn-reset:hover{ color:var(--navy2); }
    .pagination-bar { padding:0.75rem 1.25rem;background:#fff;border-top:1px solid #f0f2f5;border-radius:0 0 12px 12px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:0.5rem; }
    .page-info      { font-size:0.82rem;color:#6c757d; }
    .pagination .page-link { color:var(--navy2);border-radius:6px!important;margin:0 2px;font-size:0.83rem; }
    .pagination .page-item.active .page-link { background:var(--navy2);border-color:var(--navy2); }
    .page-size-select { font-size:0.82rem;color:#6c757d;display:flex;align-items:center;gap:6px; }
    .page-size-select select { font-size:0.82rem;border:1px solid #dee2e6;border-radius:6px;padding:2px 6px; }
    .booking-time   { font-size:0.85rem;color:#6c757d; }
    .amount-badge   { font-family: 'Segoe UI', monospace; font-weight: 600; }
</style>

<!-- Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible mb-3">
        <i class="bi bi-check-circle me-2"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible mb-3">
        <i class="bi bi-exclamation-triangle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="card">
    <div class="card-header-custom">
        <span><i class="bi bi-calendar-check me-2"></i>All Bookings</span>
        <span class="badge bg-light text-dark" id="bookingCount"></span>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-4">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="bookingSearch" class="form-control" placeholder="Search student, tutor or notes…" oninput="filterBookings()">
                </div>
            </div>
            <div class="col-sm-3">
                <select id="bookingStatusFilter" class="form-select form-select-sm" onchange="filterBookings()">
                    <option value="">All Statuses</option>
                    <option value="PENDING">⏳ Pending</option>
                    <option value="CONFIRMED">✅ Confirmed</option>
                    <option value="COMPLETED">✔️ Completed</option>
                    <option value="CANCELLED">❌ Cancelled</option>
                </select>
            </div>
            <div class="col-sm-3">
                <input type="date" id="bookingDateFilter" class="form-control form-control-sm" onchange="filterBookings()">
            </div>
            <div class="col-sm-2 text-end">
                <button class="btn-reset" onclick="resetBookingFilters()"><i class="bi bi-x-circle me-1"></i>Reset</button>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tutor</th>
                    <th>Student</th>
                    <th>Session Date & Time</th>
                    <th>Status</th>
                    <th>Amount</th>
                    <th>Notes</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="bookingTbody">
                <c:forEach var="b" items="${bookings}">
                    <tr data-tutor="${b.tutorName}" data-student="${b.studentName}" data-status="${b.status}"
                        data-date="${b.sessionDate}" data-notes="${b.notes}" data-amount="${b.totalAmount}">
                        <td><span class="fw-semibold text-muted">#${b.id}</span></td>
                        <td>
                            <div class="fw-semibold">${b.tutorName}</div>
                            <small class="text-muted">ID: ${b.tutorId}</small>
                        </td>
                        <td>
                            <div class="fw-semibold">${b.studentName}</div>
                            <small class="text-muted">ID: ${b.studentId}</small>
                        </td>
                        <td>
    <div class="fw-semibold">${b.sessionDate}</div>
    <div class="booking-time">
        <i class="bi bi-clock me-1"></i>
        ${b.startTime} – ${b.endTime}
    </div>
</td>
                        <td>
                            <c:choose>
                                <c:when test="${b.status == 'CONFIRMED'}">
                                    <span class="badge bg-success">✅ Confirmed</span>
                                </c:when>
                                <c:when test="${b.status == 'PENDING'}">
                                    <span class="badge bg-warning text-dark">⏳ Pending</span>
                                </c:when>
                                <c:when test="${b.status == 'COMPLETED'}">
                                    <span class="badge bg-info text-dark">✔️ Completed</span>
                                </c:when>
                                <c:when test="${b.status == 'CANCELLED'}">
                                    <span class="badge bg-danger">❌ Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${b.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="amount-badge">$<fmt:formatNumber value="${b.totalAmount}" pattern="#,##0.00"/></span>
                        </td>
                        <td>
                            <c:if test="${not empty b.notes}">
                                <small class="text-muted" title="${b.notes}">${b.notes}</small>
                            </c:if>
                            <c:if test="${empty b.notes}">
                                <span class="text-muted">—</span>
                            </c:if>
                        </td>
                        <td>
                            <form method="post" action="/admin/bookings/${b.id}/delete"
                                  onsubmit="return confirm('Delete this booking?')" class="d-inline">
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookings}">
                    <tr><td colspan="8" class="text-center text-muted py-4">No bookings found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="pagination-bar">
        <div class="page-info" id="bookingPageInfo"></div>
        <nav><ul class="pagination pagination-sm mb-0" id="bookingPagination"></ul></nav>
        <div class="page-size-select">Rows:
            <select id="bookingPageSize" onchange="initBookingPagination()">
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="25">25</option>
            </select>
        </div>
    </div>
</div>

<script>
let filteredBookings = [];
let currentBookingPage = 1;

function allBookingRows() { return Array.from(document.querySelectorAll('#bookingTbody tr[data-tutor]')); }
function bookingPageSize() { return parseInt(document.getElementById('bookingPageSize').value); }

function filterBookings() {
    const s = document.getElementById('bookingSearch').value.toLowerCase();
    const st = document.getElementById('bookingStatusFilter').value.toUpperCase();
    const d = document.getElementById('bookingDateFilter').value;

    filteredBookings = allBookingRows().filter(r =>
        (!s || r.dataset.tutor.toLowerCase().includes(s) ||
               r.dataset.student.toLowerCase().includes(s) ||
               (r.dataset.notes && r.dataset.notes.toLowerCase().includes(s)))
     && (!st || r.dataset.status.toUpperCase() === st)
     && (!d || r.dataset.date === d)
    );
    currentBookingPage = 1; renderBookings();
}

function resetBookingFilters() {
    document.getElementById('bookingSearch').value = '';
    document.getElementById('bookingStatusFilter').value = '';
    document.getElementById('bookingDateFilter').value = '';
    filteredBookings = []; currentBookingPage = 1; renderBookings();
}

function initBookingPagination() { currentBookingPage = 1; renderBookings(); }

function renderBookings() {
    const rows = filteredBookings.length ? filteredBookings : allBookingRows();
    const size = bookingPageSize();
    const total = rows.length;
    const pages = Math.max(1, Math.ceil(total / size));
    if (currentBookingPage > pages) currentBookingPage = pages;
    const start = (currentBookingPage - 1) * size;
    const end = Math.min(start + size, total);

    allBookingRows().forEach(r => r.style.display = 'none');
    rows.forEach((r, i) => { r.style.display = (i >= start && i < end) ? '' : 'none'; });

    document.getElementById('bookingCount').textContent = total + ' booking' + (total !== 1 ? 's' : '');
    document.getElementById('bookingPageInfo').textContent = total === 0 ? 'No results' : `Showing ${start+1}–${end} of ${total}`;

    const ul = document.getElementById('bookingPagination');
    ul.innerHTML = '';
    const mk = (label, p, disabled, active) => {
        const li = document.createElement('li');
        li.className = 'page-item' + (disabled?' disabled':'') + (active?' active':'');
        const a = document.createElement('a'); a.className = 'page-link'; a.href='#'; a.innerHTML = label;
        if (!disabled && !active) a.addEventListener('click', e => { e.preventDefault(); currentBookingPage = p; renderBookings(); });
        li.appendChild(a); return li;
    };
    ul.appendChild(mk('<i class="bi bi-chevron-left"></i>', currentBookingPage-1, currentBookingPage===1, false));
    for (let p = 1; p <= pages; p++) ul.appendChild(mk(p, p, false, p===currentBookingPage));
    ul.appendChild(mk('<i class="bi bi-chevron-right"></i>', currentBookingPage+1, currentBookingPage===pages, false));
}

renderBookings();
</script>

<%@ include file="layout-footer.jsp" %>