<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Student - Verify Reset Code</title>
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
    .otp-input {
      letter-spacing: 12px;
      font-size: 1.8rem;
      font-weight: 700;
      text-align: center;
      border-radius: 12px;
      padding: 14px;
      border: 1px solid #dde3f0;
      background: #f8faff;
      color: #1e293b;
    }
    .otp-input:focus {
      background: #fff;
      border-color: #4f6ef7;
      box-shadow: 0 0 0 0.2rem rgba(79,110,247,0.15);
      outline: none;
    }
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
    .btn-resend {
      background: none;
      border: none;
      color: #4f6ef7;
      font-weight: 600;
      font-size: 0.85rem;
      text-decoration: none;
    }
    .btn-resend:hover { text-decoration: underline; }
    .back-link { font-size: 0.85rem; color: #4f6ef7; text-decoration: none; font-weight: 600; }
    .back-link:hover { text-decoration: underline; }
    .alert { border-radius: 12px; border: none; font-size: 0.875rem; }
    .alert-success { background: #ecfdf5; color: #065f46; }
    .alert-danger  { background: #fff1f2; color: #9f1239; }
    .form-text { color: #94a3b8; font-size: 0.8rem; }
  </style>
</head>
<body>
<div class="login-card">
  <div class="text-center mb-4">
    <div class="login-icon"><i class="bi bi-shield-check"></i></div>
    <h2 class="fw-bold mb-1" style="color: #1e293b; font-size:1.6rem;">Verify Reset Code</h2>
    <p class="small text-muted mb-0">Enter the 6-digit code sent to<br><strong style="color: #4f6ef7;">${email}</strong></p>
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

  <form action="${pageContext.request.contextPath}/student/verify-reset-otp" method="post">
    <div class="mb-3">
      <label class="form-label text-center w-100">Reset Code</label>
      <input type="text" name="otpCode" class="form-control otp-input"
             maxlength="6" placeholder="000000" required/>
      <div class="form-text text-center mt-2">
        <i class="bi bi-clock me-1"></i>Code expires in 5 minutes
      </div>
    </div>

    <button type="submit" class="btn btn-login w-100">
      <i class="bi bi-check-lg me-2"></i>Verify Code
    </button>
  </form>

  <form action="${pageContext.request.contextPath}/student/resend-reset-otp" method="post" class="text-center mt-3 mb-2">
    <button type="submit" class="btn-resend">
      <i class="bi bi-arrow-clockwise me-1"></i>Resend Code
    </button>
  </form>

  <div class="text-center">
    <a href="${pageContext.request.contextPath}/student/forgot-password" class="back-link">
      <i class="bi bi-arrow-left me-1"></i>Different email?
    </a>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>