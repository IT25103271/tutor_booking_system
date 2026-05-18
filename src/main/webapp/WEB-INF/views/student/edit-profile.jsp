<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "profile"); %>
<% request.setAttribute("pageTitle", "Edit Profile"); %>
<% request.setAttribute("pageIcon", "pencil-square"); %>
<%@ include file="student-layout.jsp" %>

<style>
    .form-label { font-weight: 600; color: #475569; font-size: 0.85rem; margin-bottom: 7px; }
    .form-control {
        border-radius: 11px; padding: 11px 14px;
        border: 1px solid #dde3f0; background: #f8faff;
        color: #1e293b; font-size: 0.9rem; transition: all 0.25s;
    }
    .form-control:focus {
        border-color: var(--primary); background: #fff;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.12); color: #1e293b;
    }
    .btn-save {
        background: linear-gradient(135deg, var(--primary), var(--primary2));
        color: white; padding: 11px 2rem; border-radius: 11px;
        font-weight: 700; border: none; transition: all 0.25s;
        box-shadow: 0 4px 14px rgba(79,110,247,0.26);
    }
    .btn-save:hover {
        background: linear-gradient(135deg, var(--primary2), #2d4ad0);
        color: white; transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79,110,247,0.35);
    }
    .btn-cancel {
        border: 1.5px solid #dde3f0; background: #fff;
        color: #64748b; border-radius: 11px; padding: 11px 2rem;
        font-weight: 600; transition: all 0.2s;
    }
    .btn-cancel:hover { background: #f1f4ff; border-color: #c7d0fb; color: var(--primary); }
    .profile-avatar-edit {
        width: 72px; height: 72px; border-radius: 50%;
        background: #eef0fe; display: flex; align-items: center;
        justify-content: center; font-size: 1.9rem; font-weight: 800;
        color: var(--primary); margin: 0 auto 1.5rem;
        border: 3px solid #c7d0fb;
    }
    .section-label {
        font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
        letter-spacing: 0.08em; color: #94a3b8; margin-bottom: 0.9rem;
        padding-bottom: 0.4rem; border-bottom: 1px solid #e8ebf0;
    }
</style>

<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="card" style="border-radius:18px;border:1px solid #e8ebf0;box-shadow:0 4px 32px rgba(79,110,247,0.09);">
            <div class="card-body p-4 p-md-5">
                <div class="profile-avatar-edit">${student.name.charAt(0)}</div>
                <h4 class="fw-bold text-center mb-1" style="color: #1e293b;">Edit Your Profile</h4>
                <p class="text-muted text-center small mb-4">Update your personal information</p>

                <form action="${pageContext.request.contextPath}/student/edit-profile" method="post">
                    <div class="section-label">Personal Information</div>
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" class="form-control" value="${student.name}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" value="${student.email}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="text" name="phone" class="form-control" value="${student.phone}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control" rows="3" required>${student.address}</textarea>
                    </div>

                    <div class="section-label mt-2">Security</div>
                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <div class="position-relative">
                            <input type="password" id="passwordInput" name="password"
                                   class="form-control" value="${student.password}" required
                                   style="padding-right: 44px;">
                            <i class="bi bi-eye position-absolute top-50 end-0 translate-middle-y me-3"
                               id="togglePassword" style="cursor:pointer;color:#94a3b8;"></i>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-save">
                            <i class="bi bi-check-circle me-2"></i>Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/student/profile"
                           class="btn btn-cancel text-center text-decoration-none">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('togglePassword')?.addEventListener('click', function () {
        const inp = document.getElementById('passwordInput');
        const type = inp.getAttribute('type') === 'password' ? 'text' : 'password';
        inp.setAttribute('type', type);
        this.classList.toggle('bi-eye');
        this.classList.toggle('bi-eye-slash');
    });
</script>

<%@ include file="student-layout-footer.jsp" %>