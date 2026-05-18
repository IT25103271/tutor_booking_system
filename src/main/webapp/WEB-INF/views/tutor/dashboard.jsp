<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("pageTitle", "Dashboard"); %>
<% request.setAttribute("pageIcon", "speedometer2"); %>
<%@ include file="../layout/tutor_layout.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<!-- ── Stat Cards ── -->
<div class="row g-3 mb-2">
    <div class="col-sm-6 col-xl-3">
        <a href="/tutor/bookings" class="text-decoration-none">
            <div class="card stat-card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Total Bookings</div>
                        <div class="stat-number">${totalBookings}</div>
                        <div class="text-muted small">All sessions</div>
                    </div>
                    <i class="bi bi-calendar3" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="/tutor/bookings?status=PENDING" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--warning);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Pending</div>
                        <div class="stat-number" style="color: var(--warning);">${pendingCount}</div>
                        <div class="text-warning small">Awaiting action</div>
                    </div>
                    <i class="bi bi-hourglass-split" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="/tutor/bookings?status=CONFIRMED" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--accent);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Confirmed</div>
                        <div class="stat-number" style="color: var(--accent);">${confirmedCount}</div>
                        <div class="text-info small">Upcoming</div>
                    </div>
                    <i class="bi bi-check2-circle" style="font-size:2.5rem;color:#dee2e6"></i>
                </div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
        <a href="/tutor/bookings?status=COMPLETED" class="text-decoration-none">
            <div class="card stat-card p-3" style="border-left-color: var(--success);">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <div class="text-muted small">Completed</div>
                        <div class="stat-number" style="color: var(--success);">${completedCount}</div>
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
            <div class="chart-wrap"><canvas id="statusChart"></canvas></div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-graph-up me-2"></i>Monthly Overview</div>
            <div class="chart-wrap"><canvas id="monthlyChart"></canvas></div>
        </div>
    </div>
</div>

<!-- ── Recent Bookings ── -->
<h6 class="section-title"><i class="bi bi-clock-history me-2"></i>Recent Bookings</h6>
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-header bg-white border-0 py-3 d-flex justify-content-between align-items-center">
        <h6 class="fw-bold mb-0" style="color: var(--navy);"><i class="bi bi-calendar-check me-2 text-primary"></i>Latest Sessions</h6>
        <a href="/tutor/bookings" class="btn btn-sm btn-outline-navy">View All</a>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                    <tr>
                        <th>#</th><th>Student</th><th>Date</th><th>Time</th><th>Amount</th><th>Status</th><th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${recentBookings}">
                    <tr>
                        <td class="text-muted small">${b.id}</td>
                        <td>${b.studentName}</td>
                        <td>${b.sessionDate}</td>
                        <td class="small">${b.startTime} – ${b.endTime}</td>
                        <td>LKR ${b.totalAmount}</td>
                        <td><span class="badge badge-${b.status} px-2 py-1">${b.status}</span></td>
                        <td>
                            <c:if test="${b.status == 'PENDING'}">
                                <form action="/tutor/bookings/${b.id}/accept" method="post" class="d-inline">
                                    <button class="btn btn-sm btn-navy">Accept</button>
                                </form>
                                <form action="/tutor/bookings/${b.id}/cancel" method="post" class="d-inline">
                                    <button class="btn btn-sm btn-outline-danger">Cancel</button>
                                </form>
                            </c:if>
                            <c:if test="${b.status == 'CONFIRMED'}">
                                <form action="/tutor/bookings/${b.id}/complete" method="post" class="d-inline">
                                    <button class="btn btn-sm btn-success">Complete</button>
                                </form>
                                <form action="/tutor/bookings/${b.id}/cancel" method="post" class="d-inline">
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
                        <tr><td colspan="7" class="text-center text-muted py-4">No bookings yet.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ── Reviews ── -->
<h6 class="section-title"><i class="bi bi-star me-2 text-warning"></i>Recent Reviews</h6>
<div class="card border-0 shadow-sm rounded-3">
    <div class="card-header bg-white border-0 py-3">
        <h6 class="fw-bold mb-0" style="color: var(--navy);"><i class="bi bi-chat-square-text me-2 text-warning"></i>Student Feedback</h6>
    </div>
    <div class="card-body">
        <c:forEach var="r" items="${reviews}">
            <div class="d-flex gap-3 mb-3 pb-3 border-bottom">
                <div class="text-warning fs-5">
                    <c:forEach begin="1" end="${r.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                </div>
                <div>
                    <p class="mb-1">${r.comment}</p>
                    <small class="text-muted">${r.studentName} · ${r.date}</small>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty reviews}">
            <p class="text-muted mb-0">No reviews yet.</p>
        </c:if>
    </div>
</div>

<script>
const P = ['#0f3460','#16213e','#00b4d8','#4cc9f0','#e94560','#f72585','#7209b7','#3a0ca3'];
const opts = { responsive: true, maintainAspectRatio: false };

/* Bookings by Status */
const statusLabels = ['Pending', 'Confirmed', 'Completed', 'Cancelled'];
const statusValues = [${pendingCount}, ${confirmedCount}, ${completedCount}, ${cancelledCount}];
new Chart(document.getElementById('statusChart'), {
    type: 'doughnut',
    data: {
        labels: statusLabels,
        datasets: [{
            data: statusValues,
            backgroundColor: ['#ffc107', '#00b4d8', '#2dc653', '#e94560'],
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
            data: [${pendingCount}, ${confirmedCount}, ${completedCount}, 0, 0, 0],
            fill:true,
            borderColor:'#0f3460',
            backgroundColor:'rgba(15,52,96,0.1)',
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

<%@ include file="../layout/tutor_layout-footer.jsp" %>