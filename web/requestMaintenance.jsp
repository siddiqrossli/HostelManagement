<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Request Maintenance</title></head>
<body>
    <h2>Maintenance Request</h2>
    <form action="RequestMaintenanceServlet" method="post">
        Description: <textarea name="description"></textarea><br>
        <input type="submit" value="Submit Request">
    </form>
</body>
</html>
