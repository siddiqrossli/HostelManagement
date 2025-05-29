<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Student Login</title></head>
<body>
    <h2>Login</h2>
    <form action="LoginStaffServlet" method="post">
        Student ID: <input type="text" name="staffId" required><br>
       <!--> Password: <input type="password" name="password" required><br><-->
        <input type="submit" value="Login">
    </form>
    ${errorMessage}
</body>
</html>
