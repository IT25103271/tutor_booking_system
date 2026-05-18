<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "subjects"); %>
<% request.setAttribute("pageTitle", "Subjects"); %>
<%@ include file="../layout/admin_layout.jsp" %>
<style>
    .subject-icon { width:40px;height:40px;background:var(--navy2);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:1rem; }
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
        <span><i class="bi bi-book me-2"></i>All Subjects</span>
        <div class="d-flex align-items-center gap-2">
            <span class="badge bg-light text-dark" id="subjectCount"></span>
            <a href="${pageContext.request.contextPath}/subject/add" class="btn btn-sm btn-primary">
                <i class="bi bi-plus-lg me-1"></i>Add Subject
            </a>
        </div>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-4">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="subjectSearch" class="form-control" placeholder="Search name or description…" oninput="filterSubjects()">
                </div>
            </div>
            <div class="col-sm-3">
                <select id="subjectCategoryFilter" class="form-select form-select-sm" onchange="filterSubjects()">
                    <option value="">All Categories</option>
                    <option>Mathematics</option>
                    <option>Science</option>
                    <option>Languages</option>
                    <option>Social Studies</option>
                    <option>ICT</option>
                    <option>Commerce</option>
                    <option>Arts</option>
                    <option>Other</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select id="subjectStatusFilter" class="form-select form-select-sm" onchange="filterSubjects()">
                    <option value="">All Statuses</option>
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>
            <div class="col-sm-2 text-end">
                <button class="btn-reset" onclick="resetSubjectFilters()"><i class="bi bi-x-circle me-1"></i>Reset</button>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>Subject</th>
                    <th>Category</th>
                    <th>Grade Level</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="subjectTbody">
                <c:forEach var="s" items="${subjects}">
                    <tr data-name="${s.subjectName}" data-description="${s.description}"
                        data-category="${s.category}" data-status="${s.status}">
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div class="subject-icon">${s.subjectName.charAt(0)}</div>
                                <div class="fw-semibold">${s.subjectName}</div>
                            </div>
                        </td>
                        <td><span class="badge bg-primary bg-opacity-10 text-primary">${s.category}</span></td>
                        <td>${s.gradeLevel}</td>
                        <td class="text-muted" style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">${s.description}</td>
                        <td>
                            <c:choose>
                                <c:when test="${s.status == 'Active'}">
                                    <span class="badge bg-success">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="${pageContext.request.contextPath}/subject/edit?id=${s.id}"
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="post" action="${pageContext.request.contextPath}/subject/delete"
                                      onsubmit="return confirm('Delete ${s.subjectName}? This cannot be undone.')">
                                    <input type="hidden" name="id" value="${s.id}"/>
                                    <button class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty subjects}">
                    <tr><td colspan="6" class="text-center text-muted py-4">No subjects found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="pagination-bar">
        <div class="page-info" id="subjectPageInfo"></div>
        <nav><ul class="pagination pagination-sm mb-0" id="subjectPagination"></ul></nav>
        <div class="page-size-select">Rows:
            <select id="subjectPageSize" onchange="initPagination()">
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

function allRows() { return Array.from(document.querySelectorAll('#subjectTbody tr[data-name]')); }
function pageSize() { return parseInt(document.getElementById('subjectPageSize').value); }

function filterSubjects() {
    const s   = document.getElementById('subjectSearch').value.toLowerCase();
    const cat = document.getElementById('subjectCategoryFilter').value.toLowerCase();
    const st  = document.getElementById('subjectStatusFilter').value.toLowerCase();
    filtered = allRows().filter(r =>
        (!s   || r.dataset.name.toLowerCase().includes(s) || r.dataset.description.toLowerCase().includes(s))
     && (!cat || r.dataset.category.toLowerCase() === cat)
     && (!st  || r.dataset.status.toLowerCase() === st)
    );
    currentPage = 1; render();
}

function resetSubjectFilters() {
    document.getElementById('subjectSearch').value = '';
    document.getElementById('subjectCategoryFilter').value = '';
    document.getElementById('subjectStatusFilter').value = '';
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

    document.getElementById('subjectCount').textContent = total + ' subject' + (total !== 1 ? 's' : '');
    document.getElementById('subjectPageInfo').textContent = total === 0 ? 'No results' : `Showing ${start+1}–${end} of ${total}`;

    const ul = document.getElementById('subjectPagination');
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

render();
</script>

<%@ include file="../layout/admin_layout-footer.jsp" %>
