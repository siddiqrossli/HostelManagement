<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Room List</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background-color: #fce8e6;
            padding: 40px 20px;
        }
        h2 {
            text-align: center;
            color: #8b0000;
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
            max-width: 800px;
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
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #8b0000;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #fdf2f1;
        }
        tr:hover {
            background-color: #f5d7d5;
        }
        .status-full {
            color: #dc3545;
            font-weight: bold;
        }
        .status-available {
            color: #28a745;
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
        .room-id {
            width: 30%;
        }
        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 15px;
        }
        .pagination a {
            color: #8b0000;
            padding: 8px 12px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 2px;
            border-radius: 4px;
            font-size: 14px;
        }
        .pagination a.active {
            background-color: #8b0000;
            color: white;
            border: 1px solid #8b0000;
        }
        .pagination a:hover:not(.active) {
            background-color: #f5d7d5;
        }
        .pagination a.disabled {
            pointer-events: none;
            color: #aaa;
            border-color: #ddd;
        }
    </style>
</head>
<body>

<h2>Room List - ${college == 'HT' ? 'Hang Tuah' : 'Tun Fatimah'}</h2>

<div class="button-group">
    <a href="roomList?college=HT&page=1" class="button-link">Hang Tuah</a>
    <a href="roomList?college=TF&page=1" class="button-link">Tun Fatimah</a>
</div>

<c:if test="${not empty error}">
    <p style="color:red; text-align:center;">${error}</p>
</c:if>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th class="room-id">Room ID</th>
                <th>Room Status</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty rooms}">
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td class="room-id">${room.roomID}</td>
                            <td class="${room.availableSpaces <= 0 ? 'status-full' : 'status-available'}">
                                ${room.status}
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="2" style="text-align: center;">No rooms found</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <div class="pagination">
        <c:choose>
            <c:when test="${page > 1}">
                <a href="roomList?college=${college}&page=${page-1}">&laquo; Previous</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">&laquo; Previous</a>
            </c:otherwise>
        </c:choose>
        
        <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
                <c:when test="${page == i}">
                    <a href="roomList?college=${college}&page=${i}" class="active">${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="roomList?college=${college}&page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:choose>
            <c:when test="${page < totalPages}">
                <a href="roomList?college=${college}&page=${page+1}">Next &raquo;</a>
            </c:when>
            <c:otherwise>
                <a class="disabled">Next &raquo;</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>