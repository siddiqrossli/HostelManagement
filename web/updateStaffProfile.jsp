<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("staffId") == null) {
        response.sendRedirect("staffLogin.jsp");
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
    String DB_USERNAME = "farish";
    String DB_PASSWORD = "kakilangit";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);
        String sql = "SELECT staffName, staffNumber, staffEmail FROM staff WHERE staffID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, staffId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            staffName = rs.getString("staffName");
            staffNumber = rs.getString("staffNumber");
            staffEmail = rs.getString("staffEmail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Error: " + e.getMessage());
        request.setAttribute("messageType", "error");
    } finally {
        try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Staff Profile</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff1f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        h2 {
            text-align: center;
            color: #8b0000;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #333;
        }
        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            font-size: 15px;
        }
        .button-group {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            background-color: #8b0000;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #a51616;
        }
        .btn-secondary {
            background-color: #666;
        }
        .btn-secondary:hover {
            background-color: #444;
        }
        .message {
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Staff Profile</h2>

    <% if (request.getAttribute("message") != null) { %>
        <div class="message <%= request.getAttribute("messageType") %>">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <form action="updateStaffProfile" method="post">
        <div class="form-group">
            <label for="staffId">Staff ID</label>
            <input type="text" id="staffId" name="staffId" value="<%= staffId %>" readonly>
        </div>
        <div class="form-group">
            <label for="staffName">Full Name</label>
            <input type="text" id="staffName" name="staffName" value="<%= staffName %>" required>
        </div>
        <div class="form-group">
            <label for="staffNumber">Phone Number</label>
            <input type="text" id="staffNumber" name="staffNumber" value="<%= staffNumber %>" required>
        </div>
        <div class="form-group">
            <label for="staffEmail">Email</label>
            <input type="email" id="staffEmail" name="staffEmail" value="<%= staffEmail %>" required>
        </div>
        <div class="button-group">
            <button type="submit" class="btn">Update</button>
            <a href="staffDashboard.jsp" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
