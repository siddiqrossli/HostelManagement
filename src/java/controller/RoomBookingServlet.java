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
                try (PreparedStatement genderStmt = conn.prepareStatement(genderSql)) {
                    genderStmt.setString(1, studentId);
                    try (ResultSet genderRs = genderStmt.executeQuery()) {
                        if (genderRs.next()) {
                            gender = genderRs.getString("studGender");
                        }
                    }
                }
            }

            // Load filtered room IDs based on gender
            List<String> roomIds = new ArrayList<>();
            if ("Male".equalsIgnoreCase(gender)) {
                String roomSql = "SELECT roomID FROM rooms WHERE roomID LIKE 'HT%'";
                try (PreparedStatement stmt = conn.prepareStatement(roomSql)) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            roomIds.add(rs.getString("roomID"));
                        }
                    }
                }
            } else if ("Female".equalsIgnoreCase(gender)) {
                String roomSql = "SELECT roomID FROM rooms WHERE roomID LIKE 'TF%'";
                try (PreparedStatement stmt = conn.prepareStatement(roomSql)) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            roomIds.add(rs.getString("roomID"));
                        }
                    }
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
                try (PreparedStatement genderStmt = conn.prepareStatement(genderSql)) {
                    genderStmt.setString(1, studentId);
                    try (ResultSet genderRs = genderStmt.executeQuery()) {
                        if (genderRs.next()) {
                            gender = genderRs.getString("studGender");
                        }
                    }
                }
            }

            // Filter room list based on gender
            List<String> roomIds = new ArrayList<>();
            if ("Male".equalsIgnoreCase(gender)) {
                try (PreparedStatement stmt = conn.prepareStatement("SELECT roomID FROM rooms WHERE roomID LIKE 'HT%'")) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) roomIds.add(rs.getString("roomID"));
                    }
                }
            } else if ("Female".equalsIgnoreCase(gender)) {
                try (PreparedStatement stmt = conn.prepareStatement("SELECT roomID FROM rooms WHERE roomID LIKE 'TF%'")) {
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) roomIds.add(rs.getString("roomID"));
                    }
                }
            }
            request.setAttribute("roomList", roomIds);
            request.setAttribute("selectedRoomId", selectedRoomId);

            // Get current occupants
            List<String> occupants = new ArrayList<>();
            if (selectedRoomId != null) {
                try (PreparedStatement pstmt = conn.prepareStatement("SELECT studName FROM student WHERE roomID = ?")) {
                    pstmt.setString(1, selectedRoomId);
                    try (ResultSet studentRs = pstmt.executeQuery()) {
                        while (studentRs.next()) {
                            occupants.add(studentRs.getString("studName"));
                        }
                    }
                }
                request.setAttribute("occupants", occupants);
            }

            if ("submit".equals(action) && studentId != null && selectedRoomId != null) {
                // Check if student already has a room
                String currentRoomId = null;
                try (PreparedStatement checkExistingRoomStmt = conn.prepareStatement(
                    "SELECT roomID FROM student WHERE studentID = ?")) {
                    checkExistingRoomStmt.setString(1, studentId);
                    try (ResultSet existingRoomRs = checkExistingRoomStmt.executeQuery()) {
                        if (existingRoomRs.next()) {
                            currentRoomId = existingRoomRs.getString("roomID");
                        }
                    }
                }

                if (currentRoomId != null && !currentRoomId.trim().isEmpty()) {
                    request.setAttribute("error", "You have already booked a room (Room " + currentRoomId + ").");
                } else if (occupants.size() >= 4) {
                    request.setAttribute("error", "This room is already full.");
                } else {
                    // Update student with room ID
                    String updateSql = "UPDATE student SET roomID = ? WHERE studentID = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setString(1, selectedRoomId);
                        updateStmt.setString(2, studentId);
                        int updatedRows = updateStmt.executeUpdate();

                        if (updatedRows > 0) {
    // Get the next available bill number (auto-increment or max+1)
    int nextBillNo = 1;
    try (PreparedStatement getMaxBillNoStmt = conn.prepareStatement(
        "SELECT MAX(billNo) AS maxBillNo FROM bills")) {
        try (ResultSet rsMaxBillNo = getMaxBillNoStmt.executeQuery()) {
            if (rsMaxBillNo.next()) {
                nextBillNo = rsMaxBillNo.getInt("maxBillNo") + 1;
            }
        }
    }

    // Insert Room Booking Fee if doesn't exist
    try (PreparedStatement checkRoomBillStmt = conn.prepareStatement(
        "SELECT COUNT(*) FROM bills WHERE studentID = ? AND billName = 'College Fee'")) {
        checkRoomBillStmt.setString(1, studentId);
        try (ResultSet rs = checkRoomBillStmt.executeQuery()) {
            rs.next();
            if (rs.getInt(1) == 0) {
                String roomBillSql = "INSERT INTO bills (billNo, billName, billAmount, paymentStatus, studentID, billSequencePerStudent) " +
                                    "VALUES (?, 'College Fee', 520.00, 'Unpaid', ?, 1)";
                try (PreparedStatement roomBillStmt = conn.prepareStatement(roomBillSql)) {
                    roomBillStmt.setInt(1, nextBillNo++);
                    roomBillStmt.setString(2, studentId);
                    roomBillStmt.executeUpdate();
                }
            }
        }
    }

    // Insert Electric Appliances Fee if doesn't exist
    try (PreparedStatement checkElectricBillStmt = conn.prepareStatement(
        "SELECT COUNT(*) FROM bills WHERE studentID = ? AND billName = 'Electric Appliances Fee'")) {
        checkElectricBillStmt.setString(1, studentId);
        try (ResultSet rs = checkElectricBillStmt.executeQuery()) {
            rs.next();
            if (rs.getInt(1) == 0) {
                String electricBillSql = "INSERT INTO bills (billNo, billName, billAmount, paymentStatus, studentID, billSequencePerStudent) " +
                                       "VALUES (?, 'Electric Appliances Fee', 10.00, 'Unpaid', ?, 2)";
                try (PreparedStatement electricBillStmt = conn.prepareStatement(electricBillSql)) {
                    electricBillStmt.setInt(1, nextBillNo);
                    electricBillStmt.setString(2, studentId);
                    electricBillStmt.executeUpdate();
                }
            }
        }
    }

    request.setAttribute("message", "Room successfully booked and bills generated!");
}
                    }
                }
            }
            
            request.getRequestDispatcher("roomBooking.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}