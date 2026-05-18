<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "profile"); %>
<% request.setAttribute("pageTitle", "Profile"); %>
<% request.setAttribute("pageIcon", "person-gear"); %>
<%@ include file="../layout/tutor_layout.jsp" %>

<style>
    .section-title {
        color: var(--navy);
        font-weight: 700;
        border-left: 4px solid var(--navy2, var(--navy));
        padding-left: 10px;
        margin: 1.75rem 0 1rem;
        font-size: 1rem;
    }

    /* Fix: Equal height stat cards */
    .stat-card-fixed {
        height: 100%;
        min-height: 160px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

    /* Fix: Email text size */
    .email-text {
        font-size: 0.95rem;
        word-break: break-all;
        line-height: 1.3;
        max-width: 100%;
    }

    /* Fix: Icon size consistency */
    .stat-icon {
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
        height: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Fix: Value text consistency */
    .stat-value {
        font-size: 1.75rem;
        font-weight: 700;
        line-height: 1.2;
        margin-bottom: 0.25rem;
    }

    /* Fix: Label text */
    .stat-label {
        font-size: 0.85rem;
        color: #6c757d;
    }

    /* Password strength indicator */
    .pw-strength {
        height: 4px;
        border-radius: 2px;
        margin-top: 0.5rem;
        transition: all 0.3s;
        background: #e5e7eb;
    }

    .pw-strength.weak   { background: #ef4444; width: 33%; }
    .pw-strength.medium { background: #f59e0b; width: 66%; }
    .pw-strength.strong { background: #10b981; width: 100%; }

    .pw-hint         { font-size: 0.8rem; color: #6b7280; margin-top: 0.25rem; }
    .pw-hint.invalid { color: #dc2626; }
    .pw-hint.valid   { color: #059669; }
</style>

<!-- Flash alerts -->
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

<!-- Profile Header -->
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-body p-4">
        <div class="d-flex align-items-center gap-4">
            <div class="user-avatar" style="width: 80px; height: 80px; font-size: 2rem; background: var(--navy); color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <c:choose>
                    <c:when test="${not empty tutor.name}">
                        ${tutor.name.substring(0,1).toUpperCase()}
                    </c:when>
                    <c:otherwise>T</c:otherwise>
                </c:choose>
            </div>
            <div>
                <h3 class="fw-bold mb-1">${tutor.name}</h3>
                <p class="text-muted mb-0">${tutor.email}
                    <c:if test="${tutor.verified}">
                        <span class="badge bg-success ms-2"><i class="bi bi-patch-check me-1"></i>Verified Tutor</span>
                    </c:if>
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Form -->
<h6 class="section-title"><i class="bi bi-pencil-square me-2"></i>Edit Profile</h6>
<div class="card border-0 shadow-sm rounded-3 mb-4">
    <div class="card-body p-4">
        <form action="/tutor/profile/update" method="post">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Full Name</label>
                    <input type="text" name="name" class="form-control" value="${tutor.name}" required/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phone</label>
                    <input type="text" name="phone" class="form-control" value="${tutor.phone}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Subject</label>
                    <select name="subject" class="form-select" required>
                        <option value="" disabled <c:if test="${empty tutor.subject}">selected</c:if>>Select your subject</option>
                        <c:forEach var="sub" items="${subjects}">
                            <option value="${sub.subjectName}" <c:if test="${tutor.subject == sub.subjectName}">selected</c:if>>${sub.subjectName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Qualification</label>
                    <input type="text" name="qualification" class="form-control" value="${tutor.qualification}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Location</label>
                    <input type="text" name="location" class="form-control" value="${tutor.location}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Hourly Rate (LKR)</label>
                    <input type="number" name="hourlyRate" class="form-control"
                           value="${tutor.hourlyRate}" step="0.01" min="0" required/>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold">Bio</label>
                    <textarea name="bio" class="form-control" rows="4">${tutor.bio}</textarea>
                </div>
            </div>
            <div class="mt-4">
                <button type="submit" class="btn btn-navy px-4 fw-semibold">
                    <i class="bi bi-save me-2"></i>Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Change Password -->
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

        <form id="changePwForm" action="/tutor/profile/changePassword" method="post">
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Current Password</label>
                    <input type="password" name="currentPassword" class="form-control" required/>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control"
                           required minlength="8"/>
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
                <button type="submit" id="pwSubmitBtn" class="btn btn-navy px-4 fw-semibold">
                    <i class="bi bi-key me-2"></i>Update Password
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Stats Cards - FIXED -->
<h6 class="section-title"><i class="bi bi-graph-up me-2"></i>Performance Overview</h6>
<div class="row g-3">
    <div class="col-md-4">
        <div class="card stat-card stat-card-fixed" style="border-left-color: #ffc107;">
            <div class="stat-icon text-warning">
                <i class="bi bi-star-fill"></i>
            </div>
            <div class="stat-value text-warning">${tutor.rating != null ? tutor.rating : '0.0'}</div>
            <div class="stat-label">Average Rating</div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card stat-card-fixed" style="border-left-color: var(--accent);">
            <div class="stat-icon text-info">
                <i class="bi bi-chat-square-text"></i>
            </div>
            <div class="stat-value text-info">${tutor.reviewCount != null ? tutor.reviewCount : '0'}</div>
            <div class="stat-label">Total Reviews</div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card stat-card-fixed" style="border-left-color: var(--navy);">
            <div class="stat-icon text-primary">
                <i class="bi bi-envelope"></i>
            </div>
            <div class="stat-value email-text text-primary">${tutor.email}</div>
            <div class="stat-label">Email (read-only)</div>
        </div>
    </div>
</div>

<script>
    (function() {
        const newPw = document.getElementById('newPassword');
        const confirmPw = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('pwStrength');
        const pwHint = document.getElementById('pwHint');
        const matchHint = document.getElementById('matchHint');
        const submitBtn = document.getElementById('pwSubmitBtn');
        const form = document.getElementById('changePwForm');

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
            if (confirmPw.value.length === 0) {
                matchHint.style.display = 'none';
                return;
            }
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
            if (newPw.value.length < 8) {
                e.preventDefault();
                newPw.focus();
                return false;
            }
            if (newPw.value !== confirmPw.value) {
                e.preventDefault();
                confirmPw.focus();
                return false;
            }
            return true;
        }

        newPw.addEventListener('input', updateStrength);
        confirmPw.addEventListener('input', checkMatch);
        form.addEventListener('submit', validateForm);
    })();
</script>

<!-- Delete Account -->
<h6 class="section-title mt-4"><i class="bi bi-trash me-2"></i>Danger Zone</h6>
<c:if test="${not empty deleteError}">
    <div class="alert alert-danger rounded-3 border-0 small py-2 mb-3">
        <i class="bi bi-exclamation-triangle me-1"></i>${deleteError}
    </div>
</c:if>
<div class="card border-0 shadow-sm rounded-3 mb-4 border-danger" style="border: 1px solid #f8d7da !important;">
    <div class="card-body p-4">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div>
                <h6 class="fw-bold text-danger mb-1">Delete My Account</h6>
                <p class="text-muted small mb-0">
                    Permanently removes your profile, schedules, and all associated data. This action cannot be undone.
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
                <p class="text-muted">This will permanently delete your account and all associated data including bookings and schedules. You will be logged out immediately.</p>
                <p class="fw-semibold mb-3">Type your password to confirm:</p>
                <input type="password" id="deleteConfirmPassword" class="form-control"
                       placeholder="Enter your current password" autocomplete="off"/>
                <div id="deletePasswordError" class="text-danger small mt-1" style="display:none;">
                    <i class="bi bi-exclamation-circle me-1"></i>Please enter your password to continue.
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteAccountForm" action="/tutor/profile/delete" method="post">
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
    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        const pw = document.getElementById('deleteConfirmPassword').value.trim();
        const err = document.getElementById('deletePasswordError');
        if (!pw) {
            err.style.display = 'block';
            return;
        }
        err.style.display = 'none';
        document.getElementById('deleteConfirmPasswordHidden').value = pw;
        document.getElementById('deleteAccountForm').submit();
    });

    // Clear password field when modal is closed
    document.getElementById('deleteAccountModal').addEventListener('hidden.bs.modal', function () {
        document.getElementById('deleteConfirmPassword').value = '';
        document.getElementById('deletePasswordError').style.display = 'none';
    });
</script>

<%@ include file="../layout/tutor_layout-footer.jsp" %>