<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "reviews"); %>
<% request.setAttribute("pageTitle", "Reviews"); %>
<%@ include file="layout.jsp" %>

<style>
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

<div class="card">
    <div class="card-header-custom">
        <span><i class="bi bi-star me-2"></i>All Reviews</span>
        <span class="badge bg-light text-dark" id="reviewCount"></span>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-4">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="reviewSearch" class="form-control" placeholder="Search tutor or student…" oninput="filterReviews()">
                </div>
            </div>
            <div class="col-sm-3">
                <select id="reviewRatingFilter" class="form-select form-select-sm" onchange="filterReviews()">
                    <option value="">All Ratings</option>
                    <option value="5">★★★★★ 5</option>
                    <option value="4">★★★★☆ 4</option>
                    <option value="3">★★★☆☆ 3</option>
                    <option value="2">★★☆☆☆ 2</option>
                    <option value="1">★☆☆☆☆ 1</option>
                </select>
            </div>
            <div class="col-sm-3">
                <select id="reviewStatusFilter" class="form-select form-select-sm" onchange="filterReviews()">
                    <option value="">All Statuses</option>
                    <option value="approved">Approved</option>
                    <option value="hidden">Hidden</option>
                </select>
            </div>
            <div class="col-sm-2 text-end">
                <button class="btn-reset" onclick="resetReviewFilters()"><i class="bi bi-x-circle me-1"></i>Reset</button>
            </div>
        </div>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                <tr>
                    <th>Tutor</th>
                    <th>Student</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody id="reviewTbody">
                <c:forEach var="r" items="${reviews}">
                    <tr data-tutor="${r.tutorName}" data-student="${r.studentName}" data-rating="${r.rating}" data-status="${r.approved ? 'approved' : 'hidden'}">
                        <td class="fw-semibold">${r.tutorName}</td>
                        <td>${r.studentName}</td>
                        <td>
                            <c:forEach begin="1" end="${r.rating}" var="i">
                                <i class="bi bi-star-fill star-filled"></i>
                            </c:forEach>
                            <span class="text-muted small">(${r.rating})</span>
                        </td>
                        <td><small class="text-muted">${r.comment}</small></td>
                        <td><small class="text-muted">${r.date}</small></td>
                        <td>
                            <c:choose>
                                <c:when test="${r.approved}">
                                    <span class="badge bg-success">Approved</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning text-dark">Hidden</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="/admin/reviews/${r.id}/delete"
                                  onsubmit="return confirm('Delete this review?')">
                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr><td colspan="7" class="text-center text-muted py-4">No reviews found.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="pagination-bar">
        <div class="page-info" id="reviewPageInfo"></div>
        <nav><ul class="pagination pagination-sm mb-0" id="reviewPagination"></ul></nav>
        <div class="page-size-select">Rows:
            <select id="reviewPageSize" onchange="initPagination()">
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

function allRows() { return Array.from(document.querySelectorAll('#reviewTbody tr[data-tutor]')); }
function pageSize() { return parseInt(document.getElementById('reviewPageSize').value); }

function filterReviews() {
    const s  = document.getElementById('reviewSearch').value.toLowerCase();
    const rt = document.getElementById('reviewRatingFilter').value;
    const st = document.getElementById('reviewStatusFilter').value.toLowerCase();
    filtered = allRows().filter(r =>
        (!s  || r.dataset.tutor.toLowerCase().includes(s) || r.dataset.student.toLowerCase().includes(s))
     && (!rt || r.dataset.rating === rt)
     && (!st || r.dataset.status === st)
    );
    currentPage = 1; render();
}

function resetReviewFilters() {
    document.getElementById('reviewSearch').value = '';
    document.getElementById('reviewRatingFilter').value = '';
    document.getElementById('reviewStatusFilter').value = '';
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

    document.getElementById('reviewCount').textContent = total + ' review' + (total !== 1 ? 's' : '');
    document.getElementById('reviewPageInfo').textContent = total === 0 ? 'No results' : `Showing ${start+1}–${end} of ${total}`;

    const ul = document.getElementById('reviewPagination');
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

<%@ include file="layout-footer.jsp" %>
