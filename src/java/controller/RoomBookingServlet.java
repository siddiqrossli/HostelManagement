package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class RoomBookingServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish";
    private static final String DB_PASSWORD = "kakilangit";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String studentId = (String) session.getAttribute("studentId");

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Get gender of logged-in student
            String gender = null;
            if (studentId != null) {
                String genderSql = "SELECT studGender FROM student WHERE studentID = ?";
                PreparedStatement genderStmt = conn.prepareStatement(genderSql);
                genderStmt.setString(1, studentId);
                ResultSet genderRs = genderStmt.executeQuery();
                if (genderRs.next()) {
                    gender = genderRs.getString("studGender");
                }
            }

            // Load filtered room IDs based on gender
            List<String> roomIds = new ArrayList<>();
            if ("Male".equalsIgnoreCase(gender)) {
                String roomSql = "SELECT roomID FROM rooms WHERE roomID LIKE 'HT%'";
                PreparedStatement stmt = conn.prepareStatement(roomSql);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    roomIds.add(rs.getString("roomID"));
                }
            } else if ("Female".equalsIgnoreCase(gender)) {
                String roomSql = "SELECT roomID FROM rooms WHERE roomID LIKE 'TF%'";
                PreparedStatement stmt = conn.prepareStatement(roomSql);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    roomIds.add(rs.getString("roomID"));
                }
            }

            request.setAttribute("roomList", roomIds);
            request.getRequestDispatcher("roomBooking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String selectedRoomId = request.getParameter("roomID");
    String action = request.getParameter("action");
    HttpSession session = request.getSession();
    String studentId = (String) session.getAttribute("studentId");

    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Get student gender
        String gender = null;
        if (studentId != null) {
            String genderSql = "SELECT studGender FROM student WHERE studentID = ?";
            PreparedStatement genderStmt = conn.prepareStatement(genderSql);
            genderStmt.setString(1, studentId);
            ResultSet genderRs = genderStmt.executeQuery();
            if (genderRs.next()) {
                gender = genderRs.getString("studGender");
            }
        }

        // Filter room list based on gender
        List<String> roomIds = new ArrayList<>();
        if ("Male".equalsIgnoreCase(gender)) {
            PreparedStatement stmt = conn.prepareStatement("SELECT roomID FROM rooms WHERE roomID LIKE 'HT%'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) roomIds.add(rs.getString("roomID"));
        } else if ("Female".equalsIgnoreCase(gender)) {
            PreparedStatement stmt = conn.prepareStatement("SELECT roomID FROM rooms WHERE roomID LIKE 'TF%'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) roomIds.add(rs.getString("roomID"));
        }

        request.setAttribute("roomList", roomIds);
        request.setAttribute("selectedRoomId", selectedRoomId);

        // Get occupants
        List<String> occupants = new ArrayList<>();
        if (selectedRoomId != null) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT studName FROM student WHERE roomID = ?");
            pstmt.setString(1, selectedRoomId);
            ResultSet studentRs = pstmt.executeQuery();
            while (studentRs.next()) {
                occupants.add(studentRs.getString("studName"));
            }
            request.setAttribute("occupants", occupants);
        }

        // Submit action: update only if room has space
        if ("submit".equals(action) && studentId != null && selectedRoomId != null) {
            if (occupants.size() >= 4) {
                request.setAttribute("error", "This room is already full.");
            } else {
                String updateSql = "UPDATE student SET roomID = ? WHERE studentID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, selectedRoomId);
                updateStmt.setString(2, studentId);
                updateStmt.executeUpdate();
                request.setAttribute("message", "Room successfully booked!");
            }
        }

        request.getRequestDispatcher("roomBooking.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
}

}
