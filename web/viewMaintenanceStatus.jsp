<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Maintenance Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('img/hostel_background.jpg'); /* Use your background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background-color: rgba(192, 57, 43, 0.9); /* Reddish background with transparency */
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            width: 100%;
            max-width: 900px; /* Slightly wider for the table */
            color: white;
            position: relative;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 30px;
            color: white;
        }

        .header-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .header-buttons .btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .header-buttons .btn:hover {
            background-color: white;
            color: #c0392b;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: rgba(255, 255, 255, 0.15); /* Slightly transparent background for table */
            border-radius: 10px;
            overflow: hidden; /* For rounded corners to apply to table */
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
        }

        th {
            background-color: rgba(255, 255, 255, 0.25);
            font-weight: bold;
            font-size: 18px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .no-records {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: rgba(255, 255, 255, 0.8);
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }
        .status-in_progress { /* Using underscore for consistency with potential enum/db values */
            color: lightblue;
            font-weight: bold;
        }
        .status-completed {
            color: lightgreen;
            font-weight: bold;
        }
        .status-rejected {
            color: #FF6347; /* Tomato */
            font-weight: bold;
        }

        .button-group {
            display: flex;
            justify-content: center; /* Center the back button */
            margin-top: 30px;
        }

        .button-group .btn {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid white;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
            text-align: center;
        }

        .button-group .btn:hover {
            background-color: white;
            color: #c0392b;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 0 15px;
            }
            h1 {
                font-size: 28px;
            }
            table, thead, tbody, th, td, tr {
                display: block; /* Make table elements act like block elements */
            }
            thead tr {
                position: absolute;
                top: -9999px; /* Hide table headers */
                left: -9999px;
            }
            tr {
                border: 1px solid rgba(255, 255, 255, 0.3);
                margin-bottom: 10px;
                border-radius: 8px;
                overflow: hidden;
            }
            td {
                border: none;
                position: relative;
                padding-left: 50%; /* Space for the pseudo-element label */
                text-align: right;
            }
            td:before {
                content: attr(data-label); /* Use data-label for content */
                position: absolute;
                left: 15px;
                width: calc(50% - 30px);
                padding-right: 10px;
                white-space: nowrap;
                font-weight: bold;
                text-align: left;
            }
            .header-buttons {
                position: static;
                text-align: right;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-buttons">
        <a href="requestMaintenance" class="btn">New Request</a> <%-- Link back to the request form --%>
    </div>

    <h1>Maintenance Status</h1>

    <c:if test="${not empty requestScope.message}">
        <div class="message ${requestScope.messageType == 'success' ? 'success' : 'error'}">
            ${requestScope.message}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty requestScope.maintenanceRequests}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${requestScope.maintenanceRequests}">
                        <tr>
                            <td data-label="ID">${req.mainID}</td>
                            <td data-label="Category">${req.mainCat}</td>
                            <td data-label="Description">${req.mainDescription}</td>
                            <td data-label="Date"><fmt:formatDate value="${req.mainDate}" pattern="yyyy-MM-dd"/></td>
                            <td data-label="Status">
                                <span class="status-${req.mainStatus.toLowerCase().replace(' ', '_')}">
                                    ${req.mainStatus}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="no-records">No maintenance requests found.</p>
        </c:otherwise>
    </c:choose>

    <div class="button-group">
        <a href="dashboard.jsp" class="btn">Back to Dashboard</a>
    </div>

</div>

</body>
</html>