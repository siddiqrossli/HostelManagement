<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Update Profile</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"] { width: calc(100% - 12px); padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .button-group { text-align: center; margin-top: 20px; }
        button { padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        button:hover { background-color: #0056b3; }
        .message, .error-message { text-align: center; margin-bottom: 15px; padding: 10px; border-radius: 5px; }
        .message { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error-message { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Student Profile</h2>

    <%-- Display error message if present --%>
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <%--
        The 'message' attribute is now handled on the studentDashboard.jsp
        because we are redirecting using response.sendRedirect().
        If you wanted to show a success message *on this page* without redirecting,
        you would set 'message' as a request attribute and display it here.
    --%>
    
    <form action="updateProfile" method="post">
        <div class="form-group">
            <label for="studentId">Student ID:</label>
            <%-- Student ID is read-only as it's from session --%>
            <input type="text" id="studentId" value="${sessionScope.studentId}" readonly style="background-color: #e9ecef;" />
        </div>
        <div class="form-group">
            <label for="studName">Full Name:</label>
            <input type="text" name="studName" id="studName" value="${requestScope.studName}" required />
        </div>
        <div class="form-group">
            <label for="studNumber">Phone Number:</label>
            <input type="text" name="studNumber" id="studNumber" value="${requestScope.studNumber}" required />
        </div>
        <div class="form-group">
            <label for="studEmergencyNumber">Emergency Contact:</label>
            <input type="text" name="studEmergencyNumber" id="studEmergencyNumber" value="${requestScope.studEmergencyNumber}" required />
        </div>
        <div class="button-group">
            <button type="submit">Update Profile</button>
        </div>
    </form>
    <p style="text-align: center; margin-top: 20px;"><a href="studentDashboard.jsp">Back to Dashboard</a></p>
</div>

</body>
</html>