<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if the student is logged in
    if (session.getAttribute("studentId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve student details from session
    String studentId = (String) session.getAttribute("studentId");
%>
<html>
<head>
    <title>Apply College</title>
</head>
<body>
    <h2>Apply College</h2>
    
    <!-- Display student information -->
    <div>
        <h3>INFO</h3>
        <p>Name: <%= session.getAttribute("studentName") %></p>
        <p>ID: <%= studentId %></p>
        <p>Phone: <%= session.getAttribute("studentPhone") %></p>
        <p>Email: <%= session.getAttribute("studentEmail") %></p>
        <p>Gender: <%= session.getAttribute("studentGender") %></p>
        <p>Household Income: RM<%= session.getAttribute("studentIncome") %></p>
    </div>
    
    <!-- College application form -->
    <form action="ApplyCollegeServlet" method="post">
        <input type="hidden" name="studentId" value="<%= studentId %>">
        
        <div>
            <button type="submit">Apply College</button>
            <button type="button" onclick="window.location.href='studentDashboard.jsp';">Back</button>
        </div>
    </form>
</body>
</html>
