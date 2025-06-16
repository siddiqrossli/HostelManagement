<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Student Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f4f4;
        }
        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            text-align: center; /* Center content within container */
        }
        h1 { /* Added for the main title from the image */
            font-size: 32px;
            margin-bottom: 10px;
            color: #333;
        }
        h2 { /* Kept for the 'Student Login' subheading */
            font-size: 24px; /* Adjust size */
            color: #333;
            margin-bottom: 25px;
        }
        p.welcome-text { /* Added for text like 'Welcome back' */
            font-size: 18px;
            margin-bottom: 20px;
            color: #555;
        }
        .roles-section { /* Styles for the role selection buttons */
            margin-bottom: 30px;
            padding: 15px 0;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }
        .role-button {
            background-color: rgba(0, 123, 255, 0.1); /* Light blue transparent */
            border: 1px solid #007bff; /* Blue border */
            color: #007bff; /* Blue text */
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            flex-direction: column;
            margin: 0 8px;
            transition: background-color 0.3s ease, transform 0.2s ease, border-color 0.3s ease;
            text-decoration: none;
            font-weight: bold;
        }
        .role-button:hover {
            background-color: #007bff;
            color: white;
            transform: translateY(-2px);
        }
        .role-button img {
            width: 40px; /* Size of icons */
            height: 40px;
            margin-bottom: 5px;
            filter: none; /* Keep original icon colors, or use filter: brightness(0) invert(1); if icons are black and need to be white */
        }
        .form-group { margin-bottom: 15px; text-align: left; /* Align input labels left */ }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input[type="text"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .button-group { text-align: center; margin-top: 25px; }
        input[type="submit"] {
            padding: 10px 25px;
            background-color: #28a745; /* Green for login button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 17px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover { background-color: #218838; }
        .error-message {
            color: #d8000c;
            background-color: #ffbaba;
            border: 1px solid #d8000c;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
        .create-account-link {
            display: block;
            margin-top: 20px;
            font-size: 16px;
            color: #007bff; /* Blue link */
            text-decoration: none;
        }
        .create-account-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h1>Polytechnic Hostel</h1> <%-- Main title --%>
    <p class="welcome-text">Welcome back</p>
    <p class="welcome-text">Please enter your details to sign in as a student.</p>

    <div class="roles-section">
        <p>Roles :</p>
        <%-- Student Role Button (current page, so it can be a static label or styled for 'active') --%>
        <a href="login.jsp" class="role-button" style="background-color: #007bff; color: white;">
            <img src="img/student.png" alt="Student Icon" style="filter: brightness(0) invert(1);"> <%-- Icon will be white on blue bg --%>
            Student
        </a>
        <%-- Staff Role Button (links to staff login) --%>
        <a href="staffLogin.jsp" class="role-button">
            <img src="img/staff.png" alt="Staff Icon">
            Staff
        </a>
    </div>

    <h2>Student Login</h2> <%-- Subheading for the form --%>

    <c:if test="${not empty requestScope.error}">
        <div class="error-message">
            ${requestScope.error}
        </div>
    </c:if>

    <form action="login" method="post">
        <div class="form-group">
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="button-group">
            <input type="submit" value="Login">
        </div>
    </form>
    <p class="create-account-link"><a href="register.jsp">Don't have an account? Create Account</a></p>
    <%-- No need for "Back to Role Selection" here, as the roles are already on this page --%>
</div>

</body>
</html>