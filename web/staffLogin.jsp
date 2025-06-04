<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Staff Login</title></head>
<body>
    <h2>Login</h2>
    <form action="staffLogin" method="post"> Staff ID: <input type="text" name="staffId" required><br> Password: <input type="password" name="staffPassword" required><br> <input type="submit" value="Login">
    </form>
    ${error}
</body>
</html>