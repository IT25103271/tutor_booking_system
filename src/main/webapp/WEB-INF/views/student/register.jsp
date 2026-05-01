<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background: #0d1b2a; font-family: 'Segoe UI', sans-serif; height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; }
        .card { background: #1b263b; border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); width: 100%; max-width: 500px; color: #e0e1dd; }
        .form-control { background: #415a77; border: none; color: #fff; border-radius: 10px; padding: 12px; }
        .form-control:focus { background: #778da9; color: #fff; box-shadow: none; }
        .btn-primary { background: #e0e1dd; border: none; color: #0d1b2a; font-weight: 700; border-radius: 10px; padding: 12px; transition: 0.3s; }
        .btn-primary:hover { background: #778da9; color: #fff; }
        .form-label { font-weight: 500; color: #778da9; }
        a { color: #778da9; text-decoration: none; }
        a:hover { color: #e0e1dd; }
    </style>
</head>
<body>
    <div class="card p-4">
        <div class="text-center mb-4">
            <h2 class="fw-bold">Student Registration</h2>
            <p class="text-muted">Create your account to book tutors</p>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/student/register" method="post">
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="John Doe" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phone" class="form-control" placeholder="+1234567890" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <textarea name="address" class="form-control" rows="2" placeholder="123 Main St, City" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100 mt-2">Register Now</button>
            <div class="text-center mt-3">
                <span>Already have an account? <a href="${pageContext.request.contextPath}/student/login">Login here</a></span>
            </div>
        </form>
    </div>
</body>
</html>
