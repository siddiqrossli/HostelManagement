<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- ADD THIS LINE for JSTL --%>
<%
    // This scriptlet ensures the user is logged in
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        /* Optional: Add basic styling for the success message */
        .success-alert {
            background-color: #d4edda; /* Light green background */
            color: #155724; /* Dark green text */
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px; /* Space below the alert */
            border: 1px solid #c3e6cb; /* Green border */
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("studentName") %></h2>

    <%-- JSTL to check for and display the success message --%>
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-alert">
            ${sessionScope.successMessage}
        </div>
        <%-- Remove the message from session so it doesn't reappear on refresh or subsequent visits --%>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <ul>
        <li><a href="updateProfile">Update Profile</a></li>
        <li><a href="changePassword">Change Password</a></li>
        <li><a href="roomBooking.jsp">Book Room</a></li>
        <li><a href="requestMaintenance.jsp">Request Maintenance</a></li>
        <li><a href="bill.jsp">View Bills</a></li>
         <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>