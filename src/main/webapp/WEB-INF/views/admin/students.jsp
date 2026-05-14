<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "students"); %>
<% request.setAttribute("pageTitle", "Students"); %>
<%@ include file="layout.jsp" %>

<style>
    .profile-avatar { width:40px;height:40px;background:var(--navy2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:1rem; }
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
</style>

<!-- Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible mb-3">
        <i class="bi bi-check-circle me-2"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="card">
    <div class="card-header-custom">
        <span><i class="bi bi-mortarboard me-2"></i>All Students</span>
        <span class="badge bg-light text-dark" id="studentCount"></span>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-4">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="studentSearch" class="form-control" placeholder="Search name or email…" oninput="filterStudents()">
                </div>
            </div>
            <div class="col-sm-3">
                <select id="studentGradeFilter" class="form-select form-select-sm" onchange="filterStudents()">
                    <option value="">All Grade Levels</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select id="studentMembershipFilter" class="form-select form-select-sm" onchange="filterStudents()">
                    <option value="">All Memberships</option>
                    <option value="PREMIUM">⭐ Premium</option>
                    <option value="REGULAR">Regular</option>
                </select>
            </div>
            <div class="col-sm-2 text-end">
                <button class="btn-reset" onclick="resetStudentFilters()"><i class="bi bi-x-circle me-1"></i>Reset</button>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>Student</th>
                    <th>Phone</th>
                    <th>Grade Level</th>
                    <th>Subjects Needed</th>
                    <th>Membership</th>
                     <th>Action</th>
                </tr>
                </thead>
                <tbody id="studentTbody">
                <c:forEach var="s" items="${students}">
                    <tr data-name="${s.name}" data-email="${s.email}" data-grade="${s.gradeLevel}" data-membership="${s.membershipType}">
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
                        <td>
    <form method="post" action="/admin/students/${s.id}/delete"
          onsubmit="return confirm('Delete this student?')">
        <button class="btn btn-sm btn-outline-danger">
            <i class="bi bi-trash"></i>
        </button>
    </form>
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

    <div class="pagination-bar">
        <div class="page-info" id="studentPageInfo"></div>
        <nav><ul class="pagination pagination-sm mb-0" id="studentPagination"></ul></nav>
        <div class="page-size-select">Rows:
            <select id="studentPageSize" onchange="initPagination()">
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="25">25</option>
            </select>
        </div>
    </div>
</div>

<script>
let filtered = [];
let currentPage = 1;

function allRows() { return Array.from(document.querySelectorAll('#studentTbody tr[data-name]')); }
function pageSize() { return parseInt(document.getElementById('studentPageSize').value); }

function filterStudents() {
    const s   = document.getElementById('studentSearch').value.toLowerCase();
    const gr  = document.getElementById('studentGradeFilter').value.toLowerCase();
    const mem = document.getElementById('studentMembershipFilter').value.toUpperCase();
    filtered = allRows().filter(r =>
        (!s   || r.dataset.name.toLowerCase().includes(s) || r.dataset.email.toLowerCase().includes(s))
     && (!gr  || r.dataset.grade.toLowerCase() === gr)
     && (!mem || r.dataset.membership.toUpperCase() === mem)
    );
    currentPage = 1; render();
}

function resetStudentFilters() {
    document.getElementById('studentSearch').value = '';
    document.getElementById('studentGradeFilter').value = '';
    document.getElementById('studentMembershipFilter').value = '';
    filtered = []; currentPage = 1; render();
}

function initPagination() { currentPage = 1; render(); }

function render() {
    const rows  = filtered.length ? filtered : allRows();
    const size  = pageSize();
    const total = rows.length;
    const pages = Math.max(1, Math.ceil(total / size));
    if (currentPage > pages) currentPage = pages;
    const start = (currentPage - 1) * size;
    const end   = Math.min(start + size, total);

    allRows().forEach(r => r.style.display = 'none');
    rows.forEach((r, i) => { r.style.display = (i >= start && i < end) ? '' : 'none'; });

    document.getElementById('studentCount').textContent = total + ' student' + (total !== 1 ? 's' : '');
    document.getElementById('studentPageInfo').textContent = total === 0 ? 'No results' : `Showing ${start+1}–${end} of ${total}`;

    const ul = document.getElementById('studentPagination');
    ul.innerHTML = '';
    const mk = (label, p, disabled, active) => {
        const li = document.createElement('li');
        li.className = 'page-item' + (disabled?' disabled':'') + (active?' active':'');
        const a = document.createElement('a'); a.className = 'page-link'; a.href='#'; a.innerHTML = label;
        if (!disabled && !active) a.addEventListener('click', e => { e.preventDefault(); currentPage = p; render(); });
        li.appendChild(a); return li;
    };
    ul.appendChild(mk('<i class="bi bi-chevron-left"></i>', currentPage-1, currentPage===1, false));
    for (let p = 1; p <= pages; p++) ul.appendChild(mk(p, p, false, p===currentPage));
    ul.appendChild(mk('<i class="bi bi-chevron-right"></i>', currentPage+1, currentPage===pages, false));
}

// Populate grade dropdown
const gradeSet = new Set();
allRows().forEach(r => { if (r.dataset.grade) gradeSet.add(r.dataset.grade); });
const sel = document.getElementById('studentGradeFilter');
[...gradeSet].sort().forEach(g => {
    const o = document.createElement('option'); o.value = g.toLowerCase(); o.textContent = g; sel.appendChild(o);
});

render();
</script>

<%@ include file="layout-footer.jsp" %>
