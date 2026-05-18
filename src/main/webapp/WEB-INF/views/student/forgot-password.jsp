<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Student - Forgot Password</title>
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
    .alert-success { background: #ecfdf5; color: #065f46; }
    .alert-danger  { background: #fff1f2; color: #9f1239; }
  </style>
</head>
<body>
<div class="login-card">
  <div class="text-center mb-4">
    <div class="login-icon"><i class="bi bi-key-fill"></i></div>
    <h2 class="fw-bold mb-1" style="color: #1e293b; font-size:1.6rem;">Forgot Password?</h2>
    <p class="small text-muted mb-0">Enter your email to receive a reset code</p>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger mb-3">
      <i class="bi bi-exclamation-circle me-2"></i>${error}
    </div>
  </c:if>
  <c:if test="${not empty success}">
    <div class="alert alert-success mb-3">
      <i class="bi bi-check-circle me-2"></i>${success}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/student/forgot-password" method="post">
    <div class="mb-4">
      <label class="form-label">Email Address</label>
      <div class="input-group">
        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
        <input type="email" name="email" class="form-control" placeholder="name@example.com" required autofocus>
      </div>
    </div>

    <button type="submit" class="btn btn-login w-100">
      <i class="bi bi-send me-2"></i>Send Reset Code
    </button>

    <div class="text-center mt-3">
      <a href="${pageContext.request.contextPath}/student/login" class="back-link">
        <i class="bi bi-arrow-left me-1"></i>Back to Login
      </a>
    </div>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>