<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.RoomListServlet.Room" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room List</title>
    <style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 0;
        background-color: #fce8e6; /* soft pink background */
        padding: 40px 20px;
    }

    h2 {
        text-align: center;
        color: #8b0000; /* dark red */
        margin-bottom: 30px;
    }

    .button-group {
        text-align: center;
        margin-bottom: 20px;
    }

    .button-group form {
        display: inline;
    }

    .table-container {
        max-width: 1000px;
        margin: 0 auto;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        overflow-x: auto;
        padding: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
    }

    th, td {
        padding: 12px 15px;
        border: 1px solid #ddd;
        text-align: center;
    }

    th {
        background-color: #8b0000; /* deep red */
        color: #fff;
    }

    tr:nth-child(even) {
        background-color: #fdf2f1;
    }

    tr:hover {
        background-color: #f5d7d5;
    }

    a.button-link {
        display: inline-block;
        padding: 10px 20px;
        background: #8b0000;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        margin: 0 10px;
        transition: background 0.3s ease;
    }

    a.button-link:hover {
        background: #a51414;
    }
</style>


</head>
<body>

<h2>Room List - ${college == 'HT' ? 'Hang Tuah' : 'Tun Fatimah'}</h2>

<div class="button-group">
    <a href="roomList?college=HT" class="button-link">Hang Tuah</a>
    <a href="roomList?college=TF" class="button-link">Tun Fatimah</a>
</div>

<c:if test="${not empty error}">
    <p style="color:red; text-align:center;">${error}</p>
</c:if>

<table>
    <thead>
        <tr>
            <th>Room ID</th>
            <th>Room Capacity</th>
            <th>Room Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="room" items="${rooms}">
            <tr>
                <td>${room.roomID}</td>
                <td>${room.roomCapacity}</td>
                <td>${room.status}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
