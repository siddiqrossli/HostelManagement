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
    <h2>Welcome Student: <%= session.getAttribute("studentId") %></h2>
    <ul>
        <li><a href="updateProfile.jsp">Update Profile</a></li>
        <li><a href="changePassword.jsp">Change Password</a></li>
        <li><a href="roomBooking.jsp">Room Booking</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
