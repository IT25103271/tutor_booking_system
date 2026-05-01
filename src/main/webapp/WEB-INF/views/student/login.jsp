<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { 
            background: radial-gradient(circle at center, #1b263b 0%, #0d1b2a 100%); 
            font-family: 'Inter', 'Segoe UI', sans-serif; 
            height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; 
        }
        .login-card { 
            background: rgba(27, 38, 59, 0.7); 
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1); 
            border-radius: 24px; 
            box-shadow: 0 25px 50px rgba(0,0,0,0.3); 
            width: 100%; max-width: 420px; 
            color: #e0e1dd; 
            padding: 2.5rem;
        }
        .form-control { 
            background: rgba(255,255,255,0.05); 
            border: 1px solid rgba(255,255,255,0.1); 
            color: #fff; 
            border-radius: 12px; 
            padding: 14px 16px; 
            transition: all 0.3s;
        }
        .form-control:focus { 
            background: rgba(255,255,255,0.1); 
            border-color: #00b4d8; 
            color: #fff; 
            box-shadow: 0 0 0 4px rgba(0, 180, 216, 0.1); 
        }
        .btn-login { 
            background: #00b4d8; 
            border: none; 
            color: #fff; 
            font-weight: 700; 
            border-radius: 12px; 
            padding: 14px; 
            transition: all 0.3s; 
            margin-top: 1rem;
        }
        .btn-login:hover { 
            background: #0077b6; 
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 180, 216, 0.2);
        }
        .form-label { font-weight: 600; color: rgba(255,255,255,0.6); font-size: 0.9rem; margin-bottom: 8px; }
        .form-check-label { font-size: 0.85rem; color: rgba(255,255,255,0.6); cursor: pointer; }
        .forgot-link { font-size: 0.85rem; color: #00b4d8; text-decoration: none; font-weight: 600; }
        .forgot-link:hover { text-decoration: underline; }
        .register-text { font-size: 0.9rem; color: rgba(255,255,255,0.5); }
        .register-text a { color: #fff; text-decoration: none; font-weight: 600; }
        .register-text a:hover { text-decoration: underline; }
        .alert { border-radius: 12px; border: none; font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-white mb-2">Student Login</h2>
            <p class="small text-white-50">Welcome back! Please enter your details</p>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success bg-success bg-opacity-10 text-success border-success border-opacity-25">
                <i class="bi bi-check-circle me-2"></i> ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger bg-danger bg-opacity-10 text-danger border-danger border-opacity-25">
                <i class="bi bi-exclamation-circle me-2"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/student/login" method="post">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group">
                    <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <a href="#" class="forgot-link">Forgot password?</a>
            </div>

            <button type="submit" class="btn btn-login w-100">Sign In</button>
            
            <div class="text-center mt-4">
                <span class="register-text">Don't have an account? <a href="${pageContext.request.contextPath}/student/register">Create one</a></span>
            </div>
        </form>
    </div>
</body>
</html>
