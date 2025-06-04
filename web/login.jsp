<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- MAKE SURE THIS IS PRESENT --%>
<html>
<head>
    <title>Student Login</title>
    <style>
        /* Your CSS styles here (copied from previous perfect answer) */
        body { font-family: Arial, sans-serif; margin: 20px; display: flex; justify-content: center; align-items: center; min-height: 80vh; background-color: #f4f4f4; }
        .login-container { background-color: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input[type="text"], input[type="password"] { width: calc(100% - 22px); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; }
        .button-group { text-align: center; margin-top: 25px; }
        input[type="submit"] { padding: 10px 25px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 17px; transition: background-color 0.3s ease; }
        input[type="submit"]:hover { background-color: #0056b3; }
        .error-message { /* Style for the error message */
            color: #d8000c;
            background-color: #ffbaba;
            border: 1px solid #d8000c;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Student Login</h2>

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
    <p style="text-align: center; margin-top: 15px;"><a href="register.jsp">New Student? Register here.</a></p>
</div>

</body>
</html>