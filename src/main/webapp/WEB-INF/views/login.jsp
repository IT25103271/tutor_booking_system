<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Tutor Login – TutorBooking</title>
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
    }
    .login-card { 
      border: none; 
      border-radius: 20px; 
      box-shadow: 0 20px 60px rgba(15, 52, 96, 0.15); 
      max-width: 440px; 
      width: 100%;
      overflow: hidden;
    }
    .login-header { 
      background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
      color: #fff; 
      padding: 40px 32px 32px; 
      text-align: center;
    }
    .login-header .brand-icon {
      width: 64px; height: 64px;
      background: rgba(255,255,255,0.15);
      border-radius: 16px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 16px;
      font-size: 2rem;
    }
    .login-body { padding: 32px; }
    .form-control {
      border-radius: 10px;
      padding: 12px 16px;
      border: 2px solid #e9ecef;
      font-size: 0.95rem;
    }
    .form-control:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 0.2rem rgba(0, 180, 216, 0.25);
    }
    .input-group-text {
      background: #f8f9fa;
      border: 2px solid #e9ecef;
      border-right: none;
      border-radius: 10px 0 0 10px;
      color: var(--navy);
    }
    .btn-navy {
      background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
      border: none;
      color: #fff;
      border-radius: 10px;
      padding: 14px;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.3s;
    }
    .btn-navy:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 24px rgba(15, 52, 96, 0.3);
      color: #fff;
    }
    .login-footer {
      text-align: center;
      padding: 20px 32px;
      background: #f8f9fa;
      border-top: 1px solid #e9ecef;
    }
  </style>
</head>
<body>

<div class="login-card">
  <div class="login-header">
    <div class="brand-icon">
      <i class="bi bi-mortarboard-fill"></i>
    </div>
    <h3 class="fw-bold mb-1">Tutor Portal</h3>
    <p class="opacity-75 mb-0">Sign in to manage your sessions</p>
  </div>

  <div class="login-body">
    <c:if test="${not empty error}">
      <div class="alert alert-danger py-2">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
      </div>
    </c:if>
    <c:if test="${not empty success}">
      <div class="alert alert-success py-2">
        <i class="bi bi-check-circle me-2"></i>${success}
      </div>
    </c:if>

    <form action="/tutor/login" method="post">
      <div class="mb-3">
        <label class="form-label fw-semibold">Email address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-envelope"></i></span>
          <input type="email" name="email" class="form-control" placeholder="Email" required/>
        </div>
      </div>
      <div class="mb-4">
        <label class="form-label fw-semibold">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-lock"></i></span>
          <input type="password" name="password" id="pwd" class="form-control" placeholder="Password" required/>
          <button type="button" class="btn btn-light border" onclick="togglePwd()">
            <i class="bi bi-eye" id="eyeIcon"></i>
          </button>
        </div>
      </div>
      <button type="submit" class="btn btn-navy w-100">
        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
      </button>
      <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="remember">
          <label class="form-check-label small text-muted" for="remember">Remember me</label>
        </div>
        <a href="/tutor/forgot-password" class="small text-decoration-none" style="color: var(--accent);">
          Forgot password?
        </a>
      </div>
    </form>
  </div>

  <div class="login-footer">
    <p class="mb-0 small text-muted">
      Don't have an account?
      <a href="/tutor/register" class="text-decoration-none fw-semibold" style="color: var(--navy);">Register here</a>
    </p>
  </div>
</div>
<script>
  function togglePwd(){
    const p = document.getElementById('pwd');
    const i = document.getElementById('eyeIcon');
    p.type = p.type === 'password' ? 'text' : 'password';
    i.className = p.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
