<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Room Booking</title>
    <style>
        body {
            background-color: #c44c4c;
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
            padding-top: 50px;
        }
        select, button {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 10px;
        }
        .card {
            background-color: #a83838;
            display: inline-block;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 15px rgba(0,0,0,0.3);
        }
        .room-info {
            margin-top: 30px;
            background-color: #ffffff22;
            padding: 20px;
            border-radius: 15px;
            color: white;
        }
        .full-message {
            color: yellow;
            font-weight: bold;
            margin-top: 10px;
        }
        .success-message {
            color: #90ee90;
            font-weight: bold;
            margin-top: 10px;
        }
        .home-btn {
            margin-top: 20px;
            display: inline-block;
            background-color: #444;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
        }
        .home-btn:hover {
            background-color: #666;
        }
    </style>
    <script>
        function submitForView() {
            const form = document.getElementById("roomForm");
            const hiddenSubmit = form.querySelector('input[name="action"]');
            if (hiddenSubmit) hiddenSubmit.remove();
            form.submit();
        }
    </script>
</head>
<body>

<div class="card">
    <h2>Room Booking</h2>

    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="success-message"><%= message %></div>
    <% } %>

    <form method="post" action="RoomBookingServlet" id="roomForm">
        <select name="roomID" onchange="submitForView()">
            <option disabled selected>-- Select Room --</option>
            <%
                List<String> roomList = (List<String>) request.getAttribute("roomList");
                String selectedRoomId = (String) request.getAttribute("selectedRoomId");

                if (roomList != null) {
                    for (String roomId : roomList) {
                        String selected = roomId.equals(selectedRoomId) ? "selected" : "";
            %>
                <option value="<%= roomId %>" <%= selected %>><%= roomId %></option>
            <%
                    }
                }
            %>
        </select>

        <%
            if (selectedRoomId != null) {
                List<String> occupants = (List<String>) request.getAttribute("occupants");
                int occupantCount = occupants != null ? occupants.size() : 0;
        %>
            <div class="room-info">
                <h3>Room Details</h3>
                <p><strong>Room:</strong> <%= selectedRoomId %></p>
                <p><strong>Occupants:</strong></p>
                <ol>
                <%
                    if (occupants != null && !occupants.isEmpty()) {
                        for (String name : occupants) {
                %>
                    <li><%= name %></li>
                <%
                        }
                    } else {
                %>
                    <li>No occupants in this room.</li>
                <%
                    }
                %>
                </ol>

                <%
                    if (occupantCount >= 4) {
                %>
                    <div class="full-message">This room is full</div>
                <%
                    } else {
                %>
                    <input type="hidden" name="roomID" value="<%= selectedRoomId %>">
                    <input type="hidden" name="action" value="submit">
                    <button type="submit">Submit</button>
                <%
                    }
                %>
            </div>
        <%
            }
        %>
    </form>

    <a href="dashboard.jsp" class="home-btn">Go to Home</a>
</div>

</body>
</html>
