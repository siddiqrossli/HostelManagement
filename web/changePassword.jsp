<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Change Password</title></head>
<body>
    <h2>Change Password</h2>
    <form action="ChangePasswordServlet" method="post">
        Old Password: <input type="password" name="oldPassword"><br>
        New Password: <input type="password" name="newPassword"><br>
        Confirm Password: <input type="password" name="confirmPassword"><br>
        <input type="submit" value="Change Password">
    </form>
</body>
</html>
