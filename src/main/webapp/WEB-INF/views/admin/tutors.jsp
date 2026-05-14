<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "tutors"); %>
<% request.setAttribute("pageTitle", "Tutors"); %>
<%@ include file="layout.jsp" %>

<style>
    .profile-avatar { width:40px;height:40px;background:var(--navy2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:1rem; }
    .badge-verified { background:#d4edda;color:#155724; }
    .badge-pending  { background:#fff3cd;color:#856404; }
    .star-filled    { color:#ffc107; }
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
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible mb-3">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="card">
    <div class="card-header-custom">
        <span><i class="bi bi-person-badge me-2"></i>All Tutors</span>
        <span class="badge bg-light text-dark" id="tutorCount"></span>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-4">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="tutorSearch" class="form-control" placeholder="Search name or email…" oninput="filterTutors()">
                </div>
            </div>
            <div class="col-sm-3">
                <select id="tutorSubjectFilter" class="form-select form-select-sm" onchange="filterTutors()">
                    <option value="">All Subjects</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select id="tutorStatusFilter" class="form-select form-select-sm" onchange="filterTutors()">
                    <option value="">All Statuses</option>
                    <option value="verified">Verified</option>
                    <option value="pending">Pending</option>
                </select>
            </div>
            <div class="col-sm-2 text-end">
                <button class="btn-reset" onclick="resetTutorFilters()"><i class="bi bi-x-circle me-1"></i>Reset</button>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>Tutor</th>
                    <th>Subject</th>
                    <th>Qualification</th>
                    <th>Location</th>
                    <th>Rate</th>
                    <th>Rating</th>
                    <th>Status</th>
                    <th>Verify</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="tutorTbody">
                <c:forEach var="t" items="${tutors}">
                    <tr data-name="${t.name}" data-email="${t.email}" data-subject="${t.subject}" data-status="${t.verified ? 'verified' : 'pending'}">
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div class="profile-avatar">${t.name.charAt(0)}</div>
                                <div>
                                    <div class="fw-semibold">${t.name}</div>
                                    <small class="text-muted">${t.email}</small>
                                </div>
                            </div>
                        </td>
                        <td><span class="badge bg-primary">${t.subject}</span></td>
                        <td>${t.qualification}</td>
                        <td>${t.location}</td>
                        <td class="fw-bold text-success">$${t.hourlyRate}/hr</td>
                        <td>
                            <i class="bi bi-star-fill star-filled"></i>
                            ${t.rating} (${t.reviewCount})
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${t.verified}">
                                    <span class="badge badge-verified"><i class="bi bi-patch-check-fill"></i> Verified</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-pending">Pending</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${!t.verified}">
                                <form method="post" action="/admin/tutors/${t.id}/verify">
                                    <button class="btn btn-sm btn-success"><i class="bi bi-check-lg"></i> Verify</button>
                                </form>
                            </c:if>
                            <c:if test="${t.verified}">
                                <span class="text-muted small">✓ Verified</span>
                            </c:if>
                        </td>
                        <td>
    <form method="post" action="/admin/tutors/${t.id}/delete"
          onsubmit="return confirm('Delete this tutor?')">
        <button class="btn btn-sm btn-outline-danger">
            <i class="bi bi-trash"></i>
        </button>
    </form>
</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty tutors}">
                    <tr><td colspan="8" class="text-center text-muted py-4">No tutors found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="pagination-bar">
        <div class="page-info" id="tutorPageInfo"></div>
        <nav><ul class="pagination pagination-sm mb-0" id="tutorPagination"></ul></nav>
        <div class="page-size-select">Rows:
            <select id="tutorPageSize" onchange="initPagination()">
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

function allRows() {
    return Array.from(document.querySelectorAll('#tutorTbody tr[data-name]'));
}
function pageSize() { return parseInt(document.getElementById('tutorPageSize').value); }

function filterTutors() {
    const s  = document.getElementById('tutorSearch').value.toLowerCase();
    const subj = document.getElementById('tutorSubjectFilter').value.toLowerCase();
    const st = document.getElementById('tutorStatusFilter').value.toLowerCase();
    filtered = allRows().filter(r =>
        (!s    || r.dataset.name.toLowerCase().includes(s) || r.dataset.email.toLowerCase().includes(s))
     && (!subj || r.dataset.subject.toLowerCase() === subj)
     && (!st   || r.dataset.status === st)
    );
    currentPage = 1;
    render();
}

function resetTutorFilters() {
    document.getElementById('tutorSearch').value = '';
    document.getElementById('tutorSubjectFilter').value = '';
    document.getElementById('tutorStatusFilter').value = '';
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

    document.getElementById('tutorCount').textContent = total + ' tutor' + (total !== 1 ? 's' : '');
    document.getElementById('tutorPageInfo').textContent = total === 0 ? 'No results' : `Showing ${start+1}–${end} of ${total}`;

    const ul = document.getElementById('tutorPagination');
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

// Populate subject dropdown
const subjectSet = new Set();
allRows().forEach(r => { if (r.dataset.subject) subjectSet.add(r.dataset.subject); });
const sel = document.getElementById('tutorSubjectFilter');
[...subjectSet].sort().forEach(s => {
    const o = document.createElement('option'); o.value = s.toLowerCase(); o.textContent = s; sel.appendChild(o);
});

// Auto-filter if URL has ?status=pending
const urlParams = new URLSearchParams(window.location.search);
if (urlParams.get('status')) {
    document.getElementById('tutorStatusFilter').value = urlParams.get('status');
}

render();
</script>

<%@ include file="layout-footer.jsp" %>
