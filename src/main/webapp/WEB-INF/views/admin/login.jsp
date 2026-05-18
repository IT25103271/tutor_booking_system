<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            background: #fff;
            border-radius: 20px;
            padding: 2rem;
            overflow: hidden;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        }
        .loging-header {
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            text-align: center;
            padding: 2.5rem 2rem;
            color: #fff;
        }
        .login-icon {
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
        .login-body {
            padding: 2rem;
        }
        .form-control:focus {
            border-color: #0f3460;
            box-shadow: 0 0 0 0.2rem rgba(15,52,96,0.2);
        }
        .btn-login {
            background: linear-gradient(135deg, #1a1a2e, #0f3460);
            color: white;
            border: none;
            width: 100%;
            padding: 0.75rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
        }
        .btn-login:hover {
            opacity: 0.9;
            color: #fff;
        }
        .input-group-text {
            background: #f8f9fa;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
        .forgot-link {
            color: #0f3460;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .forgot-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-card">
    <div class="loging-header">
        <div class="login-icon">
            <i class="bi bi-shield-lock-fill"></i>
        </div>
        <h4 class="fw-bold mb-1">Admin Login</h4>
        <p class="mb-0 opacity-75 small">Home Tutor System</p>
    </div>
    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small">
                <i class="bi bi-exclamation-circle me-1"></i>${error}
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success py-2 small">
                <i class="bi bi-check-circle me-1"></i>${success}
            </div>
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/admin/login">
            <div class="mb-3">
                <label class="form-label fw-semibold small text-muted">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="bi bi-envelope text-muted"></i>
                    </span>
                    <input type="email" name="email" class="form-control" placeholder="Email address" required>
                </div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label fw-semibold small text-muted">Password</label>
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="bi bi-lock text-muted"></i>
                    </span>
                    <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-control"
                            placeholder="Enter your password"
                            spellcheck="false"
                            autocorrect="off"
                            autocapitalize="off"
                            autocomplete="current-password"
                            required
                    >
                    <button
                            type="button"
                            class="input-group-text bg-white border-start-0"
                            id="togglePassword"
                            title="Show/Hide password"
                            tabindex="-1"
                            style="cursor: pointer;"
                            onclick="togglePwd()"
                    >
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="remember">
                    <label class="form-check-label small text-muted" for="remember">Remember me</label>
                </div>
                <a href="${pageContext.request.contextPath}/admin/forgot-password" class="forgot-link">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
            </button>
        </form>
    </div>
</div>
<script>
    function togglePwd() {
        const p = document.getElementById('password');
        const i = document.getElementById('eyeIcon');
        p.type = p.type === 'password' ? 'text' : 'password';
        i.className = p.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
