<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Appeal Submission</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f7f7f7; padding: 20px; }
        .container { background: white; padding: 30px; border-radius: 10px; max-width: 600px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; }
        .success { color: green; }
        .danger { color: red; }
        .btn { margin-top: 20px; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>Appeal Submission Result</h2>
    
    <c:if test="${not empty message}">
        <p class="${messageType}">${message}</p>
    </c:if>

    <a href="dashboard.jsp" class="btn">Back to Dashboard</a>
</div>
</body>
</html>
