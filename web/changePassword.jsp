<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Change Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="password"] {
            width: calc(100% - 12px);
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error-message, .success-message {
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Change Password</h2>

    <!-- Success message -->
    <c:if test="${not empty success}">
        <div class="success-message">${success}</div>
    </c:if>

    <!-- Error message -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="changePassword" method="post">
        <div class="form-group">
            <label for="oldPassword">Old Password:</label>
            <input type="password" name="oldPassword" id="oldPassword" required />
        </div>
        <div class="form-group">
            <label for="newPassword">New Password:</label>
            <input type="password" name="newPassword" id="newPassword" required />
        </div>
        <div class="form-group">
            <label for="confirmNewPassword">Confirm New Password:</label>
            <input type="password" name="confirmNewPassword" id="confirmNewPassword" required />
        </div>
        <div class="button-group">
            <button type="submit">Change Password</button>
        </div>
    </form>

    <p style="text-align: center; margin-top: 20px;"><a href="dashboard.jsp">Back to Dashboard</a></p>
</div>

</body>
</html>
