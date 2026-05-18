<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Forgot Password – TutorBooking</title>
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
    </style>
</head>
<body>

<div class="container">
    <div class="card-reset">
        <div class="reset-header">
            <div class="brand-icon mb-3">
                <i class="bi bi-shield-lock" style="font-size: 2.5rem;"></i>
            </div>
            <h4 class="fw-bold mb-1">Forgot Password?</h4>
            <p class="opacity-75 mb-0">Enter your email to receive a reset code</p>
        </div>

        <div class="reset-body">
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

            <form action="/tutor/forgot-password" method="post">
                <div class="mb-4">
                    <label class="form-label fw-semibold">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-envelope text-muted"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="your@email.com" required autofocus/>
                    </div>
                </div>

                <button type="submit" class="btn btn-navy w-100 mb-3">
                    <i class="bi bi-send me-2"></i>Send Reset Code
                </button>

                <div class="text-center">
                    <a href="/tutor/login" class="text-decoration-none fw-semibold" style="color: var(--navy);">
                        <i class="bi bi-arrow-left me-1"></i>Back to Login
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>