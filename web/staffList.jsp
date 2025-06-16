<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Staff List</title>
    <style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        background-color: #fce8e6;
        padding: 40px 20px;
    }

    h2 {
        text-align: center;
        color: #8b0000;
        margin-bottom: 30px;
    }

    .table-container {
        max-width: 700px; /* reduced width */
        margin: 0 auto;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        padding: 20px;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
    }

    th, td {
        padding: 12px 15px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }

    th {
        background-color: #8b0000;
        color: #fff;
        position: sticky;
        top: 0;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .back-link {
        text-align: center;
        margin-top: 30px;
    }

    .back-link a {
        text-decoration: none;
        color: #8b0000;
        font-weight: bold;
    }

    .back-link a:hover {
        text-decoration: underline;
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

<h2>Staff List</h2>

<table>
    <thead>
        <tr>
            <th>Staff ID</th>
            <th>Name</th>
            <th>Phone Number</th>
            <th>Email</th>
            <th>Position</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="staff" items="${staffList}">
            <tr>
                <td>${staff.staffID}</td>
                <td>${staff.staffName}</td>
                <td>${staff.staffNumber}</td>
                <td>${staff.staffEmail}</td>
                <td>${staff.staffPosition}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<div class="back-button">
        <a href="staffDashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>

</body>
</html> 