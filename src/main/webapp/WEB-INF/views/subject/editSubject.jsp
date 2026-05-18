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