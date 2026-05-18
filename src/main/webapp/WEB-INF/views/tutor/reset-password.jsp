<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Reset Password – TutorBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <style>
        :root {
            --navy: #0f3460;
            --navy2: #16213e;
            --accent: #00b4d8;
        }
        body {
            background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .card-reset {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(15, 52, 96, 0.15);
            max-width: 420px;
            width: 100%;
            overflow: hidden;
        }
        .reset-header {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
            color: #fff;
            padding: 32px;
            text-align: center;
        }
        .reset-body { padding: 32px; }
        .form-control {
            border-radius: 10px;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
        }
        .form-control:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 0.2rem rgba(0, 180, 216, 0.25);
        }
        .btn-navy {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
            border: none;
            color: #fff;
            border-radius: 10px;
            padding: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-navy:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(15, 52, 96, 0.3);
            color: #fff;
        }
        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 6px;
            transition: all 0.3s;
        }
        .toggle-btn {
            background: #fff;
            border: 2px solid #e9ecef;
            border-left: none;
            cursor: pointer;
            padding: 0 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0 10px 10px 0;
        }
        .toggle-btn:hover { background: #f8f9fa; }
        .toggle-btn:focus { outline: none; box-shadow: none; }
    </style>
</head>
<body>

<div class="container">
    <div class="card-reset">
        <div class="reset-header">
            <div class="brand-icon mb-3">
                <i class="bi bi-key" style="font-size: 2.5rem;"></i>
            </div>
            <h4 class="fw-bold mb-1">Create New Password</h4>
            <p class="opacity-75 mb-0">Enter a strong password for your account</p>
        </div>

        <div class="reset-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <form action="/tutor/reset-password" method="post" id="resetForm">
                <div class="mb-3">
                    <label class="form-label fw-semibold">New Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-lock text-muted"></i></span>
                        <input type="password" name="newPassword" id="newPwd" class="form-control"
                               placeholder="Min. 8 characters" required minlength="8"/>
                        <button type="button" class="toggle-btn" id="toggleNewPwd" title="Show password" tabindex="-1">
                            <i class="bi bi-eye" id="eye1"></i>
                        </button>
                    </div>
                    <div class="password-strength bg-light" id="strengthBar"></div>
                    <div class="form-text" id="strengthText">Enter at least 8 characters</div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Confirm Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-lock-fill text-muted"></i></span>
                        <input type="password" name="confirmPassword" id="confirmPwd" class="form-control"
                               placeholder="Repeat password" required minlength="8"/>
                        <button type="button" class="toggle-btn" id="toggleConfirmPwd" title="Show password" tabindex="-1">
                            <i class="bi bi-eye" id="eye2"></i>
                        </button>
                    </div>
                    <div class="form-text text-danger d-none" id="matchError">
                        <i class="bi bi-x-circle me-1"></i>Passwords do not match
                    </div>
                </div>

                <button type="submit" class="btn btn-navy w-100" id="submitBtn">
                    <i class="bi bi-check2-circle me-2"></i>Reset Password
                </button>
            </form>
        </div>
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

        const colors = ['#dc3545', '#fd7e14', '#ffc107', '#28a745'];
        const texts = ['Weak', 'Fair', 'Good', 'Strong'];

        strengthBar.style.width = (strength / 4 * 100) + '%';
        strengthBar.style.backgroundColor = colors[strength - 1] || '#dc3545';
        strengthText.textContent = texts[strength - 1] || 'Too short';
        strengthText.style.color = colors[strength - 1] || '#dc3545';

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

</body>
</html>