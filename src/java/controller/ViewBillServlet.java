package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import model.Bill; // IMPORTANT: Ensure this is here

public class ViewBillServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish";
    private static final String DB_PASSWORD = "kakilangit";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String studentId = (String) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<model.Bill> billList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String roomCheckSql = "SELECT roomID FROM student WHERE studentID = ?";
            try (PreparedStatement roomStmt = conn.prepareStatement(roomCheckSql)) {
                roomStmt.setString(1, studentId);
                try (ResultSet roomRs = roomStmt.executeQuery()) {
                    boolean hasRoom = false;
                    if (roomRs.next()) {
                        String roomID = roomRs.getString("roomID");
                        hasRoom = (roomID != null && !roomID.trim().isEmpty());
                    }

                    if (hasRoom) {
                        String sql = "SELECT billNo, billName, billAmount, paymentStatus, billSequencePerStudent FROM bills WHERE studentID = ? ORDER BY billSequencePerStudent ASC";
                        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                            pstmt.setString(1, studentId);
                            try (ResultSet rs = pstmt.executeQuery()) {
                                while (rs.next()) {
                                    int billNo = rs.getInt("billNo");
                                    String billName = rs.getString("billName");
                                    double billAmount = rs.getDouble("billAmount");
                                    String paymentStatus = rs.getString("paymentStatus");
                                    int billSequencePerStudent = rs.getInt("billSequencePerStudent");

                                    model.Bill bill = new model.Bill(billNo, billName, billAmount, paymentStatus, studentId, billSequencePerStudent);
                                    billList.add(bill);
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading bills: " + e.getMessage());
        }

        request.setAttribute("billList", billList);
        request.getRequestDispatcher("bill.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        String studentId = (String) session.getAttribute("studentId");

        // Basic session check
        if (studentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("payBill".equals(action)) { // This matches the 'action' hidden input in bill.jsp
            String billNoStr = request.getParameter("billNo"); // Get the billNo from the hidden input

            if (billNoStr != null && !billNoStr.isEmpty()) {
                try {
                    int billNo = Integer.parseInt(billNoStr); // Convert billNo to integer

                    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // SQL to update paymentStatus to 'Paid' for the specific bill and student
                        String updateSql = "UPDATE bills SET paymentStatus = 'Paid' WHERE billNo = ? AND studentID = ?";
                        try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                            pstmt.setInt(1, billNo);
                            pstmt.setString(2, studentId); // Add studentId for security (prevents paying other students' bills)
                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                request.setAttribute("message", "Bill " + (billNo-1) + " paid successfully!");
                            } else {
                                request.setAttribute("error", "Failed to pay bill " + (billNo-1) + ". Bill not found or already paid.");
                            }
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid Bill Number provided.");
                    e.printStackTrace();
                } catch (Exception e) {
                    request.setAttribute("error", "An error occurred while processing payment: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                request.setAttribute("error", "Bill Number is missing for payment.");
            }
        }

        // After processing the POST request, call doGet to re-fetch and display the updated bill list.
        // This ensures the page refreshes with the new 'Paid' status.
        doGet(request, response);
    }
}