<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Subject | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: linear-gradient(135deg, #1a1a2e, #16213e); padding: 1rem 2rem; border-bottom: 2px solid #e94560; }
        .navbar-brand { color: white; font-weight: 700; }
        .card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); overflow: hidden; }
        .card-header { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); color: white; padding: 2rem; border-bottom: 4px solid #e94560; }
        .form-label { font-weight: 600; color: #4b5563; margin-bottom: 0.5rem; }
        .form-control, .form-select { border-radius: 12px; padding: 0.75rem 1rem; border: 1px solid #e5e7eb; transition: 0.3s; }
        .form-control:focus, .form-select:focus { box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1); border-color: #e94560; }
        .btn-custom { border-radius: 12px; padding: 0.8rem 2rem; font-weight: 600; transition: 0.3s; }
        .btn-primary-custom { background: #e94560; color: white; border: none; }
        .btn-primary-custom:hover { background: #d63d56; color: white; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(233, 69, 96, 0.3); }
        .footer {
            background: #1a1a2e;
            color: rgba(255,255,255,0.7);
            padding: 3rem 0 2rem;
            margin-top: 4rem;
            border-top: 2px solid #e94560;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm px-4">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-shield-lock-fill me-2 fs-2 text-danger"></i>
            <span class="fs-4 fw-bolder">Admin Dashboard</span>
        </a>
        <div class="ms-auto d-flex align-items-center">
            <span class="text-white me-4 d-flex align-items-center">
                <i class="bi bi-person-circle me-2 fs-5"></i>
                <span class="fw-semibold">${sessionScope.adminName}</span>
            </span>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i>Logout
            </a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header text-center">
                    <h2 class="fw-bold mb-0">Edit Subject</h2>
                    <p class="text-white-50 mt-2 mb-0">Update subject details for ID: #${subject.id}</p>
                </div>
                <div class="card-body p-4 p-md-5">
                    <form action="${pageContext.request.contextPath}/subject/edit" method="post">
                        <input type="hidden" name="subjectId" value="${subject.id}">
                        
                        <div class="row g-4">
                            <div class="col-md-12">
                                <label class="form-label">Subject Name</label>
                                <input type="text" name="subjectName" class="form-control" value="${subject.subjectName}" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Category</label>
                                <select name="category" class="form-select" required>
                                    <option value="Mathematics" ${subject.category == 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                                    <option value="Science" ${subject.category == 'Science' ? 'selected' : ''}>Science</option>
                                    <option value="Languages" ${subject.category == 'Languages' ? 'selected' : ''}>Languages</option>
                                    <option value="Commerce" ${subject.category == 'Commerce' ? 'selected' : ''}>Commerce</option>
                                    <option value="Arts" ${subject.category == 'Arts' ? 'selected' : ''}>Arts</option>
                                    <option value="IT" ${subject.category == 'IT' ? 'selected' : ''}>Information Technology</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Grade Level</label>
                                <select name="gradeLevel" class="form-select" required>
                                    <option value="Grade 6-9" ${subject.gradeLevel == 'Grade 6-9' ? 'selected' : ''}>Grade 6-9</option>
                                    <option value="O/L" ${subject.gradeLevel == 'O/L' ? 'selected' : ''}>O/L (Ordinary Level)</option>
                                    <option value="A/L" ${subject.gradeLevel == 'A/L' ? 'selected' : ''}>A/L (Advanced Level)</option>
                                    <option value="Undergraduate" ${subject.gradeLevel == 'Undergraduate' ? 'selected' : ''}>Undergraduate</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4">${subject.description}</textarea>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Status</label>
                                <div class="d-flex gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="status" id="statusActive" value="Active" ${subject.status == 'Active' ? 'checked' : ''}>
                                        <label class="form-check-label" for="statusActive">Active</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="status" id="statusInactive" value="Inactive" ${subject.status == 'Inactive' ? 'checked' : ''}>
                                        <label class="form-check-label" for="statusInactive">Inactive</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 mt-5">
                                <div class="d-flex gap-3">
                                    <button type="submit" class="btn btn-primary-custom btn-custom flex-grow-1">
                                        <i class="bi bi-check-circle-fill me-2"></i>Update Subject
                                    </button>
                                    <a href="${pageContext.request.contextPath}/subject/list" class="btn btn-outline-secondary btn-custom px-4">
                                        Cancel
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container text-center">
        <p class="mb-2 fw-bold text-white">Tutor Booking System | Admin Portal</p>
        <p class="mb-0 opacity-50 small">&copy; 2026 WD204 | SLIIT | System Version 2.4.0</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
