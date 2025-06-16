<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Staff Change Password</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: #fce8e6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            color: #8b0000;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #444;
        }

        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            font-size: 15px;
        }

        .button-group {
            margin-top: 25px;
            text-align: center;
        }

        button {
            padding: 12px 25px;
            background-color: #8b0000;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background-color: #a51616;
        }

        .message {
            text-align: center;
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #8b0000;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
        .back-button {
            text-align: center;
            margin-top: 40px;
        }

        .btn-back {
            display: inline-block;
            padding: 10px 25px;
            background-color: #8b0000;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-back:hover {
            background-color: #a51414;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Change Password</h2>

    <c:if test="${not empty error}">
        <div class="message error-message">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="message success-message">${success}</div>
    </c:if>

    <form action="staffChangePassword" method="post">
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

   <div class="back-button">
        <a href="staffDashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
`
