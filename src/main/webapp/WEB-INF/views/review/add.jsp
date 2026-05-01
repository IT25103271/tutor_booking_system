<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Review</title>
</head>
<body>

<h2>Submit Tutor Review</h2>

<form action="${pageContext.request.contextPath}/reviews/save" method="post">

    <label>Student Name:</label><br>
    <input type="text" name="studentName" required><br><br>

    <label>Tutor Name:</label><br>
    <input type="text" name="tutorName" required><br><br>

    <label>Rating:</label><br>
    <select name="rating" required>
        <option value="">Select Rating</option>
        <option value="1">1 - Poor</option>
        <option value="2">2 - Fair</option>
        <option value="3">3 - Good</option>
        <option value="4">4 - Very Good</option>
        <option value="5">5 - Excellent</option>
    </select><br><br>

    <label>Comment:</label><br>
    <textarea name="comment" rows="5" cols="40" required></textarea><br><br>

    <button type="submit">Submit Review</button>

</form>

<br>

<a href="${pageContext.request.contextPath}/reviews/list">View All Reviews</a>

</body>
</html>
