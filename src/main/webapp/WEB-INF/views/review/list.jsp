<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Review List</title>
</head>
<body>

<h2>All Reviews</h2>

<a href="${pageContext.request.contextPath}/reviews/add">Add New Review</a>

<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Student Name</th>
        <th>Tutor Name</th>
        <th>Rating</th>
        <th>Comment</th>
        <th>Action</th>
    </tr>

    <c:forEach var="review" items="${reviews}">
        <tr>
            <td>${review.id}</td>
            <td>${review.studentName}</td>
            <td>${review.tutorName}</td>
            <td>${review.rating}</td>
            <td>${review.comment}</td>
            <td>
                <a href="${pageContext.request.contextPath}/reviews/delete/${review.id}">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
