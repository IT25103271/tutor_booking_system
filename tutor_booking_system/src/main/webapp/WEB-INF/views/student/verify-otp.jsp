<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Verify Email – Student</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
  <style>
    :root {
      --primary: #4f6ef7;
      --primary2: #3d5ce5;
    }
    body {
      background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      font-family: 'Plus Jakarta Sans', 'Segoe UI', sans-serif;
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
    .verify-card {
      border: none;
      border-radius: 22px;
      box-shadow: 0 4px 48px rgba(79,110,247,0.10), 0 1px 4px rgba(0,0,0,0.04);
      max-width: 450px;
      width: 100%;
      overflow: hidden;
      position: relative;
      z-index: 1;
      background: #fff;
    }
    .verify-header {
      background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
      color: #fff;
      padding: 32px;
      text-align: center;
    }
    .brand-icon {
      width: 64px; height: 64px;
      background: rgba(255,255,255,0.15);
      border-radius: 18px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 16px;
      font-size: 1.75rem;
    }
    .verify-body { padding: 32px; }
    .otp-input {
      letter-spacing: 12px;
      font-size: 1.8rem;
      font-weight: 700;
      text-align: center;
      border-radius: 12px;
      padding: 16px;
      border: 2px solid #e2e8f0;
      background: #f8faff;
      color: #1e293b;
    }
    .otp-input:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 0.2rem rgba(79,110,247,0.15);
      outline: none;
      background: #fff;
    }
    .btn-primary-soft {
      background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
      border: none;
      color: #fff;
      border-radius: 12px;
      padding: 14px;
      font-weight: 700;
      font-size: 0.95rem;
      transition: all 0.25s;
      box-shadow: 0 4px 16px rgba(79,110,247,0.28);
    }
    .btn-primary-soft:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 24px rgba(79,110,247,0.35);
      color: #fff;
    }
    .timer {
      color: var(--primary);
      font-weight: 600;
    }
    .btn-resend {
      background: none;
      border: none;
      color: var(--primary);
      font-weight: 600;
      font-size: 0.85rem;
      text-decoration: none;
    }
    .btn-resend:hover { text-decoration: underline; }
    .alert { border-radius: 12px; border: none; font-size: 0.875rem; }
    .alert-success { background: #ecfdf5; color: #065f46; }
    .alert-danger  { background: #fff1f2; color: #9f1239; }
    .back-link { color: #4f6ef7; text-decoration: none; font-weight: 600; font-size: 0.85rem; }
    .back-link:hover { text-decoration: underline; }
  </style>
</head>
<body>

<div class="container">
  <div class="verify-card">
    <div class="verify-header">
      <div class="brand-icon">
        <i class="bi bi-envelope-check"></i>
      </div>
      <h4 class="fw-bold mb-1">Verify Your Email</h4>
      <p class="opacity-75 mb-0">Enter the 6-digit code sent to<br><strong>${email}</strong></p>
    </div>

    <div class="verify-body">
      <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 mb-3">
          <i class="bi bi-exclamation-circle me-2"></i>${error}
        </div>
      </c:if>

      <c:if test="${not empty success}">
        <div class="alert alert-success py-2 mb-3">
          <i class="bi bi-check-circle me-2"></i>${success}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/student/verify-otp" method="post" id="otpForm">
        <div class="mb-4">
          <label class="form-label fw-semibold text-center w-100">Verification Code</label>
          <input type="text"
                 name="otpCode"
                 class="form-control otp-input"
                 maxlength="6"
                 pattern="[0-9]{6}"
                 placeholder="000000"
                 required
                 autocomplete="off"
                 inputmode="numeric"/>
          <div class="form-text text-center mt-2">
            <i class="bi bi-clock me-1"></i>Code expires in <span class="timer" id="timer">10:00</span>
          </div>
        </div>

        <button type="submit" class="btn btn-primary-soft w-100 mb-3">
          <i class="bi bi-shield-check me-2"></i>Verify Email
        </button>
      </form>

      <form action="${pageContext.request.contextPath}/student/resend-otp" method="post" class="text-center">
        <button type="submit" class="btn btn-resend" id="resendBtn" disabled>
          <i class="bi bi-arrow-clockwise me-1"></i>Resend Code
        </button>
      </form>

      <div class="text-center mt-3">
        <a href="${pageContext.request.contextPath}/student/register" class="back-link">
          <i class="bi bi-arrow-left me-1"></i>Back to Registration
        </a>
      </div>
    </div>
  </div>
</div>

<script>
  // Countdown timer
  let timeLeft = 600; // 10 minutes in seconds
  const timerEl = document.getElementById('timer');
  const resendBtn = document.getElementById('resendBtn');

  function updateTimer() {
    const minutes = Math.floor(timeLeft / 60);
    const seconds = timeLeft % 60;
    timerEl.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;

    if (timeLeft <= 0) {
      clearInterval(timerInterval);
      timerEl.textContent = "Expired";
      timerEl.style.color = "#dc3545";
      resendBtn.disabled = false;
    } else if (timeLeft <= 540) { // Enable resend after 1 minute
      resendBtn.disabled = false;
    }

    timeLeft--;
  }

  const timerInterval = setInterval(updateTimer, 1000);
  updateTimer();

  // Only allow numbers
  const otpInput = document.querySelector('input[name="otpCode"]');
  otpInput.addEventListener('input', function(e) {
    this.value = this.value.replace(/[^0-9]/g, '');
  });
</script>

</body>
</html>