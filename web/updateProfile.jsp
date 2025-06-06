<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Student Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f4f4;
            margin: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            font-size: 16px;
        }
        .form-group input[type="text"] {
            width: calc(100% - 22px); /* Adjust for padding and border */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            color: #333;
        }
        .form-group input[type="text"]:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .form-group input[readonly] {
            background-color: #e9e9e9;
            cursor: not-allowed;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }
        .btn-update:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        /* Message styles (for error/success) */
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Update Student Profile</h1>

    <%-- Display error messages from the servlet (request scope) --%>
    <c:if test="${not empty requestScope.error}">
        <div class="message error">
            ${requestScope.error}
        </div>
    </c:if>

    <%-- Display success messages from the servlet (session scope) --%>
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="message success">
            ${sessionScope.successMessage}
            <% session.removeAttribute("successMessage"); %> <%-- Remove message after display to avoid showing it again --%>
        </div>
    </c:if>

    <form action="updateProfile" method="post">
        <div class="form-group">
            <label for="studentId">Student ID:</label>
            <%-- Student ID is from session, as it's the identifier --%>
            <input type="text" id="studentId" name="studentId" value="${sessionScope.studentId}" readonly>
        </div>
        <div class="form-group">
            <label for="studName">Full Name:</label>
            <%-- Use requestScope.studName which is set by doGet --%>
            <input type="text" id="studName" name="studName" value="${requestScope.studName}" required>
        </div>
        <div class="form-group">
            <label for="studNumber">Phone Number:</label>
            <%-- Use requestScope.studNumber which is set by doGet --%>
            <input type="text" id="studNumber" name="studNumber" value="${requestScope.studNumber}" required>
        </div>
        <div class="form-group">
            <label for="studEmergencyNumber">Emergency Contact:</label>
            <%-- Use requestScope.studEmergencyNumber which is set by doGet --%>
            <input type="text" id="studEmergencyNumber" name="studEmergencyNumber" value="${requestScope.studEmergencyNumber}" required>
        </div>

        <button type="submit" class="btn-update">Update Profile</button>
    </form>

    <a href="dashboard.jsp" class="back-link">Back to Dashboard</a>
</div>

</body>
</html>