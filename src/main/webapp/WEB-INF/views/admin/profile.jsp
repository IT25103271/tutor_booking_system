<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "profile"); %>
<% request.setAttribute("pageTitle", "My Profile"); %>
<% request.setAttribute("pageIcon", "person-gear"); %>

<%@ include file="../layout/admin_layout.jsp" %>

<style>
    .section-title {
        color: var(--navy);
        font-weight: 700;
        border-left: 4px solid var(--navy2);
        padding-left: 10px;
        margin: 1.75rem 0 1rem;
        font-size: 1rem;
    }

    .stat-card-fixed {
        height: 100%;
        min-height: 140px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        border-left: 4px solid var(--navy2);
    }

    .stat-icon  { font-size: 1.5rem; margin-bottom: 0.5rem; }
    .stat-value { font-size: 1.5rem; font-weight: 700; line-height: 1.2; margin-bottom: 0.25rem; word-break: break-all; }
    .stat-label { font-size: 0.82rem; color: #6c757d; }

    /* Password strength */
    .pw-strength { height: 4px; border-radius: 2px; margin-top: 0.5rem; transition: all 0.3s; background: #e5e7eb; }
    .pw-strength.weak   { background: #ef4444; width: 33%; }
    .pw-strength.medium { background: #f59e0b; width: 66%; }
    .pw-strength.strong { background: #10b981; width: 100%; }
    .pw-hint         { font-size: 0.8rem; color: #6b7280; margin-top: 0.25rem; }
    .pw-hint.invalid { color: #dc2626; }
    .pw-hint.valid   { color: #059669; }
</style>

<!-- ── Profile Header ── -->
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-body p-4">
        <div class="d-flex align-items-center gap-4">
            <div style="width:80px;height:80px;font-size:2rem;background:var(--navy);color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <c:choose>
                    <c:when test="${not empty admin.name}">${admin.name.substring(0,1).toUpperCase()}</c:when>
                    <c:otherwise>A</c:otherwise>
                </c:choose>
            </div>
            <div>
                <h3 class="fw-bold mb-1">${admin.name}</h3>
                <p class="text-muted mb-1">${admin.email}</p>
                <span class="badge" style="background:var(--accent);color:#fff;">
                    <i class="bi bi-shield-check me-1"></i>Administrator
                </span>
            </div>
        </div>
    </div>
</div>

<!-- ── Flash alerts (profile update) ── -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible rounded-3 border-0 small py-2 mb-3">
        <i class="bi bi-check-circle me-1"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible rounded-3 border-0 small py-2 mb-3">
        <i class="bi bi-exclamation-triangle me-1"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- ── Edit Profile ── -->
<h6 class="section-title"><i class="bi bi-pencil-square me-2"></i>Edit Profile</h6>
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-body p-4">
        <form action="/admin/edit" method="post">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Full Name</label>
                    <input type="text" name="name" class="form-control" value="${admin.name}" required/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Email Address</label>
                    <input type="email" name="email" class="form-control" value="${admin.email}" required/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phone Number</label>
                    <input type="text" name="phone" class="form-control" value="${admin.phone}"/>
                </div>
            </div>
            <div class="mt-4">
                <button type="submit" class="btn px-4 fw-semibold text-white" style="background:var(--navy);">
                    <i class="bi bi-save me-2"></i>Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ── Change Password ── -->
<h6 class="section-title"><i class="bi bi-shield-lock me-2"></i>Change Password</h6>
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-body p-4">
        <c:if test="${not empty pwError}">
            <div class="alert alert-danger rounded-3 border-0 small py-2 mb-3">
                <i class="bi bi-exclamation-triangle me-1"></i>${pwError}
            </div>
        </c:if>
        <c:if test="${not empty pwSuccess}">
            <div class="alert alert-success rounded-3 border-0 small py-2 mb-3">
                <i class="bi bi-check-circle me-1"></i>${pwSuccess}
            </div>
        </c:if>

        <form id="changePwForm" action="/admin/profile/changePassword" method="post">
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Current Password</label>
                    <input type="password" name="currentPassword" class="form-control" required/>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required minlength="8"/>
                    <div id="pwStrength" class="pw-strength"></div>
                    <div id="pwHint" class="pw-hint">Minimum 8 characters required</div>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required/>
                    <div id="matchHint" class="pw-hint" style="display:none;">
                        <i class="bi bi-x-circle me-1"></i>Passwords do not match
                    </div>
                </div>
            </div>
            <div class="mt-4">
                <button type="submit" id="pwSubmitBtn" class="btn px-4 fw-semibold text-white" style="background:var(--navy);">
                    <i class="bi bi-key me-2"></i>Update Password
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ── Account Overview Cards ── -->
<h6 class="section-title"><i class="bi bi-info-circle me-2"></i>Account Overview</h6>
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card stat-card-fixed shadow-sm" style="border-left-color:var(--accent);">
            <div class="stat-icon text-info"><i class="bi bi-person-badge"></i></div>
            <div class="stat-value text-info" style="font-size:1.1rem;">Administrator</div>
            <div class="stat-label">Role</div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card-fixed shadow-sm" style="border-left-color:#f59e0b;">
            <div class="stat-icon text-warning"><i class="bi bi-envelope"></i></div>
            <div class="stat-value text-warning" style="font-size:0.95rem;">${admin.email}</div>
            <div class="stat-label">Email (read-only)</div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card-fixed shadow-sm" style="border-left-color:#10b981;">
            <div class="stat-icon" style="color:#10b981;"><i class="bi bi-telephone"></i></div>
            <div class="stat-value" style="color:#10b981;font-size:1.1rem;">
                <c:choose>
                    <c:when test="${not empty admin.phone}">${admin.phone}</c:when>
                    <c:otherwise>—</c:otherwise>
                </c:choose>
            </div>
            <div class="stat-label">Phone</div>
        </div>
    </div>
</div>

<!-- ── Danger Zone ── -->
<h6 class="section-title"><i class="bi bi-trash me-2"></i>Danger Zone</h6>
<c:if test="${not empty deleteError}">
    <div class="alert alert-danger rounded-3 border-0 small py-2 mb-3">
        <i class="bi bi-exclamation-triangle me-1"></i>${deleteError}
    </div>
</c:if>
<div class="card border-0 shadow-sm rounded-3 mb-4" style="border: 1px solid #f8d7da !important;">
    <div class="card-body p-4">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div>
                <h6 class="fw-bold text-danger mb-1">Delete My Account</h6>
                <p class="text-muted small mb-0">
                    Permanently removes your admin account. This action cannot be undone.
                </p>
            </div>
            <button type="button" class="btn btn-outline-danger fw-semibold px-4"
                    data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                <i class="bi bi-trash me-2"></i>Delete Account
            </button>
        </div>
    </div>
</div>

<!-- Confirm Delete Modal -->
<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold text-danger" id="deleteAccountModalLabel">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>Delete Account
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-2">
                <p class="text-muted">This will permanently delete your admin account. You will be logged out immediately.</p>
                <p class="fw-semibold mb-3">Enter your password to confirm:</p>
                <input type="password" id="deleteConfirmPassword" class="form-control"
                       placeholder="Enter your current password" autocomplete="off"/>
                <div id="deletePasswordError" class="text-danger small mt-1" style="display:none;">
                    <i class="bi bi-exclamation-circle me-1"></i>Please enter your password to continue.
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteAccountForm" action="/admin/delete" method="post">
                    <input type="hidden" name="confirmPassword" id="deleteConfirmPasswordHidden"/>
                    <button type="button" class="btn btn-danger fw-semibold" id="confirmDeleteBtn">
                        <i class="bi bi-trash me-2"></i>Yes, Delete My Account
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    /* ── Password strength ── */
    (function () {
        const newPw      = document.getElementById('newPassword');
        const confirmPw  = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('pwStrength');
        const pwHint     = document.getElementById('pwHint');
        const matchHint  = document.getElementById('matchHint');
        const form       = document.getElementById('changePwForm');

        function updateStrength() {
            const val = newPw.value;
            strengthBar.className = 'pw-strength';
            if (val.length === 0) {
                pwHint.textContent = 'Minimum 8 characters required';
                pwHint.className = 'pw-hint';
                return;
            }
            if (val.length < 8) {
                strengthBar.classList.add('weak');
                pwHint.textContent = 'Too short — minimum 8 characters';
                pwHint.className = 'pw-hint invalid';
            } else if (val.length < 12) {
                strengthBar.classList.add('medium');
                pwHint.textContent = 'Good — 8+ characters';
                pwHint.className = 'pw-hint valid';
            } else {
                strengthBar.classList.add('strong');
                pwHint.textContent = 'Strong password';
                pwHint.className = 'pw-hint valid';
            }
        }

        function checkMatch() {
            if (confirmPw.value.length === 0) { matchHint.style.display = 'none'; return; }
            if (newPw.value !== confirmPw.value) {
                matchHint.style.display = 'block';
                matchHint.className = 'pw-hint invalid';
                matchHint.innerHTML = '<i class="bi bi-x-circle me-1"></i>Passwords do not match';
            } else {
                matchHint.style.display = 'block';
                matchHint.className = 'pw-hint valid';
                matchHint.innerHTML = '<i class="bi bi-check-circle me-1"></i>Passwords match';
            }
        }

        function validateForm(e) {
            if (newPw.value.length < 8) { e.preventDefault(); newPw.focus(); return false; }
            if (newPw.value !== confirmPw.value) { e.preventDefault(); confirmPw.focus(); return false; }
        }

        newPw.addEventListener('input', updateStrength);
        confirmPw.addEventListener('input', checkMatch);
        form.addEventListener('submit', validateForm);
    })();

    /* ── Delete modal ── */
    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        const pw  = document.getElementById('deleteConfirmPassword').value.trim();
        const err = document.getElementById('deletePasswordError');
        if (!pw) { err.style.display = 'block'; return; }
        err.style.display = 'none';
        document.getElementById('deleteConfirmPasswordHidden').value = pw;
        document.getElementById('deleteAccountForm').submit();
    });

    document.getElementById('deleteAccountModal').addEventListener('hidden.bs.modal', function () {
        document.getElementById('deleteConfirmPassword').value = '';
        document.getElementById('deletePasswordError').style.display = 'none';
    });
</script>


<%@ include file="../layout/admin_layout-footer.jsp" %>
