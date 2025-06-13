<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.RoomListServlet.Room" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        h2 { text-align: center; color: #333; }
        .button-group { text-align: center; margin-bottom: 20px; }
        .button-group form { display: inline; }
        table { width: 100%; border-collapse: collapse; background: #fff; }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        a.button-link {
            display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none;
            border-radius: 5px; margin: 0 10px;
        }
        a.button-link:hover { background: #0056b3; }
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
