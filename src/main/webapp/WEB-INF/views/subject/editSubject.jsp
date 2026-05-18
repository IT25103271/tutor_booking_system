<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tutorsystem.model.Subject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Subject</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #f0f2f5; font-family: 'Inter', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background: #0f1f3d; padding: 0 2rem; height: 56px; display: flex; align-items: center; justify-content: space-between; }
        .navbar-brand { color: #fff; font-size: 1rem; font-weight: 600; }
        .navbar-right { display: flex; align-items: center; gap: 1rem; }
        .navbar-user { color: #cbd5e1; font-size: .9rem; }
        .btn-logout { color: #fff; border: 1px solid #fff; background: transparent; padding: .35rem .9rem; border-radius: 6px; font-size: .85rem; text-decoration: none; }
        main { max-width: 750px; margin: 2.5rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .back-link { color: #64748b; text-decoration: none; font-size: .9rem; display: inline-flex; align-items: center; gap: .4rem; margin-bottom: 1.5rem; }
        .back-link:hover { color: #0f1f3d; }
        .card { background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 2.5rem; }
        .card h2 { font-size: 1.2rem; font-weight: 700; color: #0f1f3d; margin-bottom: .3rem; }
        .card p.sub { color: #64748b; font-size: .88rem; margin-bottom: 1.5rem; }
        .id-badge { display: inline-block; background: #eff6ff; color: #1d4ed8; border: 1px solid #bfdbfe; padding: .3rem .9rem; border-radius: 20px; font-size: .8rem; font-weight: 600; margin-bottom: 1.8rem; font-family: monospace; }
        .form-group { margin-bottom: 1.3rem; }
        label { display: block; font-size: .75rem; font-weight: 600; letter-spacing: .6px; text-transform: uppercase; color: #64748b; margin-bottom: .5rem; }
        input[type="text"], select, textarea { width: 100%; background: #f8fafc; border: 1px solid #dde1e7; border-radius: 8px; color: #1e293b; padding: .75rem 1rem; font-size: .9rem; font-family: 'Inter', sans-serif; outline: none; transition: border-color .2s; }
        input:focus, select:focus, textarea:focus { border-color: #0f1f3d; background: #fff; }
        textarea { resize: vertical; min-height: 90px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .btn-row { display: flex; gap: 1rem; margin-top: 1rem; }
        .btn-submit { flex: 1; background: #0f1f3d; color: #fff; border: none; padding: .85rem; border-radius: 8px; font-size: .95rem; font-weight: 600; cursor: pointer; font-family: 'Inter', sans-serif; }
        .btn-submit:hover { background: #1a3260; }
        .btn-cancel { flex: 1; background: #f1f5f9; color: #64748b; border: none; padding: .85rem; border-radius: 8px; font-size: .95rem; font-weight: 600; text-decoration: none; text-align: center; font-family: 'Inter', sans-serif; line-height: 1.4; }
        .required { color: #dc2626; }
        footer { background: #0f1117; color: #94a3b8; margin-top: 4rem; }
        .footer-grid { max-width: 1100px; margin: 0 auto; padding: 3rem 1.5rem; display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 2rem; }
        .footer-brand h3 { color: #fff; font-size: 1.1rem; margin-bottom: .8rem; }
        .footer-brand p { font-size: .85rem; line-height: 1.7; }
        .footer-col h4 { color: #fff; font-size: .75rem; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 1rem; }
        .footer-col ul { list-style: none; display: flex; flex-direction: column; gap: .6rem; }
        .footer-col ul a { color: #94a3b8; text-decoration: none; font-size: .9rem; }
        .footer-col p { font-size: .85rem; line-height: 1.7; }
        .footer-col .address-title { font-size: .85rem; font-weight: 600; color: #fff; margin-bottom: .4rem; }
        .footer-col .meet-link { color: #38bdf8; font-size: .85rem; text-decoration: none; display: inline-block; margin-top: .6rem; }
        .footer-bottom { border-top: 1px solid #1e293b; padding: 1rem 1.5rem; text-align: center; font-size: .8rem; }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-brand">📚 Subject Management</div>
    <div class="navbar-right">
        <span class="navbar-user">👤 Admin</span>
        <a href="#" class="btn-logout">↩ Logout</a>
    </div>
</nav>
<main>
    <a href="${pageContext.request.contextPath}/subject/list" class="back-link">← Back to Subject List</a>
    <% Subject s = (Subject) request.getAttribute("subject"); %>
    <div class="card">
        <h2>✏️ Edit Subject</h2>
        <p class="sub">Update the details for this subject.</p>
        <div class="id-badge">ID: <%= s.getId() %></div>
        <form action="${pageContext.request.contextPath}/subject/edit" method="post">
            <input type="hidden" name="subjectId" value="<%= s.getId() %>"/>
            <div class="form-group">
                <label>Subject Name <span class="required">*</span></label>
                <input type="text" name="subjectName" value="<%= s.getSubjectName() %>" required/>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>Category <span class="required">*</span></label>
                    <select name="category" required>
                        <% String[] cats = {"Mathematics","Science","Languages","Social Studies","ICT","Commerce","Arts","Other"};
                           for (String cat : cats) { %>
                            <option <%= s.getCategory().equals(cat) ? "selected" : "" %>><%= cat %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label>Grade Level <span class="required">*</span></label>
                    <select name="gradeLevel" required>
                        <% String[] grades = {"Grade 1-5","Grade 6-9","Grade 10-11 (O/L)","Grade 12-13 (A/L)","All Grades"};
                           for (String g : grades) { %>
                            <option <%= s.getGradeLevel().equals(g) ? "selected" : "" %>><%= g %></option>
                        <% } %>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description"><%= s.getDescription() %></textarea>
            </div>
            <div class="form-group">
                <label>Status <span class="required">*</span></label>
                <select name="status" required>
                    <option <%= s.getStatus().equalsIgnoreCase("Active")   ? "selected" : "" %>>Active</option>
                    <option <%= s.getStatus().equalsIgnoreCase("Inactive") ? "selected" : "" %>>Inactive</option>
                </select>
            </div>
            <div class="btn-row">
                <a href="${pageContext.request.contextPath}/subject/list" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">💾 Save Changes</button>
            </div>
        </form>
    </div>
</main>
<footer>
    <div class="footer-grid">
        <div class="footer-brand">
            <h3>🎓 Tutor Booking</h3>
            <p>This is a academic project developed for<br/>
            <strong style="color:#fff;">SE1020 – OOP Module at SLIIT</strong> by Group WD204</p>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Find Tutors</a></li>
                <li><a href="#">My Bookings</a></li>
                <li><a href="#">Profile</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Us</h4>
            <p class="address-title">Address</p>
            <p>SLIIT, New Kandy Road, Malabe,<br/>Colombo, Sri Lanka</p>
            <a href="#" class="meet-link">ⓘ Meet at the university premises</a>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2026 WD204 | SLIIT | All Rights Reserved</p>
    </div>
</footer>
</body>
</html>
=======
a<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "subjects"); %>
<% request.setAttribute("pageTitle", "Edit Subject"); %>
<%@ include file="../layout/admin_layout.jsp" %>

<style>
    .form-label-custom { font-size:0.75rem;font-weight:600;letter-spacing:0.6px;text-transform:uppercase;color:#6c757d; }
    .required { color:#dc3545; }
    .id-badge { display:inline-block;background:#eff6ff;color:#1d4ed8;border:1px solid #bfdbfe;padding:.3rem .9rem;border-radius:20px;font-size:.8rem;font-weight:600;font-family:monospace; }
</style>

<!-- Alerts -->
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible mb-3">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>



<div class="card mx-auto" style="max-width:750px;">
    <div class="card-header-custom">
        <span><i class="bi bi-pencil me-2"></i>Edit Subject</span>
        <span class="id-badge">ID: ${subject.id}</span>
    </div>
    <div class="card-body p-4">
        <p class="text-muted mb-4" style="font-size:0.88rem;">Update the details for this subject.</p>
        <form action="${pageContext.request.contextPath}/subject/edit" method="post">
            <input type="hidden" name="subjectId" value="${subject.id}"/>
            <div class="mb-3">
                <label class="form-label form-label-custom">Subject Name <span class="required">*</span></label>
                <input type="text" name="subjectName" class="form-control"
                       value="${subject.subjectName}" required/>
            </div>
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label form-label-custom">Category <span class="required">*</span></label>
                    <select name="category" class="form-select" required>
                        <c:forEach var="cat" items="${['Mathematics','Science','Languages','Social Studies','ICT','Commerce','Arts','Other']}">
                            <option ${subject.category == cat ? 'selected' : ''}>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label form-label-custom">Grade Level <span class="required">*</span></label>
                    <select name="gradeLevel" class="form-select" required>
                        <c:forEach var="g" items="${['Grade 1-5','Grade 6-9','Grade 10-11 (O/L)','Grade 12-13 (A/L)','All Grades']}">
                            <option ${subject.gradeLevel == g ? 'selected' : ''}>${g}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label form-label-custom">Description</label>
                <textarea name="description" class="form-control" rows="3">${subject.description}</textarea>
            </div>
            <div class="mb-4">
                <label class="form-label form-label-custom">Status <span class="required">*</span></label>
                <select name="status" class="form-select" required>
                    <option ${subject.status == 'Active' ? 'selected' : ''}>Active</option>
                    <option ${subject.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/subject/list" class="btn btn-secondary flex-fill">Cancel</a>
                <button type="submit" class="btn btn-primary flex-fill">
                    <i class="bi bi-floppy me-1"></i>Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../layout/admin_layout-footer.jsp" %>
>>>>>>> Stashed changes
