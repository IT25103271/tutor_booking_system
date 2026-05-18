<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration — Tutor Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; }
        body {
            background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
            min-height: 100vh; display: flex; align-items: center;
            justify-content: center; margin: 0; padding: 2rem 1rem;
            position: relative; overflow-x: hidden;
        }
        body::before {
            content: ''; position: fixed; top: -100px; right: -100px;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(79,110,247,0.1) 0%, transparent 70%);
            border-radius: 50%; pointer-events: none;
        }
        body::after {
            content: ''; position: fixed; bottom: -80px; left: -80px;
            width: 320px; height: 320px;
            background: radial-gradient(circle, rgba(56,189,248,0.1) 0%, transparent 70%);
            border-radius: 50%; pointer-events: none;
        }
        .register-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 4px 48px rgba(79,110,247,0.10), 0 1px 4px rgba(0,0,0,0.04);
            width: 100%; max-width: 500px;
            padding: 2.75rem 2.5rem;
            position: relative; z-index: 1;
        }
        .register-icon {
            width: 64px; height: 64px;
            background: linear-gradient(135deg, #4f6ef7, #3d5ce5);
            border-radius: 18px; display: flex; align-items: center;
            justify-content: center; font-size: 1.75rem; color: #fff;
            margin: 0 auto 1.25rem;
            box-shadow: 0 6px 20px rgba(79,110,247,0.28);
        }
        .form-label { font-weight: 600; color: #475569; font-size: 0.85rem; margin-bottom: 7px; }
        .input-group-text {
            background: #f8faff; border: 1px solid #dde3f0;
            border-right: none; color: #94a3b8; border-radius: 11px 0 0 11px;
        }
        .form-control {
            background: #f8faff; border: 1px solid #dde3f0; border-left: none;
            color: #1e293b; border-radius: 0 11px 11px 0;
            padding: 12px 14px; transition: all 0.25s; font-size: 0.9rem;
        }
        .form-control:focus {
            background: #fff; border-color: #4f6ef7; border-left: none;
            box-shadow: none; color: #1e293b;
        }
        .input-group:focus-within .input-group-text {
            border-color: #4f6ef7; background: #fff;
        }
        .input-group:focus-within .form-control { border-color: #4f6ef7; }
        .btn-register {
            background: linear-gradient(135deg, #4f6ef7, #3d5ce5);
            border: none; color: #fff; font-weight: 700;
            border-radius: 12px; padding: 13px;
            transition: all 0.25s; margin-top: 0.5rem;
            box-shadow: 0 4px 16px rgba(79,110,247,0.28);
        }
        .btn-register:hover {
            background: linear-gradient(135deg, #3d5ce5, #2d4ad0);
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(79,110,247,0.35);
            color: #fff;
        }
        .login-text { font-size: 0.88rem; color: #64748b; }
        .login-text a { color: #4f6ef7; text-decoration: none; font-weight: 700; }
        .login-text a:hover { text-decoration: underline; }
        .alert { border-radius: 12px; border: none; font-size: 0.875rem; }
        .alert-success { background: #ecfdf5; color: #065f46; }
        .alert-danger  { background: #fff1f2; color: #9f1239; }
        .section-label {
            font-size: 0.72rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.07em; color: #94a3b8; margin-bottom: 0.75rem;
            margin-top: 0.25rem;
        }
        .toggle-btn {
            background: #f8faff;
            border: 1px solid #dde3f0;
            border-left: none;
            cursor: pointer;
            padding: 0.375rem 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0 11px 11px 0;
        }
        .toggle-btn:hover { background: #e2e8f0; }
        .toggle-btn:focus { outline: none; box-shadow: none; }
        .match-error {
            color: #dc2626;
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: none;
        }
        .match-error.show { display: block; }
        .match-success {
            color: #059669;
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: none;
        }
        .match-success.show { display: block; }
        .is-invalid-custom {
            border-color: #dc2626 !important;
            background-color: #fef2f2 !important;
        }
        .is-invalid-custom:focus {
            border-color: #dc2626 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.25) !important;
        }
    </style>
</head>
<body>
<div class="register-card">
    <div class="text-center mb-4">
        <div class="register-icon"><i class="bi bi-person-plus-fill"></i></div>
        <h2 class="fw-bold mb-1" style="color: #1e293b; font-size:1.6rem;">Create Account</h2>
        <p class="small text-muted mb-0">Join TutorBooking and start learning today</p>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success mb-3"><i class="bi bi-check-circle me-2"></i>${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-3"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/student/register" method="post" id="registerForm">
        <div class="section-label">Personal Information</div>
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="name" class="form-control" placeholder="John Doe" required>
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
            </div>
            <div class="form-text text-muted">
                <i class="bi bi-info-circle me-1"></i>We'll send a verification code to this email
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Phone Number</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                <input type="tel" name="phone" class="form-control" placeholder="07X XXX XXXX">
            </div>
        </div>

        <div class="section-label mt-3">Security</div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="password" id="password" class="form-control" placeholder="Min. 8 characters" required minlength="8">
                <button type="button" class="toggle-btn" id="togglePassword" title="Show password" tabindex="-1">
                    <i class="bi bi-eye" id="toggleIcon"></i>
                </button>
            </div>
        </div>
        <div class="mb-4">
            <label class="form-label">Confirm Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Repeat password" required minlength="8">
                <button type="button" class="toggle-btn" id="toggleConfirmPassword" title="Show password" tabindex="-1">
                    <i class="bi bi-eye" id="toggleIcon2"></i>
                </button>
            </div>
            <div class="match-error" id="matchError">
                <i class="bi bi-exclamation-circle me-1"></i>Passwords do not match
            </div>
            <div class="match-success" id="matchSuccess">
                <i class="bi bi-check-circle me-1"></i>Passwords match
            </div>
        </div>

        <button type="submit" class="btn btn-register w-100" id="submitBtn">
            <i class="bi bi-person-check me-2"></i>Create Account
        </button>

        <div class="text-center mt-3">
            <span class="login-text">Already have an account? <a href="${pageContext.request.contextPath}/student/login">Sign in</a></span>
        </div>
    </form>
</div>

<script>
    (function() {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const matchError = document.getElementById('matchError');
        const matchSuccess = document.getElementById('matchSuccess');
        const submitBtn = document.getElementById('submitBtn');
        const form = document.getElementById('registerForm');

        function checkMatch() {
            if (confirmPassword.value.length === 0) {
                matchError.classList.remove('show');
                matchSuccess.classList.remove('show');
                confirmPassword.classList.remove('is-invalid-custom');
                return;
            }
            if (password.value !== confirmPassword.value) {
                matchError.classList.add('show');
                matchSuccess.classList.remove('show');
                confirmPassword.classList.add('is-invalid-custom');
            } else {
                matchError.classList.remove('show');
                matchSuccess.classList.add('show');
                confirmPassword.classList.remove('is-invalid-custom');
            }
        }

        function validateForm(e) {
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                matchError.classList.add('show');
                confirmPassword.classList.add('is-invalid-custom');
                confirmPassword.focus();
                return false;
            }
            if (password.value.length < 8) {
                e.preventDefault();
                password.focus();
                return false;
            }
            return true;
        }

        password.addEventListener('input', checkMatch);
        confirmPassword.addEventListener('input', checkMatch);
        form.addEventListener('submit', validateForm);

        // Toggle functionality
        function setupToggle(btnId, inputId, iconId) {
            const btn = document.getElementById(btnId);
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            if (!btn || !input || !icon) return;
            btn.addEventListener('click', function() {
                const isPassword = input.type === 'password';
                input.type = isPassword ? 'text' : 'password';
                icon.className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
                btn.title = isPassword ? 'Hide password' : 'Show password';
            });
        }
        setupToggle('togglePassword', 'password', 'toggleIcon');
        setupToggle('toggleConfirmPassword', 'confirmPassword', 'toggleIcon2');
    })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>