<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Update Profile</title></head>
<body>
    <h2>Update Profile</h2>
    <form action="UpdateProfileServlet" method="post">
        Name: <input type="text" name="name"><br>
        Email: <input type="email" name="email"><br>
        Phone: <input type="text" name="phone"><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>
