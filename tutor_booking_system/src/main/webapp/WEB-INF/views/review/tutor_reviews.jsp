<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setAttribute("activePage", "reviews"); %>
<% request.setAttribute("pageTitle", "My Reviews"); %>
<%@ include file="../layout/tutor_layout.jsp" %>

<style>
    .star-filled    { color:#ffc107; }
    .stat-card      { background:#fff; border-radius:12px; border:1px solid #f0f2f5; }
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
    .rating-summary { background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%); color: #fff; border-radius: 12px; padding: 1.5rem; }
    .rating-big     { font-size: 3rem; font-weight: 700; line-height: 1; }
    .star-display   { font-size: 1.5rem; }
</style>

<!-- Rating Summary -->
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="rating-summary text-center">
            <c:set var="ratingVal" value="${averageRating != null ? averageRating : 0}" />
            <div class="rating-big">
                <fmt:formatNumber value="${ratingVal}" pattern="0.00" />
            </div>
            <div class="star-display mb-2">
                <c:forEach begin="1" end="${ratingVal.intValue()}" var="i">
                    <i class="bi bi-star-fill text-warning"></i>
                </c:forEach>
                <c:if test="${ratingVal - ratingVal.intValue() >= 0.5}">
                    <i class="bi bi-star-half text-warning"></i>
                </c:if>
                <c:forEach begin="1" end="${5 - ratingVal.intValue() - (ratingVal - ratingVal.intValue() >= 0.5 ? 1 : 0)}" var="i">
                    <i class="bi bi-star text-white-50"></i>
                </c:forEach>
            </div>
            <div class="small opacity-75">Average Rating</div>
            <div class="mt-2">
                <span class="badge bg-white text-dark">${reviewCount != null ? reviewCount : 0} Reviews</span>
            </div>
        </div>
    </div>
    <div class="col-md-8">
        <div class="stat-card p-4">
            <h6 class="fw-bold mb-3" style="color: var(--navy);"><i class="bi bi-bar-chart me-2"></i>Rating Breakdown</h6>
            <c:forEach begin="1" end="5" step="1" var="i">
                <c:set var="star" value="${6 - i}" />
                <div class="d-flex align-items-center mb-2">
                    <span class="small text-muted" style="width: 50px;">${star} <i class="bi bi-star-fill text-warning"></i></span>
                    <div class="flex-grow-1 mx-2">
                        <div class="progress" style="height: 8px;">
                            <c:set var="countForStar" value="0" />
                            <c:if test="${not empty ratingCounts and star < fn:length(ratingCounts)}">
                                <c:set var="countForStar" value="${ratingCounts[star]}" />
                            </c:if>
                            <c:set var="percentage" value="${reviewCount > 0 ? (countForStar / reviewCount * 100) : 0}" />
                            <div class="progress-bar bg-warning" style="width: ${percentage}%"></div>
                        </div>
                    </div>
                    <span class="small text-muted" style="width: 30px; text-align: right;">${countForStar}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header-custom">
        <span><i class="bi bi-star me-2"></i>Student Reviews</span>
        <span class="badge bg-light text-dark" id="reviewCount">${reviewCount != null ? reviewCount : 0} reviews</span>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <div class="row g-2 align-items-center">
            <div class="col-sm-5">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="reviewSearch" class="form-control" placeholder="Search student name or comment..." oninput="filterReviews()">
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
            <div class="col-sm-2">
                <select id="reviewSort" class="form-select form-select-sm" onchange="filterReviews()">
                    <option value="newest">Newest First</option>
                    <option value="oldest">Oldest First</option>
                    <option value="highest">Highest Rated</option>
                    <option value="lowest">Lowest Rated</option>
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
                    <th>Student</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody id="reviewTbody">
                <c:forEach var="r" items="${reviews}">
                    <tr data-student="${r.studentName}"
                        data-rating="${r.rating}"
                        data-comment="${r.comment}"
                        data-date="${r.date}"
                        data-status="${r.approved ? 'approved' : 'hidden'}">
                        <td>${r.studentName}</td>
                        <td>
                            <c:forEach begin="1" end="${r.rating}" var="i">
                                <i class="bi bi-star-fill star-filled"></i>
                            </c:forEach>
                            <span class="text-muted small">(${r.rating})</span>
                        </td>
                        <td><small class="text-muted">${r.comment}</small></td>
                        <td><small class="text-muted">${r.date}</small></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr><td colspan="4" class="text-center text-muted py-4">No reviews found.</td></tr>
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

function allRows() {
    return Array.from(document.querySelectorAll('#reviewTbody tr[data-student]'));
}

function pageSize() {
    return parseInt(document.getElementById('reviewPageSize').value);
}

function filterReviews() {
    const s  = document.getElementById('reviewSearch').value.toLowerCase();
    const rt = document.getElementById('reviewRatingFilter').value;
    const sort = document.getElementById('reviewSort').value;

    filtered = allRows().filter(r =>
        (!s || r.dataset.student.toLowerCase().includes(s) ||
               (r.dataset.comment && r.dataset.comment.toLowerCase().includes(s)))
     && (!rt || r.dataset.rating === rt)
    );

    // Sort
    filtered.sort((a, b) => {
        if (sort === 'highest') return parseInt(b.dataset.rating) - parseInt(a.dataset.rating);
        if (sort === 'lowest') return parseInt(a.dataset.rating) - parseInt(b.dataset.rating);
        if (sort === 'newest') return (b.dataset.date || '').localeCompare(a.dataset.date || '');
        if (sort === 'oldest') return (a.dataset.date || '').localeCompare(b.dataset.date || '');
        return 0;
    });

    currentPage = 1;
    render();
}

function resetReviewFilters() {
    document.getElementById('reviewSearch').value = '';
    document.getElementById('reviewRatingFilter').value = '';
    document.getElementById('reviewSort').value = 'newest';
    filtered = [];
    currentPage = 1;
    render();
}

function initPagination() {
    currentPage = 1;
    render();
}

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
        const a = document.createElement('a');
        a.className = 'page-link';
        a.href='#';
        a.innerHTML = label;
        if (!disabled && !active) a.addEventListener('click', e => { e.preventDefault(); currentPage = p; render(); });
        li.appendChild(a);
        return li;
    };

    ul.appendChild(mk('<i class="bi bi-chevron-left"></i>', currentPage-1, currentPage===1, false));

    // Smart pagination: show limited page numbers
    const maxVisible = 5;
    let startPage = Math.max(1, currentPage - Math.floor(maxVisible/2));
    let endPage = Math.min(pages, startPage + maxVisible - 1);
    if (endPage - startPage < maxVisible - 1) startPage = Math.max(1, endPage - maxVisible + 1);

    if (startPage > 1) {
        ul.appendChild(mk('1', 1, false, false));
        if (startPage > 2) ul.appendChild(mk('...', 0, true, false));
    }

    for (let p = startPage; p <= endPage; p++) {
        ul.appendChild(mk(p, p, false, p===currentPage));
    }

    if (endPage < pages) {
        if (endPage < pages - 1) ul.appendChild(mk('...', 0, true, false));
        ul.appendChild(mk(pages, pages, false, false));
    }

    ul.appendChild(mk('<i class="bi bi-chevron-right"></i>', currentPage+1, currentPage===pages, false));
}

render();
</script>

<%@ include file="../layout/tutor_layout-footer.jsp" %>