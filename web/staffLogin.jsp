<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- ADD THIS LINE for JSTL --%>
<html>
<head>
    <title>Staff Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0; /* Reset default margin */
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center;   /* Center vertically */
            min-height: 100vh;     /* Full viewport height */
            background-color: #f4f4f4; /* Light background color */
        }
        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); /* Subtle shadow */
            width: 100%;
            max-width: 400px; /* Max width for the form container */
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px; /* Space below the heading */
        }
        .form-group {
            margin-bottom: 15px; /* Space between form fields */
        }
        label {
            display: block; /* Make labels take full width */
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 22px); /* Full width minus padding and border */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .button-group {
            text-align: center;
            margin-top: 25px; /* Space above the button */
        }
        input[type="submit"] {
            padding: 10px 25px;
            background-color: #007bff; /* Primary blue button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer; /* Indicate clickable */
            font-size: 17px;
            transition: background-color 0.3s ease; /* Smooth hover effect */
        }
        input[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .error-message {
            color: #d8000c; /* Dark red text */
            background-color: #ffbaba; /* Light red background */
            border: 1px solid #d8000c;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
        p.register-link {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Staff Login</h2>

    <%-- Display error message if present using JSTL --%>
    <c:if test="${not empty requestScope.error}">
        <div class="error-message">
            ${requestScope.error}
        </div>
    </c:if>

    <form action="staffLogin" method="post"> <%-- Ensure this action matches your StaffLoginServlet mapping --%>
        <div class="form-group">
            <label for="staffId">Staff ID:</label>
            <input type="text" id="staffId" name="staffId" required>
        </div>
        <div class="form-group">
            <label for="staffPassword">Password:</label>
            <input type="password" id="staffPassword" name="staffPassword" required>
        </div>
        <div class="button-group">
            <input type="submit" value="Login">
        </div>
    </form>
    <p class="register-link"><a href="staffRegister.jsp">New Staff? Register here.</a></p>
</div>

</body>
</html>