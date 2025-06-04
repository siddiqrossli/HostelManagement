<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Student Dashboard</title></head>
<body>
    <h2>Welcome, <%= session.getAttribute("studentName") %></h2>
    <ul>
        <li><a href="updateProfile.jsp">Update Profile</a></li>
        <li><a href="changePassword.jsp">Change Password</a></li>
        <li><a href="roomBooking.jsp">Book Room</a></li>
        <li><a href="requestMaintenance.jsp">Request Maintenance</a></li>
        <li><a href="bill.jsp">View Bills</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
