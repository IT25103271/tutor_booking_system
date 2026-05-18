<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% request.setAttribute("activePage", "bookings"); %>
<% request.setAttribute("pageTitle", "Add Review"); %>
<% request.setAttribute("pageIcon", "star"); %>
<%@ include file="../layout/student-layout.jsp" %>

<style>
    .review-card {
        border: 1px solid #e8ebf0; border-radius: 18px; background: white;
        box-shadow: 0 4px 24px rgba(79,110,247,0.08);
    }
    .tutor-icon-lg {
        width: 80px; height: 80px; border-radius: 50%;
        background: #eef0fe; color: var(--primary);
        display: flex; align-items: center; justify-content: center;
        font-size: 2.25rem; margin: 0 auto 1rem;
        border: 3px solid #c7d0fb;
    }

    .star-rating {
        display: flex; flex-direction: row-reverse;
        justify-content: center; gap: 0.4rem;
    }
    .star-rating input { display: none; }
    .star-rating label {
        font-size: 2.4rem; color: #e2e8f0; cursor: pointer; transition: color 0.15s;
    }
    .star-rating input:checked ~ label,
    .star-rating label:hover,
    .star-rating label:hover ~ label {
        color: #f59e0b;
    }

    .form-label { font-weight: 600; color: #475569; font-size: 0.85rem; margin-bottom: 7px; }
    .form-control {
        border-radius: 11px; padding: 11px 14px;
        border: 1px solid #dde3f0; background: #f8faff; font-size: 0.9rem;
        transition: all 0.25s;
    }
    .form-control:focus {
        border-color: var(--primary); background: #fff;
        box-shadow: 0 0 0 3px rgba(79,110,247,0.12);
    }

    .btn-submit-review {
        background: linear-gradient(135deg, var(--primary), var(--primary2));
        color: white; border: none; border-radius: 11px;
        font-weight: 700; padding: 0.7rem 2rem; transition: all 0.25s;
        box-shadow: 0 4px 14px rgba(79,110,247,0.26);
    }
    .btn-submit-review:hover {
        background: linear-gradient(135deg, var(--primary2), #2d4ad0);
        color: white; transform: translateY(-2px);
    }
    .btn-back-review { border: 1px solid #dde3f0; color: #64748b; border-radius: 10px; padding: 0.6rem 1.25rem; transition: all 0.2s; background: #fff; font-weight: 600; }
    .btn-back-review:hover { background: #f1f4ff; border-color: var(--primary); color: var(--primary); }
    .rating-hint { font-size: 0.78rem; color: #94a3b8; margin-top: 6px; }
</style>

<div class="row justify-content-center">
    <div class="col-lg-6">
        <h3 class="fw-bold mb-4" style="color:var(--primary);">
            <i class="bi bi-star me-2 text-primary"></i>Rate Your Experience
        </h3>
        <div class="review-card">
            <div class="p-4 p-md-5">
                <div class="text-center mb-4">
                    <div class="tutor-icon-lg"><i class="bi bi-person-fill"></i></div>
                    <h5 class="fw-bold mb-1" style="color:#1e293b;">${tutor.name}</h5>
                    <p class="text-muted small mb-0">${tutor.subject}</p>
                </div>

                <form action="${pageContext.request.contextPath}/student/add-review" method="post">
                    <input type="hidden" name="bookingId" value="${booking.id}">

                    <div class="mb-4 text-center">
                        <label class="form-label d-block mb-2">How would you rate your session?</label>
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5" required>
                            <label for="star5"><i class="bi bi-star-fill"></i></label>
                            <input type="radio" id="star4" name="rating" value="4">
                            <label for="star4"><i class="bi bi-star-fill"></i></label>
                            <input type="radio" id="star3" name="rating" value="3">
                            <label for="star3"><i class="bi bi-star-fill"></i></label>
                            <input type="radio" id="star2" name="rating" value="2">
                            <label for="star2"><i class="bi bi-star-fill"></i></label>
                            <input type="radio" id="star1" name="rating" value="1">
                            <label for="star1"><i class="bi bi-star-fill"></i></label>
                        </div>
                        <p class="rating-hint">Click a star to rate your experience</p>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Your Review</label>
                        <textarea name="comment" class="form-control" rows="4"
                                  placeholder="Share your experience with this tutor..." required></textarea>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/student/my-bookings"
                           class="btn btn-back-review text-decoration-none">
                            <i class="bi bi-arrow-left me-2"></i>Back
                        </a>
                        <button type="submit" class="btn btn-submit-review">
                            <i class="bi bi-send me-2"></i>Submit Review
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layout/student-layout-footer.jsp" %>