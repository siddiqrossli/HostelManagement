<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("staffId") == null) {
        response.sendRedirect("staffLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: #fff1f5;
        }
        .header {
            background-color: #ffffff;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .header img {
            height: 40px;
        }
        .logout-btn {
            background-color: #8b0000;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
        }
        .container {
            display: flex;
        }
        .sidebar {
            width: 220px;
            background-color: #fae7ef;
            padding: 30px 20px;
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }
        .sidebar .profile {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile img {
            width: 80px;
            border-radius: 50%;
            border: 3px solid #8b0000;
        }
        .profile p {
            margin: 8px 0 0;
            font-weight: bold;
        }
        .nav-button {
            display: block;
            background-color: #fff;
            color: #8b0000;
            padding: 12px;
            margin-bottom: 10px;
            border: none;
            text-align: left;
            width: 100%;
            border-radius: 10px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            cursor: pointer;
        }
        .nav-button:hover {
            background-color: #ffe6eb;
        }
        .main-content {
            flex: 1;
            padding: 30px;
        }
        h2 {
            color: #8b0000;
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px;
            width: 250px;
            height: 120px;
        }
        .card h3 {
            margin: 0 0 10px;
            color: #8b0000;
        }
    </style>
</head>
<body>

<div class="header">
    <img src="logo.png" alt="Polytechnic Hostel Logo">
    <form action="staffLogout.jsp" method="post">
        <button type="submit" class="logout-btn">Log Out</button>
    </form>
</div>

<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="profile">
            <img src="default-avatar.png" alt="Profile">
            <p><%= session.getAttribute("staffName") %></p>
            <small>Staff</small>
        </div>
        <form action="updateStaffProfile"><button class="nav-button">Update Profile</button></form>
        <form action="staffChangePassword"><button class="nav-button">Change Password</button></form>
        <form action="staffList"><button class="nav-button">View Staff</button></form>
        <form action="roomList"><button class="nav-button">View Room</button></form>
        <form action="viewStaffMaintenance"><button class="nav-button">Maintenance Requests</button></form>
        <form action="ViewAppealServlet"><button class="nav-button">Appeal Requests</button></form>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>Welcome, <%= session.getAttribute("staffName") %></h2>
        <div class="cards">
            <div class="card">
                <h3>Profile</h3>
                <p>Manage your staff profile info</p>
            </div>
            <div class="card">
                <h3>Rooms</h3>
                <p>Check and manage hostel rooms</p>
            </div>
            <div class="card">
                <h3>Requests</h3>
                <p>View maintenance or appeal logs</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
