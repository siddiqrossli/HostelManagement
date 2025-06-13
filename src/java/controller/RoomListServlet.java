package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/roomList")
public class RoomListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private final String jdbcUsername = "farish";
    private final String jdbcPassword = "kakilangit";

    public static class Room {
        private String roomID;
        private int roomCapacity;

        public Room(String roomID, int roomCapacity) {
            this.roomID = roomID;
            this.roomCapacity = roomCapacity;
        }

        public String getRoomID() { return roomID; }
        public int getRoomCapacity() { return roomCapacity; }

        public String getStatus() {
            if (roomCapacity >= 4) return "Fully Booked";
            else return (4 - roomCapacity) + " space(s) left";
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String collegePrefix = request.getParameter("college");
        if (collegePrefix == null) {
            collegePrefix = "HT"; // Default to Hang Tuah
        }

        ArrayList<Room> rooms = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String sql = "SELECT roomID, roomCapacity FROM rooms WHERE roomID LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, collegePrefix + "%");
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    String roomID = rs.getString("roomID");
                    int capacity = rs.getInt("roomCapacity");
                    rooms.add(new Room(roomID, capacity));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.setAttribute("rooms", rooms);
        request.setAttribute("college", collegePrefix);
        RequestDispatcher dispatcher = request.getRequestDispatcher("roomList.jsp");
        dispatcher.forward(request, response);
    }
}
