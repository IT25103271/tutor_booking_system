<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Tutor Register – TutorBooking</title>
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
      padding: 40px 0;
    }
    .register-card {
      border: none;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(15, 52, 96, 0.15);
      max-width: 700px;
      width: 100%;
      margin: 0 auto;
      overflow: hidden;
    }
    .register-header {
      background: linear-gradient(135deg, var(--navy) 0%, var(--navy2) 100%);
      color: #fff;
      padding: 32px;
      text-align: center;
    }
    .register-header .brand-icon {
      width: 56px; height: 56px;
      background: rgba(255,255,255,0.15);
      border-radius: 14px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 12px;
      font-size: 1.75rem;
    }
    .register-body { padding: 32px; }
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
    .section-label {
      font-size: .75rem;
      text-transform: uppercase;
      letter-spacing: .1em;
      color: var(--navy);
      margin-bottom: .75rem;
      margin-top: 1.25rem;
      font-weight: 700;
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
    .register-footer {
      text-align: center;
      padding: 20px 32px;
      background: #f8f9fa;
      border-top: 1px solid #e9ecef;
    }
    .toggle-btn {
      background: #fff;
      border: 2px solid #e9ecef;
      border-left: none;
      cursor: pointer;
      padding: 0 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 0 10px 10px 0;
    }
    .toggle-btn:hover { background: #f8f9fa; }
    .toggle-btn:focus { outline: none; box-shadow: none; }
    .input-group-text {
      background: #fff;
      border: 2px solid #e9ecef;
      border-right: none;
      color: #94a3b8;
      border-radius: 10px 0 0 10px;
    }
    .input-group .form-control {
      border-left: none;
      border-radius: 0;
    }
    .input-group:focus-within .input-group-text,
    .input-group:focus-within .form-control,
    .input-group:focus-within .toggle-btn {
      border-color: var(--accent);
    }
    .input-group:focus-within .input-group-text {
      background: #fff;
    }
    .match-error {
      color: #dc2626;
      font-size: 0.85rem;
      margin-top: 0.35rem;
      display: none;
    }
    .match-error.show { display: block; }
    .match-success {
      color: #059669;
      font-size: 0.85rem;
      margin-top: 0.35rem;
      display: none;
    }
    .match-success.show { display: block; }
    .is-invalid-custom {
      border-color: #dc2626 !important;
      background-color: #fef2f2 !important;
    }
    .is-invalid-custom:focus {
      border-color: #dc2626 !important;
      box-shadow: 0 0 0 0.2rem rgba(220, 38, 38, 0.25) !important;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="register-card">
    <div class="register-header">
      <div class="brand-icon">
        <i class="bi bi-person-plus-fill"></i>
      </div>
      <h4 class="fw-bold mb-1">Create Tutor Account</h4>
      <p class="opacity-75 mb-0">Join TutorBooking and start teaching</p>
    </div>

    <div class="register-body">
      <c:if test="${not empty error}">
        <div class="alert alert-danger py-2">
          <i class="bi bi-exclamation-circle me-2"></i>${error}
        </div>
      </c:if>

      <form action="/tutor/register" method="post" id="registerForm">
        <p class="section-label">Personal Information</p>
        <div class="mb-3">
          <label class="form-label fw-semibold">Full Name</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-person"></i></span>
            <input type="text" name="name" class="form-control" placeholder="Dr. Jane Smith" required/>
          </div>
        </div>
        <div class="row g-3 mb-3">
          <div class="col-md-6">
            <label class="form-label fw-semibold">Email</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-envelope"></i></span>
              <input type="email" name="email" class="form-control"
                     placeholder="jane@example.com" required/>
            </div>
            <div class="form-text text-muted">
              <i class="bi bi-info-circle me-1"></i>We'll send a verification code to this email
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Phone</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-telephone"></i></span>
              <input type="text" name="phone" class="form-control" placeholder="07XXXXXXXX"/>
            </div>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock"></i></span>
            <input type="password" name="password" id="password" class="form-control" required minlength="8"
                   title="Password must be at least 8 characters" placeholder="Min. 8 characters"/>
            <button type="button" class="toggle-btn" id="togglePassword" title="Show password" tabindex="-1">
              <i class="bi bi-eye" id="toggleIcon"></i>
            </button>
          </div>
        </div>
        <div class="mb-3">
          <label class="form-label fw-semibold">Confirm Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required minlength="8"
                   placeholder="Repeat password"/>
            <button type="button" class="toggle-btn" id="toggleConfirmPassword" title="Show password" tabindex="-1">
              <i class="bi bi-eye" id="toggleIcon2"></i>
            </button>
          </div>
          <div class="match-error" id="matchError">
            <i class="bi bi-exclamation-circle me-1"></i>Passwords do not match
          </div>
          <div class="match-success" id="matchSuccess">
            <i class="bi bi-check-circle me-1"></i>Passwords match
          </div>
        </div>

        <p class="section-label">Teaching Details</p>
        <div class="row g-3 mb-3">
          <div class="mb-3">
            <label class="form-label">Subject</label>
            <select name="subject" class="form-control" required>
              <option value="" disabled selected>Select your subject</option>
              <c:forEach var="sub" items="${subjects}">
                <option value="${sub.subjectName}">${sub.subjectName}</option>
              </c:forEach>
            </select>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Qualification</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-award"></i></span>
              <input type="text" name="qualification" class="form-control" placeholder="e.g. M.Sc. Maths"/>
            </div>
          </div>
        </div>
        <div class="row g-3 mb-3">
          <div class="col-md-6">
            <label class="form-label fw-semibold">Location</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
              <input type="text" name="location" class="form-control" placeholder="e.g. Colombo, Sri Lanka"/>
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-semibold">Hourly Rate (LKR)</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-cash"></i></span>
              <input type="number" name="hourlyRate" class="form-control" placeholder="500.00" step="0.01" min="0" required/>
            </div>
          </div>
        </div>
        <div class="mb-4">
          <label class="form-label fw-semibold">Bio</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-file-text"></i></span>
            <textarea name="bio" class="form-control" rows="3"
                      placeholder="Tell students about your teaching experience…"></textarea>
          </div>
        </div>

        <button type="submit" class="btn btn-navy w-100" id="submitBtn">
          <i class="bi bi-person-check me-2"></i>Create Account
        </button>
      </form>
    </div>

    <div class="register-footer">
      <p class="mb-0 small text-muted">
        Already registered?
        <a href="/tutor/login" class="text-decoration-none fw-semibold" style="color: var(--navy);">Sign in</a>
      </p>
    </div>
  </div>
</div>

<script>
  (function() {
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const matchError = document.getElementById('matchError');
    const matchSuccess = document.getElementById('matchSuccess');
    const submitBtn = document.getElementById('submitBtn');
    const form = document.getElementById('registerForm');

    function checkMatch() {
      if (confirmPassword.value.length === 0) {
        matchError.classList.remove('show');
        matchSuccess.classList.remove('show');
        confirmPassword.classList.remove('is-invalid-custom');
        return;
      }
      if (password.value !== confirmPassword.value) {
        matchError.classList.add('show');
        matchSuccess.classList.remove('show');
        confirmPassword.classList.add('is-invalid-custom');
      } else {
        matchError.classList.remove('show');
        matchSuccess.classList.add('show');
        confirmPassword.classList.remove('is-invalid-custom');
      }
    }

    function validateForm(e) {
      if (password.value !== confirmPassword.value) {
        e.preventDefault();
        matchError.classList.add('show');
        confirmPassword.classList.add('is-invalid-custom');
        confirmPassword.focus();
        return false;
      }
      if (password.value.length < 8) {
        e.preventDefault();
        password.focus();
        return false;
      }
      return true;
    }

    password.addEventListener('input', checkMatch);
    confirmPassword.addEventListener('input', checkMatch);
    form.addEventListener('submit', validateForm);

    // Toggle functionality
    function setupToggle(btnId, inputId, iconId) {
      const btn = document.getElementById(btnId);
      const input = document.getElementById(inputId);
      const icon = document.getElementById(iconId);
      if (!btn || !input || !icon) return;
      btn.addEventListener('click', function() {
        const isPassword = input.type === 'password';
        input.type = isPassword ? 'text' : 'password';
        icon.className = isPassword ? 'bi bi-eye-slash' : 'bi bi-eye';
        btn.title = isPassword ? 'Hide password' : 'Show password';
      });
    }
    setupToggle('togglePassword', 'password', 'toggleIcon');
    setupToggle('toggleConfirmPassword', 'confirmPassword', 'toggleIcon2');
  })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>