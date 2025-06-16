<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Staff Maintenance Requests</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: #fce8e6; /* light pink background */
            padding: 40px 20px;
        }

        h1 {
            color: #8b0000; /* dark red */
            text-align: center;
        }

        table {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto 0;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            font-size: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background-color: #8b0000;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #fdf2f1;
        }

        tr:hover {
            background-color: #f5d7d5;
        }

        .no-records {
            text-align: center;
            color: #8b0000;
            font-weight: bold;
            margin-top: 20px;
        }

        .error-message {
            color: #b30000;
            font-weight: bold;
            text-align: center;
            margin-top: 10px;
        }

        .success-message {
            color: #155724;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            margin: 10px auto;
            max-width: 600px;
        }

        .update-form {
            text-align: center;
            margin-top: 10px;
        }

        .update-form select,
        .update-form button {
            padding: 8px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .update-form button {
            background-color: #8b0000;
            color: white;
            border: none;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .update-form button:hover {
            background-color: #a51414;
        }

        .back-button {
            text-align: center;
            margin-top: 40px;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 25px;
            background-color: #8b0000;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-back:hover {
            background-color: #a51414;
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

    <div class="back-button">
        <a href="staffDashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>
</body>
</html>
