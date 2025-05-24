<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Room Booking</title></head>
<body>
    <h2>Book a Room</h2>
    <form action="RoomBookingServlet" method="post">
        Room ID: <input type="text" name="roomId"><br>
        <input type="submit" value="Book Room">
    </form>
</body>
</html>
