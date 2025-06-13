<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("staffId") == null) {
        response.sendRedirect("staffLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        h1 { color: #333; }
        ul { list-style-type: none; padding: 0; }
        li { margin-bottom: 10px; }
        a { text-decoration: none; color: #007bff; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>Welcome, <%= session.getAttribute("staffName") %></h1>
    <ul>
        <li><a href="updateStaffProfile">Update Profile</a></li>
        <li><a href="staffChangePassword">Change Password</a></li>
        <li><a href="staffList">View Staff</a></li>
        <li><a href="roomList">View Room</a></li>
        <li><a href="viewStaffMaintenance">View Maintenance Requests</a></li>
        <li><a href="ViewAppealServlet">View Appeal Requests</a></li>
    </ul>
</body>
</html>