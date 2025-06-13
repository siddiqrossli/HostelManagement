<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // --- ADD THESE DEBUG PRINTS ---
    HttpSession currentDashboardSession = request.getSession(false); // Get existing session, don't create new
    System.out.println("--- Dashboard.jsp Debug ---");
    if (currentDashboardSession != null) {
        System.out.println("Dashboard.jsp loaded. Session ID: " + currentDashboardSession.getId());
        System.out.println("Session attribute 'studentId': " + currentDashboardSession.getAttribute("studentId"));
        System.out.println("Session attribute 'studentName': " + currentDashboardSession.getAttribute("studentName"));
    } else {
        System.out.println("Dashboard.jsp loaded. WARNING: Session is NULL!");
    }
    System.out.println("--------------------------");
    // --- END DEBUG PRINTS ---
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
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
    <h1>Welcome, ${sessionScope.studentName}</h1> <%-- Using sessionScope for welcome message --%>
    <ul>
        <li><a href="updateProfile">Update Profile</a></li>
        <li><a href="changePassword">Change Password</a></li>
        <li><a href="ApplyCollegeServlet">Apply College</a></li>
        <li><a href="requestMaintenance">Request Maintenance</a></li> <%-- Link to servlet --%>
        <li><a href="viewBills.jsp">View Bills</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>