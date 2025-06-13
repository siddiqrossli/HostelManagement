<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.StudentAppeal"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Appeals - Staff View</title>
    <style>
        :root {
            --primary-color: #1976D2;
            --secondary-color: #455A64;
            --success-color: #4CAF50;
            --warning-color: #FFC107;
            --danger-color: #F44336;
            --info-color: #2196F3;
            --light-bg: #f5f7fa;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', sans-serif;
        }
        
        body {
            background-color: var(--light-bg);
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .header h1 {
            color: var(--secondary-color);
            font-size: 2.2rem;
            margin-bottom: 10px;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
        }
        
        .alert-success {
            background-color: rgba(76, 175, 80, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }
        
        .alert-danger {
            background-color: rgba(244, 67, 54, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }
        
        .alert-info {
            background-color: rgba(33, 150, 243, 0.1);
            color: var(--info-color);
            border-left: 4px solid var(--info-color);
        }
        
        .appeals-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            box-shadow: var(--card-shadow);
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }
        
        .appeals-table th, 
        .appeals-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .appeals-table th {
            background-color: var(--secondary-color);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        
        .appeals-table tr:last-child td {
            border-bottom: none;
        }
        
        .appeals-table tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        .status {
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
        }
        
        .status-pending {
            color: var(--warning-color);
            background-color: rgba(255, 193, 7, 0.1);
        }
        
        .status-approved {
            color: var(--success-color);
            background-color: rgba(76, 175, 80, 0.1);
        }
        
        .status-rejected {
            color: var(--danger-color);
            background-color: rgba(244, 67, 54, 0.1);
        }
        
        .status-under-review {
            color: var(--info-color);
            background-color: rgba(33, 150, 243, 0.1);
        }
        
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: var(--card-shadow);
            margin: 30px 0;
        }
        
        .empty-state p {
            color: #666;
            margin-bottom: 25px;
            font-size: 1.1rem;
        }
        
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #1565C0;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(25, 118, 210, 0.3);
        }
        
        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }
        
        .btn-secondary:hover {
            background-color: #37474F;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(69, 90, 100, 0.3);
        }

        .btn-success {
            background-color: var(--success-color);
            color: white;
        }

        .btn-success:hover {
            background-color: #388E3C;
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #D32F2F;
        }

        .appeal-actions form {
            display: inline-block;
            margin-right: 5px; /* Space between buttons */
        }
        
        @media (max-width: 768px) {
            .appeals-table {
                display: block;
                overflow-x: auto; /* Makes table scrollable on small screens */
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
            }

            .appeal-actions {
                white-space: nowrap; /* Prevent buttons from wrapping awkwardly */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>College Appeals - Staff View</h1>
            <p>Review and manage student appeals</p>
        </div>

        <%-- Message Display --%>
        <%
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && !message.isEmpty()) {
        %>
            <div class="alert alert-<%= messageType %>">
                <%= message %>
            </div>
        <%
            }
        %>

        <%
            List<StudentAppeal> appealList = (List<StudentAppeal>) request.getAttribute("appealList");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            if (appealList == null || appealList.isEmpty()) {
        %>
            <div class="empty-state">
                <h2>No Appeals Found</h2>
                <p>There are no appeals to review at this moment.</p>
                <div class="action-buttons">
                    <a href="staffDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </div>
        <%
            } else {
        %>
            <table class="appeals-table">
                <thead>
                    <tr>
                        <th>Appeal ID</th> <%-- Displaying Appeal ID for staff --%>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Student Number</th>
                        <th>CGPA</th>
                        <th>Household Income</th>
                        <th>Reason</th>
                        <th>Date Submitted</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (StudentAppeal appeal : appealList) {
                            String statusClass = "";
                            String currentStatus = appeal.getAppealStatus() != null ? appeal.getAppealStatus().toLowerCase() : "";
                            
                            if (currentStatus.equals("pending")) {
                                statusClass = "status-pending";
                            } else if (currentStatus.equals("approved")) {
                                statusClass = "status-approved";
                            } else if (currentStatus.equals("rejected")) {
                                statusClass = "status-rejected";
                            } else if (currentStatus.equals("under review")) {
                                statusClass = "status-under-review";
                            } else {
                                statusClass = "";
                            }
                    %>
                    <tr>
                        <td><%= appeal.getAppealID() %></td>
                        <td><%= appeal.getStudentID() != null ? appeal.getStudentID() : "N/A" %></td>
                        <td><%= appeal.getStudName() != null ? appeal.getStudName() : "N/A" %></td>
                        <td><%= appeal.getStudNumber() != null ? appeal.getStudNumber() : "N/A" %></td>
                        <td><%= String.format("%.2f", appeal.getStudCGPA()) %></td>
                        <td>RM <%= String.format("%,.2f", appeal.getHouseIncome()) %></td>
                        <td><%= appeal.getAppealReason() != null ? appeal.getAppealReason() : "N/A" %></td>
                        <td><%= appeal.getAppealDate() != null ? sdf.format(appeal.getAppealDate()) : "N/A" %></td>
                        <td><span class="status <%= statusClass %>"><%= currentStatus != null ? currentStatus : "N/A" %></span></td>
                        <td class="appeal-actions">
        <% if (currentStatus.equals("pending") || currentStatus.equals("under review")) { %>
        <form action="UpdateAppealStatusServlet" method="post" style="display:inline;">
            <input type="hidden" name="appealID" value="<%= appeal.getAppealID() %>">
            <input type="hidden" name="newStatus" value="approved">
            <button type="submit" class="btn btn-success btn-sm">Accept</button>
        </form>
        <form action="UpdateAppealStatusServlet" method="post" style="display:inline;">
            <input type="hidden" name="appealID" value="<%= appeal.getAppealID() %>">
            <input type="hidden" name="newStatus" value="rejected">
            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
        </form>
    <% } else { %>
        No Actions
    <% } %>
</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            
            <div class="action-buttons">
                <a href="staffDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>