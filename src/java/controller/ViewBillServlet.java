package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import model.Bill;

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

        List<Bill> billList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Check if student has a room (optional - remove if not needed)
            boolean hasRoom = false;
            try (PreparedStatement roomStmt = conn.prepareStatement(
                "SELECT roomID FROM student WHERE studentID = ?")) {
                roomStmt.setString(1, studentId);
                try (ResultSet roomRs = roomStmt.executeQuery()) {
                    if (roomRs.next()) {
                        hasRoom = (roomRs.getString("roomID") != null);
                    }
                }
            }

            // Always show bills regardless of room status
            String sql = "SELECT billNo, billName, billAmount, paymentStatus, billSequencePerStudent " +
                         "FROM bills WHERE studentID = ? ORDER BY billSequencePerStudent ASC";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, studentId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Bill bill = new Bill(
                            rs.getInt("billNo"),
                            rs.getString("billName"),
                            rs.getDouble("billAmount"),
                            rs.getString("paymentStatus"),
                            studentId,
                            rs.getInt("billSequencePerStudent")
                        );
                        billList.add(bill);
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

        if (studentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("payBill".equals(action)) {
            String billNoStr = request.getParameter("billNo");

            if (billNoStr != null && !billNoStr.isEmpty()) {
                try {
                    int billNo = Integer.parseInt(billNoStr);

                    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD)) {
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Update payment status
                        try (PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE bills SET paymentStatus = 'Paid' WHERE billNo = ? AND studentID = ?")) {
                            pstmt.setInt(1, billNo);
                            pstmt.setString(2, studentId);
                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                // Display bill sequence number instead of billNo-1
                                try (PreparedStatement seqStmt = conn.prepareStatement(
                                    "SELECT billSequencePerStudent FROM bills WHERE billNo = ?")) {
                                    seqStmt.setInt(1, billNo);
                                    try (ResultSet rs = seqStmt.executeQuery()) {
                                        if (rs.next()) {
                                            int seqNo = rs.getInt("billSequencePerStudent");
                                            request.setAttribute("message", 
                                                "Bill " + seqNo + " paid successfully!");
                                        }
                                    }
                                }
                            } else {
                                request.setAttribute("error", "Payment failed. Bill not found or already paid.");
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Payment error: " + e.getMessage());
                }
            } else {
                request.setAttribute("error", "Missing bill information");
            }
        }

        doGet(request, response);
    }
}