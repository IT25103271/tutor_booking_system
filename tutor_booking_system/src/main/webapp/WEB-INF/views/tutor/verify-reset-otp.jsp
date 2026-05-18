<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Verify Reset Code – TutorBooking</title>
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
        .card-verify {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(15, 52, 96, 0.15);
            max-width: 420px;
            width: 100%;
            overflow: hidden;
        }
        .verify-header {
            background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
            color: #fff;
            padding: 32px;
            text-align: center;
        }
        .verify-body { padding: 32px; }
        .otp-input {
            letter-spacing: 10px;
            font-size: 1.8rem;
            font-weight: 700;
            text-align: center;
            border-radius: 12px;
            padding: 16px;
            border: 2px solid #e9ecef;
        }
        .otp-input:focus {
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
        .timer {
            color: var(--accent);
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card-verify">
        <div class="verify-header">
            <div class="brand-icon mb-3">
                <i class="bi bi-envelope-check" style="font-size: 2.5rem;"></i>
            </div>
            <h4 class="fw-bold mb-1">Verify Reset Code</h4>
            <p class="opacity-75 mb-0">Enter the 6-digit code sent to<br><strong>${email}</strong></p>
        </div>

        <div class="verify-body">
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

            <form action="/tutor/verify-reset-otp" method="post" id="otpForm">
                <div class="mb-4">
                    <label class="form-label fw-semibold text-center w-100">Reset Code</label>
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
                        Code expires in <span class="timer" id="timer">5:00</span>
                    </div>
                </div>

                <button type="submit" class="btn btn-navy w-100 mb-3">
                    <i class="bi bi-shield-check me-2"></i>Verify Code
                </button>
            </form>

            <form action="/tutor/resend-reset-otp" method="post" class="text-center">
                <button type="submit" class="btn btn-link text-decoration-none" id="resendBtn" disabled>
                    <i class="bi bi-arrow-clockwise me-1"></i>Resend Code
                </button>
            </form>

            <div class="text-center mt-3">
                <a href="/tutor/forgot-password" class="text-muted small text-decoration-none">
                    <i class="bi bi-arrow-left me-1"></i>Different email?
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    let timeLeft = 300; // 5 minutes
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
        } else if (timeLeft <= 240) { // Enable resend after 1 minute
            resendBtn.disabled = false;
        }
        timeLeft--;
    }

    const timerInterval = setInterval(updateTimer, 1000);
    updateTimer();

    const otpInput = document.querySelector('input[name="otpCode"]');
    otpInput.addEventListener('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
</script>

</body>
</html>