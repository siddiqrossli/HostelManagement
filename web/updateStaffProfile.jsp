<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Ensure staff is logged in
    if (session.getAttribute("staffId") == null) {
        response.sendRedirect("staffLogin.jsp"); //
        return;
    }

    String staffId = (String) session.getAttribute("staffId");
    String staffName = "";
    String staffNumber = "";
    String staffEmail = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    String DB_USERNAME = "farish"; // Your database username
    String DB_PASSWORD = "kakilangit"; // The password for the 'farish' user

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

        String sql = "SELECT staffName, staffNumber, staffEmail FROM staff WHERE staffID = ?"; //
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, staffId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            staffName = rs.getString("staffName"); //
            staffNumber = rs.getString("staffNumber"); //
            staffEmail = rs.getString("staffEmail"); //
        }
    } catch (SQLException e) { // Separate catch for SQLException
        e.printStackTrace();
        // Set an error message in request scope for display
        request.setAttribute("message", "Database error: " + e.getMessage());
        request.setAttribute("messageType", "error");
    } catch (ClassNotFoundException e) { // Separate catch for ClassNotFoundException
        e.printStackTrace();
        // Set an error message in request scope for display
        request.setAttribute("message", "System error: JDBC driver not found.");
        request.setAttribute("messageType", "error");
    } finally {
        // Ensure resources are closed
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Log any closing errors
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Staff Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #d15656; /* Reddish background */
        }
        .container {
            background-color: #a83a3a; /* Darker red for the container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            color: #fff;
            text-align: center;
        }
        h2 {
            color: #fff;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #fff;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: calc(100% - 20px); /* Adjust for padding and border */
            padding: 10px;
            border: 1px solid #c74c4c;
            border-radius: 4px;
            background-color: #f8f8f8;
            color: #333;
        }
        .button-group {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .btn {
            background-color: #555;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }
        .btn-primary {
            background-color: #4CAF50; /* Green for update */
        }
        .btn:hover {
            opacity: 0.9;
        }
        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 4px;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Staff Profile</h2>

        <%-- Display messages --%>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message <%= request.getAttribute("messageType") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <form action="updateStaffProfile" method="post">
            <div class="form-group">
                <label for="staffId">Staff ID:</label>
                <input type="text" id="staffId" name="staffId" value="<%= staffId %>" readonly>
            </div>
            <div class="form-group">
                <label for="staffName">Full Name:</label>
                <input type="text" id="staffName" name="staffName" value="<%= staffName %>" required>
            </div>
            <div class="form-group">
                <label for="staffNumber">Phone Number:</label>
                <input type="text" id="staffNumber" name="staffNumber" value="<%= staffNumber %>" required>
            </div>
            <div class="form-group">
                <label for="staffEmail">Email:</label>
                <input type="email" id="staffEmail" name="staffEmail" value="<%= staffEmail %>" required>
            </div>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Update Profile</button>
                <a href="staffDashboard.jsp" class="btn">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>