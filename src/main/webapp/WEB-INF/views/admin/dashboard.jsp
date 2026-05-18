<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "dashboard"); %>
<% request.setAttribute("pageTitle", "Dashboard"); %>
<%@ include file="../layout/admin_layout.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
    .stat-card { border-left: 4px solid var(--navy2); transition: transform 0.18s; }
    .stat-card:hover { transform: translateY(-3px); }
    .stat-number { font-size: 1.9rem; font-weight: 700; color: var(--navy2); }
    .chart-wrap { padding: 1rem; background: #fff; height: 220px; }
    .section-title { color: var(--navy); font-weight: 700; border-left: 4px solid var(--navy2); padding-left: 10px; margin: 1.75rem 0 1rem; font-size: 1rem; }
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
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- ── Stat Cards ── -->
<div class="row g-3 mb-2">
    <div class="col-sm-6 col-xl-3">
    <a href="/admin/tutors" class="text-decoration-none">
        <div class="card stat-card p-3">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-muted small">Total Tutors</div>
                    <div class="stat-number">${totalTutors}</div>
                    <div class="text-warning small">${pendingTutors} pending</div>
                </div>
                <i class="bi bi-person-badge" style="font-size:2.5rem;color:#dee2e6"></i>
            </div>
        </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
    <a href="/admin/students" class="text-decoration-none">
        <div class="card stat-card p-3">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="text-muted small">Total Students</div>
                    <div class="stat-number">${totalStudents}</div>
                    <div class="text-muted small">Registered</div>
                </div>
                <i class="bi bi-mortarboard" style="font-size:2.5rem;color:#dee2e6"></i>
            </div>
        </div>
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
    <a href="/admin/bookings" class="text-decoration-none">
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
        </a>
    </div>
    <div class="col-sm-6 col-xl-3">
    <a href="/admin/reviews" class="text-decoration-none">
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
        </a>
    </div>
</div>


<!-- ── Charts ── -->
<h6 class="section-title"><i class="bi bi-bar-chart-line me-2"></i>Analytics Overview</h6>
<div class="row g-3">
    <div class="col-md-6 col-xl-3">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-book me-2"></i>Tutors by Subject</div>
            <div class="chart-wrap"><canvas id="chartSubject"></canvas></div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-calendar3 me-2"></i>Bookings Over Time</div>
            <div class="chart-wrap"><canvas id="chartBookings"></canvas></div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-star-half me-2"></i>Ratings Distribution</div>
            <div class="chart-wrap"><canvas id="chartRatings"></canvas></div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card">
            <div class="card-header-custom"><i class="bi bi-people me-2"></i>Membership Breakdown</div>
            <div class="chart-wrap"><canvas id="chartMembership"></canvas></div>
        </div>
    </div>
</div>

<script>
const P = ['#0f3460','#16213e','#00b4d8','#4cc9f0','#e94560','#f72585','#7209b7','#3a0ca3'];
const opts = { responsive: true, maintainAspectRatio: false };

/* Tutors by Subject — injected from controller */
const subjectLabels = [<c:forEach items="${subjectChartLabels}" var="l">"${l}",</c:forEach>];
const subjectValues = [<c:forEach items="${subjectChartValues}" var="v">${v},</c:forEach>];
new Chart(document.getElementById('chartSubject'), {
    type: 'doughnut',
    data: { labels: subjectLabels.length ? subjectLabels : ['No data'],
            datasets: [{ data: subjectValues.length ? subjectValues : [1], backgroundColor: P, borderWidth: 2 }] },
    options: { ...opts, plugins: { legend: { position: 'bottom', labels: { font:{size:10}, boxWidth:10 } } } }
});

/* Bookings over time */
const bookingLabels = [<c:forEach items="${bookingChartLabels}" var="l">"${l}",</c:forEach>];
const bookingValues = [<c:forEach items="${bookingChartValues}" var="v">${v},</c:forEach>];
new Chart(document.getElementById('chartBookings'), {
    type: 'line',
    data: { labels: bookingLabels.length ? bookingLabels : ['Jan','Feb','Mar','Apr','May','Jun'],
            datasets: [{ label:'Bookings', data: bookingValues.length ? bookingValues : [0,0,0,0,0,0],
                fill:true, borderColor:'#0f3460', backgroundColor:'rgba(15,52,96,0.1)', tension:0.4, pointRadius:4 }] },
    options: { ...opts, plugins:{legend:{display:false}}, scales:{y:{beginAtZero:true,ticks:{font:{size:10}}},x:{ticks:{font:{size:10}}}} }
});

/* Ratings distribution */
const ratingValues = [<c:forEach items="${ratingChartValues}" var="v">${v},</c:forEach>];
new Chart(document.getElementById('chartRatings'), {
    type: 'bar',
    data: { labels: ['★1','★2','★3','★4','★5'],
            datasets: [{ data: ratingValues.length === 5 ? ratingValues : [0,0,0,0,0],
                backgroundColor:['#e94560','#f72585','#fb8500','#ffc107','#2dc653'], borderRadius:6 }] },
    options: { ...opts, plugins:{legend:{display:false}}, scales:{y:{beginAtZero:true,ticks:{stepSize:1,font:{size:10}}},x:{ticks:{font:{size:10}}}} }
});

/* Membership breakdown */
const memLabels = [<c:forEach items="${membershipChartLabels}" var="l">"${l}",</c:forEach>];
const memValues = [<c:forEach items="${membershipChartValues}" var="v">${v},</c:forEach>];
new Chart(document.getElementById('chartMembership'), {
    type: 'pie',
    data: { labels: memLabels.length ? memLabels : ['No data'],
            datasets: [{ data: memValues.length ? memValues : [1], backgroundColor:['#ffc107','#6c757d'], borderWidth:2 }] },
    options: { ...opts, plugins:{ legend:{ position:'bottom', labels:{font:{size:10},boxWidth:10} } } }
});
</script>

<%@ include file="../layout/admin_layout-footer.jsp" %>
