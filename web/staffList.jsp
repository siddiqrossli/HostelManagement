<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Staff List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
            color: #333;
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

<p style="text-align:center; margin-top:20px;"><a href="staffDashboard.jsp">Back to Dashboard</a></p>

</body>
</html>
