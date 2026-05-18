<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("activePage", "subjects"); %>
<% request.setAttribute("pageTitle", "Add Subject"); %>
<%@ include file="../layout/admin_layout.jsp" %>

<style>
    .form-label-custom { font-size:0.75rem;font-weight:600;letter-spacing:0.6px;text-transform:uppercase;color:#6c757d; }
    .required { color:#dc3545; }
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
        <span><i class="bi bi-plus-circle me-2"></i>Add New Subject</span>
    </div>
    <div class="card-body p-4">
        <p class="text-muted mb-4" style="font-size:0.88rem;">Fill in the details below to register a new subject.</p>
        <form action="${pageContext.request.contextPath}/subject/add" method="post">
            <div class="mb-3">
                <label class="form-label form-label-custom">Subject Name <span class="required">*</span></label>
                <input type="text" name="subjectName" class="form-control"
                       placeholder="e.g. Combined Mathematics" required/>
            </div>
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label form-label-custom">Category <span class="required">*</span></label>
                    <select name="category" class="form-select" required>
                        <option value="" disabled selected>Select category…</option>
                        <option>Mathematics</option>
                        <option>Science</option>
                        <option>Languages</option>
                        <option>Social Studies</option>
                        <option>ICT</option>
                        <option>Commerce</option>
                        <option>Arts</option>
                        <option>Other</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label form-label-custom">Grade Level <span class="required">*</span></label>
                    <select name="gradeLevel" class="form-select" required>
                        <option value="" disabled selected>Select grade…</option>
                        <option>Grade 1-5</option>
                        <option>Grade 6-9</option>
                        <option>Grade 10-11 (O/L)</option>
                        <option>Grade 12-13 (A/L)</option>
                        <option>All Grades</option>
                    </select>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label form-label-custom">Description</label>
                <textarea name="description" class="form-control" rows="3" placeholder="Brief description…"></textarea>
            </div>
            <div class="mb-4">
                <label class="form-label form-label-custom">Status <span class="required">*</span></label>
                <select name="status" class="form-select" required>
                    <option value="Active" selected>Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/subject/list" class="btn btn-secondary flex-fill">Cancel</a>
                <button type="submit" class="btn btn-primary flex-fill">
                    <i class="bi bi-check-lg me-1"></i>Add Subject
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="../layout/admin_layout-footer.jsp" %>
