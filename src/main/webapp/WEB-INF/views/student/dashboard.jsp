<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("pageTitle", "Dashboard"); %>
<% request.setAttribute("pageIcon", "speedometer2"); %>

<%@ include file="../layout/student-layout.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<!-- ── Stat Cards ── -->
<div class="row g-3 mb-2">
    <div class="col-sm-6 col-xl-3">
        <a href="${pageContext.request.contextPath}/student/my-bookings" class="text-decoration-none">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Bookings</div>
                        <div class="stat-number">${totalBookings != null ? totalBookings : '—'}</div>
                        <div class="text-muted small">All sessions</div>
                    </div>
                    <i class="bi bi-calendar3" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="${pageContext.request.contextPath}/student/my-bookings" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--warning);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Pending</div>
                        <div class="stat-number" style="color: var(--warning);">${pendingCount != null ? pendingCount : '—'}</div>
                        <div class="text-warning small">Awaiting action</div>
                    </div>
                    <i class="bi bi-hourglass-split" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="${pageContext.request.contextPath}/student/my-bookings" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--accent);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Confirmed</div>
                        <div class="stat-number" style="color: var(--accent);">${confirmedCount != null ? confirmedCount : '—'}</div>
                        <div class="text-info small">Upcoming</div>
                    </div>
                    <i class="bi bi-check2-circle" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="${pageContext.request.contextPath}/student/my-bookings" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--success);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Completed</div>
                        <div class="stat-number" style="color: var(--success);">${completedCount != null ? completedCount : '—'}</div>
                        <div class="text-success small">Done</div>
                    </div>
                    <i class="bi bi-trophy" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
</div>

<!-- ── Charts ── -->
<h6 class="section-title"><i class="bi bi-bar-chart-line me-2"></i>Booking Analytics</h6>
<div class="row g-3 mb-4">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-pie-chart me-2"></i>Bookings by Status</div>
            <div class="p-3" style="height:280px;"><canvas id="statusChart"></canvas></div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-graph-up me-2"></i>Monthly Overview</div>
            <div class="p-3" style="height:280px;"><canvas id="monthlyChart"></canvas></div>
        </div>
    </div>
</div>

<!-- ── Recent Bookings ── -->
<h6 class="section-title"><i class="bi bi-clock-history me-2"></i>Recent Bookings</h6>
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
        <h6 class="fw-bold mb-0" style="color: var(--primary);"><i class="bi bi-calendar-check me-2 text-primary"></i>Latest Sessions</h6>
        <a href="${pageContext.request.contextPath}/student/my-bookings" class="btn btn-sm btn-outline-primary-soft">View All</a>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                    <tr>
                        <th>#</th><th>Tutor</th><th>Subject</th><th>Date</th><th>Time</th><th>Amount</th><th>Status</th><th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${recentBookings}">
                    <tr>
                        <td class="text-muted small">${b.id}</td>
                        <td>${b.tutorName}</td>
                        <td>${b.subject}</td>
                        <td>${b.sessionDate}</td>
                        <td class="small">${b.timeSlot}</td>
                        <td>LKR ${b.totalAmount}</td>
                        <td><span class="badge badge-${b.status} px-2 py-1">${b.status}</span></td>
                        <td>
                            <c:if test="${b.status == 'PENDING' || b.status == 'CONFIRMED'}">
                                <form action="${pageContext.request.contextPath}/student/cancel-booking" method="post" class="d-inline">
                                    <input type="hidden" name="bookingId" value="${b.id}">
                                    <button class="btn btn-sm btn-outline-danger">Cancel</button>
                                </form>
                            </c:if>
                            <c:if test="${b.status == 'COMPLETED'}">
                                <span class="badge bg-success">Done</span>
                            </c:if>
                            <c:if test="${b.status == 'CANCELLED'}">
                                <span class="badge bg-secondary">Cancelled</span>
                            </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty recentBookings}">
                        <tr><td colspan="8" class="text-center text-muted py-4">No bookings yet.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ── Quick Actions ── -->
<h6 class="section-title"><i class="bi bi-lightning me-2"></i>Quick Actions</h6>
<div class="row g-3">
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/student/view-subjects" class="card stat-card p-3 text-decoration-none">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-muted small">Browse</div>
                    <div class="stat-number" style="font-size:1.2rem;">Subjects</div>
                    <div class="text-muted small">Find tutors</div>
                </div>
                <i class="bi bi-journal-bookmark" style="font-size:2rem;color:#dee2e6"></i>
            </div>
        </a>
    </div>
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/student/view-tutors" class="card stat-card p-3 text-decoration-none">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-muted small">Discover</div>
                    <div class="stat-number" style="font-size:1.2rem;">Tutors</div>
                    <div class="text-muted small">Expert teachers</div>
                </div>
                <i class="bi bi-people" style="font-size:2rem;color:#dee2e6"></i>
            </div>
        </a>
    </div>
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/student/profile" class="card stat-card p-3 text-decoration-none">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-muted small">Manage</div>
                    <div class="stat-number" style="font-size:1.2rem;">Profile</div>
                    <div class="text-muted small">Your account</div>
                </div>
                <i class="bi bi-person-gear" style="font-size:2rem;color:#dee2e6"></i>
            </div>
        </a>
    </div>
</div>

<script>
const opts = { responsive: true, maintainAspectRatio: false };

/* Bookings by Status */
const statusLabels = ['Pending', 'Confirmed', 'Completed', 'Cancelled'];
const statusValues = [${pendingCount != null ? pendingCount : 0}, ${confirmedCount != null ? confirmedCount : 0}, ${completedCount != null ? completedCount : 0}, ${cancelledCount != null ? cancelledCount : 0}];
new Chart(document.getElementById('statusChart'), {
    type: 'doughnut',
    data: {
        labels: statusLabels,
        datasets: [{
            data: statusValues,
            backgroundColor: ['#ffc107', '#38bdf8', '#2dc653', '#e94560'],
            borderWidth: 2
        }]
    },
    options: {
        ...opts,
        plugins: {
            legend: { position: 'bottom', labels: { font:{size:10}, boxWidth:10 } }
        }
    }
});

/* Monthly Overview */
new Chart(document.getElementById('monthlyChart'), {
    type: 'line',
    data: {
        labels: ['Jan','Feb','Mar','Apr','May','Jun'],
        datasets: [{
            label:'Bookings',
            data: [${pendingCount != null ? pendingCount : 0}, ${confirmedCount != null ? confirmedCount : 0}, ${completedCount != null ? completedCount : 0}, 0, 0, 0],
            fill:true,
            borderColor:'#4f6ef7',
            backgroundColor:'rgba(79,110,247,0.1)',
            tension:0.4,
            pointRadius:4
        }]
    },
    options: {
        ...opts,
        plugins:{legend:{display:false}},
        scales:{y:{beginAtZero:true,ticks:{font:{size:10}}},x:{ticks:{font:{size:10}}}}
    }
});
</script>

<%@ include file="../layout/student-layout-footer.jsp" %>