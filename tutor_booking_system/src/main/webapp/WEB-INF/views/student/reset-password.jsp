<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student - Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <style>
        *, *::before, *::after { box-sizing: border-box; }
        body {
            background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
            font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
            min-height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0;
            position: relative; overflow: hidden;
        }
        body::before {
            content: ''; position: fixed; top: -120px; left: -120px;
            width: 420px; height: 420px;
            background: radial-gradient(circle, rgba(79,110,247,0.12) 0%, transparent 70%);
            border-radius: 50%; pointer-events: none;
        }
        body::after {
            content: ''; position: fixed; bottom: -100px; right: -100px;
            width: 360px; height: 360px;
            background: radial-gradient(circle, rgba(56,189,248,0.12) 0%, transparent 70%);
            border-radius: 50%; pointer-events: none;
        }

        .login-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 22px;
            box-shadow: 0 4px 48px rgba(79,110,247,0.10), 0 1px 4px rgba(0,0,0,0.04);
            width: 100%; max-width: 430px;
            padding: 2.75rem 2.5rem;
            position: relative; z-index: 1;
        }
        .login-icon {
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
            background: #f8faff;
            border: 1px solid #dde3f0; border-left: none;
            color: #1e293b; border-radius: 0 11px 11px 0;
            padding: 12px 14px; transition: all 0.25s; font-size: 0.9rem;
        }
        .form-control:focus {
            background: #fff; border-color: #4f6ef7; border-left: none;
            color: #1e293b; box-shadow: none; outline: none;
        }
        .input-group:focus-within .input-group-text {
            border-color: #4f6ef7; background: #fff;
        }
        .input-group:focus-within .form-control { border-color: #4f6ef7; }
        .btn-login {
            background: linear-gradient(135deg, #4f6ef7, #3d5ce5);
            border: none; color: #fff; font-weight: 700;
            border-radius: 12px; padding: 13px;
            transition: all 0.25s; margin-top: 0.5rem;
            box-shadow: 0 4px 16px rgba(79,110,247,0.28);
            font-size: 0.95rem; letter-spacing: 0.01em;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #3d5ce5, #2d4ad0);
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(79,110,247,0.35);
            color: #fff;
        }
        .back-link { font-size: 0.85rem; color: #4f6ef7; text-decoration: none; font-weight: 600; }
        .back-link:hover { text-decoration: underline; }
        .alert { border-radius: 12px; border: none; font-size: 0.875rem; }
        .alert-danger  { background: #fff1f2; color: #9f1239; }
        .strength-bar {
            height: 4px;
            border-radius: 2px;
            margin-top: 6px;
            transition: all 0.3s;
        }
        .form-text { font-size: 0.8rem; }
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
    </style>
</head>
<body>
<div class="login-card">
    <div class="text-center mb-4">
        <div class="login-icon"><i class="bi bi-key-fill"></i></div>
        <h2 class="fw-bold mb-1" style="color: #1e293b; font-size:1.6rem;">Create New Password</h2>
        <p class="small text-muted mb-0">Enter a strong password for your account</p>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-3">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/student/reset-password" method="post" id="resetForm">
        <div class="mb-3">
            <label class="form-label">New Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="newPassword" id="newPwd" class="form-control"
                       placeholder="Minimum 8 characters" minlength="8" required>
                <button type="button" class="toggle-btn" id="toggleNewPwd" title="Show password" tabindex="-1">
                    <i class="bi bi-eye" id="eye1"></i>
                </button>
            </div>
            <div class="strength-bar bg-light" id="strengthBar" style="width:0%"></div>
            <div class="form-text" id="strengthText">Enter at least 8 characters</div>
        </div>

        <div class="mb-4">
            <label class="form-label">Confirm Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                <input type="password" name="confirmPassword" id="confirmPwd" class="form-control"
                       placeholder="Repeat password" required>
                <button type="button" class="toggle-btn" id="toggleConfirmPwd" title="Show password" tabindex="-1">
                    <i class="bi bi-eye" id="eye2"></i>
                </button>
            </div>
            <div class="form-text text-danger d-none" id="matchError">
                <i class="bi bi-x-circle me-1"></i>Passwords do not match
            </div>
        </div>

        <button type="submit" class="btn btn-login w-100" id="submitBtn">
            <i class="bi bi-check2-circle me-2"></i>Reset Password
        </button>
    </form>
</div>

<script>
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
    setupToggle('toggleNewPwd', 'newPwd', 'eye1');
    setupToggle('toggleConfirmPwd', 'confirmPwd', 'eye2');

    const newPwd = document.getElementById('newPwd');
    const confirmPwd = document.getElementById('confirmPwd');
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');
    const matchError = document.getElementById('matchError');
    const submitBtn = document.getElementById('submitBtn');

    newPwd.addEventListener('input', function() {
        const val = this.value;
        let strength = 0;
        if (val.length >= 8) strength++;
        if (val.match(/[a-z]/) && val.match(/[A-Z]/)) strength++;
        if (val.match(/[0-9]/)) strength++;
        if (val.match(/[^a-zA-Z0-9]/)) strength++;

        const colors = ['#dc3545','#fd7e14','#ffc107','#28a745'];
        const texts = ['Weak','Fair','Good','Strong'];

        strengthBar.style.width = (strength/4*100) + '%';
        strengthBar.style.backgroundColor = colors[strength-1] || '#dc3545';
        strengthText.textContent = texts[strength-1] || 'Too short';
        strengthText.style.color = colors[strength-1] || '#dc3545';
        checkMatch();
    });

    confirmPwd.addEventListener('input', checkMatch);

    function checkMatch() {
        if (confirmPwd.value && newPwd.value !== confirmPwd.value) {
            matchError.classList.remove('d-none');
            submitBtn.disabled = true;
        } else {
            matchError.classList.add('d-none');
            submitBtn.disabled = false;
        }
    }

    document.getElementById('resetForm').addEventListener('submit', function(e) {
        if (newPwd.value !== confirmPwd.value) {
            e.preventDefault();
            matchError.classList.remove('d-none');
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>