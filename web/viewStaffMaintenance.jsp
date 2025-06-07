<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Staff Maintenance Requests</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        h1 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #007bff; color: white; }
        .no-records { text-align: center; color: #555; margin-top: 20px; }
        .error-message { color: red; font-weight: bold; }
        .success-message { color: green; font-weight: bold; }
        .update-form select, .update-form button {
            padding: 5px;
            margin-right: 5px;
            border-radius: 3px;
            border: 1px solid #ccc;
        }
        .update-form button {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        .update-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h1>Assigned Maintenance Requests</h1>

    <c:if test="${not empty message}">
        <p class="${messageType == 'error' ? 'error-message' : 'success-message'}">${message}</p>
    </c:if>

    <c:choose>
        <c:when test="${not empty maintenanceRequests}">
            <table>
                <thead>
                    <tr>
                        <th>Maintenance ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Student Name</th>
                        <th>Room ID</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${maintenanceRequests}">
                        <tr>
                            <td>${req.mainID}</td>
                            <td>${req.mainCat}</td>
                            <td>${req.mainDescription}</td>
                            <td><fmt:formatDate value="${req.mainDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${req.mainStatus}</td>
                            <td>${req.studentName}</td>
                            <td>${req.roomID}</td>
                            <td>
                                <form action="UpdateMaintenanceStatusServlet" method="post" class="update-form">
                                    <input type="hidden" name="mainID" value="${req.mainID}" />
                                    <select name="newStatus">
                                        <option value="Pending" <c:if test="${req.mainStatus == 'Pending'}">selected</c:if>>Pending</option>
                                        <option value="In Progress" <c:if test="${req.mainStatus == 'In Progress'}">selected</c:if>>In Progress</option>
                                        <option value="Completed" <c:if test="${req.mainStatus == 'Completed'}">selected</c:if>>Completed</option>
                                    </select>
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="no-records">No maintenance requests assigned to you.</p>
        </c:otherwise>
    </c:choose>

    <p><a href="staffDashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
