<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body{
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%,#0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card{
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }
        .loging-header{
            background: linear-gradient(135deg, #1a1a2e ,#0f3460);
            text-align: center;
            padding: 2.5rem 2rem;
            color: #fff;
        }
        .login-icon{
            width: 70px;
            height: 70px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1rem;
            border: 2px solid rgba(255,255,255,0.3);
        }
        .login-body{
            padding: 2rem;
        }
        .form-control:focus{
            border-color: #0f3460;
            box-shadow: 0 0 0 0.2rem rgba(15,52,96,0.2);
        }
        .btn-login{
            background: linear-gradient(135deg, #1a1a2e ,#0f3460);
            color: white;
            border: none;
            width: 100%;
            padding: 0.75rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
        }
        .btn-login:hover{
            opacity: 0.9;
            color: #fff;
        }
        .input-group-text{
            background: #f8f9fa;
            border-right: none;
            cursor: pointer;
        }
        .form-control{
            border-left: none;
        }
        .admin-badge {
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-block;
            margin-bottom: 1rem;
        }
        .strength-bar {
            height: 4px;
            border-radius: 2px;
            margin-top: 6px;
            transition: all 0.3s;
        }
        .toggle-btn {
            background: #f8f9fa;
            border: 1px solid #ced4da;
            border-left: none;
            cursor: pointer;
            padding: 0.375rem 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .toggle-btn:hover { background: #e9ecef; }
    </style>
</head>
<body>
<div class="login-card">
    <div class="loging-header">
        <div class="admin-badge"><i class="bi bi-shield-lock me-1"></i>Admin Portal</div>
        <div class="login-icon">
            <i class="bi bi-key-fill"></i>
        </div>
        <h4 class="fw-bold mb-1">Create New Password</h4>
        <p class="mb-0 opacity-75 small">Enter a strong password for your account</p>
    </div>
    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small">
                <i class="bi bi-exclamation-circle me-1"></i>${error}
            </div>
        </c:if>
        <form method="post" action="/admin/reset-password" id="resetForm">
            <div class="mb-3">
                <label class="form-label fw-semibold small text-muted">New Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock text-muted"></i></span>
                    <input type="password" name="newPassword" id="newPwd" class="form-control"
                           placeholder="Min. 8 characters" required minlength="8">
                    <button type="button" class="toggle-btn" id="toggleNewPwd" title="Show password" tabindex="-1">
                        <i class="bi bi-eye" id="eye1"></i>
                    </button>
                </div>
                <div class="strength-bar bg-light" id="strengthBar" style="width:0%"></div>
                <div class="form-text small" id="strengthText">Enter at least 8 characters</div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold small text-muted">Confirm Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock-fill text-muted"></i></span>
                    <input type="password" name="confirmPassword" id="confirmPwd" class="form-control"
                           placeholder="Repeat password" required minlength="8">
                    <button type="button" class="toggle-btn" id="toggleConfirmPwd" title="Show password" tabindex="-1">
                        <i class="bi bi-eye" id="eye2"></i>
                    </button>
                </div>
                <div class="form-text text-danger small d-none" id="matchError">
                    <i class="bi bi-x-circle me-1"></i>Passwords do not match
                </div>
            </div>
            <button type="submit" class="btn btn-login" id="submitBtn">
                <i class="bi bi-check2-circle me-2"></i>Reset Password
            </button>
        </form>
    </div>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>