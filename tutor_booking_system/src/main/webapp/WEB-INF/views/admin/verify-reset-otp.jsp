<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin - Verify Reset Code</title>
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
    .otp-input {
      letter-spacing: 12px;
      font-size: 1.8rem;
      font-weight: 700;
      text-align: center;
      border-radius: 10px;
      padding: 12px;
    }
    .otp-input:focus{
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
    .back-link {
      color: #0f3460;
      text-decoration: none;
      font-weight: 500;
      font-size: 0.9rem;
    }
    .back-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="login-card">
  <div class="loging-header">
    <div class="admin-badge"><i class="bi bi-shield-lock me-1"></i>Admin Portal</div>
    <div class="login-icon">
      <i class="bi bi-envelope-check-fill"></i>
    </div>
    <h4 class="fw-bold mb-1">Verify Reset Code</h4>
    <p class="mb-0 opacity-75 small">Enter the 6-digit code sent to<br><strong>${email}</strong></p>
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
    <form method="post" action="/admin/verify-reset-otp">
      <div class="mb-3">
        <label class="form-label fw-semibold small text-muted text-center w-100">Reset Code</label>
        <input type="text" name="otpCode" class="form-control otp-input"
               maxlength="6" placeholder="000000" required/>
        <div class="form-text text-center mt-2">
          Code expires in 5 minutes
        </div>
      </div>
      <button type="submit" class="btn btn-login mb-2">
        <i class="bi bi-shield-check me-2"></i>Verify Code
      </button>
    </form>
    <form method="post" action="/admin/resend-reset-otp" class="text-center mb-3">
      <button type="submit" class="btn btn-link text-decoration-none" style="color: #0f3460; font-weight: 500;">
        <i class="bi bi-arrow-clockwise me-1"></i>Resend Code
      </button>
    </form>
    <div class="text-center">
      <a href="/admin/forgot-password" class="back-link">
        <i class="bi bi-arrow-left me-1"></i>Different email?
      </a>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>