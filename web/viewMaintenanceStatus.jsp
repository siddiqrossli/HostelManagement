<%-- In viewMaintenanceStatus.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.MaintenanceRequest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Maintenance Status</title>
    <style>
        /* Your existing CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #d15656; /* Reddish background */
        }
        .container {
            background-color: #a83a3a; /* Darker red for the container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1000px; /* Increased max-width */
            color: #fff;
            text-align: center;
        }
        h2 {
            color: #fff;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #c74c4c; /* Lighter red for borders */
            color: #fff;
        }
        th {
            background-color: #8f2f2f; /* Even darker red for headers */
        }
        tr:nth-child(even) {
            background-color: #9c3636; /* Slightly different background for even rows */
        }
        .status-pending {
            color: #ffcc00; /* Yellow for pending */
            font-weight: bold;
        }
        .status-in-progress {
            color: #00bfff; /* Light blue for in progress */
            font-weight: bold;
        }
        .status-completed {
            color: #66ff66; /* Green for completed */
            font-weight: bold;
        }
        .status-rejected {
            color: #ff6666; /* Red for rejected */
            font-weight: bold;
        }
        .back-button {
            background-color: #555;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 30px;
            display: inline-block;
        }
        .back-button:hover {
            background-color: #777;
        }
        .new-request-button {
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            float: right;
            margin-bottom: 15px;
        }
        .new-request-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="requestMaintenance.jsp" class="new-request-button">New Request</a>
        <h2>Maintenance Status</h2>

        <%
            List<MaintenanceRequest> maintenanceRequests = (List<MaintenanceRequest>) request.getAttribute("maintenanceRequests");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        %>

        <% if (maintenanceRequests == null || maintenanceRequests.isEmpty()) { %>
            <p>No maintenance requests found.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Assigned Staff</th>
                        <th>Staff Number</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (MaintenanceRequest req : maintenanceRequests) { %>
                        <tr>
                            <td><%= req.getMainID() %></td>
                            <td><%= req.getMainCat() %></td>
                            <td><%= req.getMainDescription() %></td>
                            <td><%= dateFormat.format(req.getMainDate()) %></td>
                            <td><%= req.getStaffName() != null ? req.getStaffName() : "N/A" %></td>
                            <td><%= req.getStaffNumber() != null ? req.getStaffNumber() : "N/A" %></td>
                            <td><span class="status-<%= req.getMainStatus().toLowerCase().replace(" ", "-") %>"><%= req.getMainStatus() %></span></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>
    </div>
</body>
</html>