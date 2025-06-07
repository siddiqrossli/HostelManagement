package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/requestMaintenance")
public class RequestMaintenanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish"; // Your database username
    private static final String DB_PASSWORD = "kakilangit"; // The password for the 'farish' user

    private static final Map<String, String> CATEGORY_TO_STAFF_POSITION_MAP = new HashMap<>();

    @Override
    public void init() throws ServletException {
        // Initialize the mapping when the servlet starts
        CATEGORY_TO_STAFF_POSITION_MAP.put("Plumbing Issue", "Plumber");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Electrical Issue", "Electrician");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Furniture Damage", "Staff");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Air-Conditioning", "Electrician");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Pest Control", "Cleaner");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Cleaning Services", "Cleaner");
        CATEGORY_TO_STAFF_POSITION_MAP.put("Other", "Staff"); // <--- CHANGE THIS LINE FROM "Admin" TO "Staff"
    }

    // ... (rest of your doPost and doGet methods remain the same)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get existing session, don't create new one
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp"); // Redirect to login page if no session or studentId
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");

        String phoneNumber = null;
        String roomNumber = null;

        // Fetch student details (studNumber, roomID) from the database
        Connection connFetchStudentDetails = null;
        PreparedStatement pstmtFetchStudentDetails = null;
        ResultSet rsFetchStudentDetails = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connFetchStudentDetails = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            String fetchSql = "SELECT studNumber, roomID FROM student WHERE studentID = ?";
            pstmtFetchStudentDetails = connFetchStudentDetails.prepareStatement(fetchSql);
            pstmtFetchStudentDetails.setString(1, studentId);
            rsFetchStudentDetails = pstmtFetchStudentDetails.executeQuery();

            if (rsFetchStudentDetails.next()) {
                phoneNumber = rsFetchStudentDetails.getString("studNumber"); // Map studNumber to phoneNumber
                roomNumber = rsFetchStudentDetails.getString("roomID");      // Map roomID to roomNumber
            } else {
                request.setAttribute("message", "Could not retrieve student details. Please try logging in again.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("login.jsp").forward(request, response); // Redirect to login on critical error
                return;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error fetching student details: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
            return;
        } finally {
            try {
                if (rsFetchStudentDetails != null) rsFetchStudentDetails.close();
                if (pstmtFetchStudentDetails != null) pstmtFetchStudentDetails.close();
                if (connFetchStudentDetails != null) connFetchStudentDetails.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        String category = request.getParameter("category");
        String details = request.getParameter("details");

        if (category == null || category.trim().isEmpty() || details == null || details.trim().isEmpty()) {
            request.setAttribute("message", "Please select a category and provide maintenance details.");
            request.setAttribute("messageType", "error");
            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);
            request.setAttribute("category", category);
            request.setAttribute("details", details);
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
            return;
        }

        String mainDescription = details;
        LocalDate mainDate = LocalDate.now();
        String mainStatus = "Pending"; // Initial status

        String assignedStaffId = null; // This will hold the staffID

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String generatedMainID = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            String targetStaffPosition = CATEGORY_TO_STAFF_POSITION_MAP.get(category);

            if (targetStaffPosition != null) {
                assignedStaffId = getStaffIdForPosition(conn, targetStaffPosition);

                if (assignedStaffId == null) {
                    // If no staff found for the specific position from the map, fall back to general Staff
                    // This scenario shouldn't happen if your staff data is consistent, but it's a safety net.
                    assignedStaffId = getStaffIdForPosition(conn, "Staff"); // Fallback to general Staff
                    if (assignedStaffId == null) {
                        request.setAttribute("message", "No suitable staff found for this request. Please contact hostel management.");
                        request.setAttribute("messageType", "error");
                        request.setAttribute("studentId", studentId);
                        request.setAttribute("studentName", studentName);
                        request.setAttribute("phoneNumber", phoneNumber);
                        request.setAttribute("roomNumber", roomNumber);
                        request.setAttribute("category", category);
                        request.setAttribute("details", details);
                        request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
                        return;
                    }
                }
            } else {
                // This block handles cases where 'category' might not be in the map at all,
                // which ideally shouldn't happen if the dropdown is fixed.
                // However, as a final fallback, try to assign to a general "Staff"
                 assignedStaffId = getStaffIdForPosition(conn, "Staff"); // Default to Staff if category not mapped or no specific staff found
                 if (assignedStaffId == null) {
                     request.setAttribute("message", "No suitable staff found for this request.");
                     request.setAttribute("messageType", "error");
                     request.setAttribute("studentId", studentId);
                     request.setAttribute("studentName", studentName);
                     request.setAttribute("phoneNumber", phoneNumber);
                     request.setAttribute("roomNumber", roomNumber);
                     request.setAttribute("category", category);
                     request.setAttribute("details", details);
                     request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
                     return;
                 }
            }


            String sql = "INSERT INTO maintenance (mainCat, mainDescription, mainDate, mainStatus, staffID, studentID, roomID) VALUES (?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, category);
            pstmt.setString(2, mainDescription);
            pstmt.setDate(3, java.sql.Date.valueOf(mainDate));
            pstmt.setString(4, mainStatus);
            pstmt.setString(5, assignedStaffId); // Set the assigned staffID here!
            pstmt.setString(6, studentId);
            pstmt.setString(7, roomNumber);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    long autoIncId = generatedKeys.getLong(1);
                    generatedMainID = String.format("MAT%03d", autoIncId);
                }

                request.setAttribute("message", "Maintenance request submitted successfully! Your Request ID is: " + generatedMainID + ". Assigned to Staff ID: " + assignedStaffId);
                request.setAttribute("messageType", "success");
                request.setAttribute("category", "");
                request.setAttribute("details", "");
            } else {
                request.setAttribute("message", "Failed to submit maintenance request. Please try again.");
                request.setAttribute("messageType", "error");
            }

            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "JDBC Driver not found.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String getStaffIdForPosition(Connection conn, String staffPosition) throws SQLException {
        String staffId = null;
        // Prioritize active staff, or you can implement round-robin if multiple staff for a position
        String sql = "SELECT staffID FROM staff WHERE staffPosition = ? LIMIT 1"; //
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, staffPosition);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                staffId = rs.getString("staffID");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
        return staffId;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");

        String phoneNumber = null;
        String roomNumber = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            String sql = "SELECT studNumber, roomID FROM student WHERE studentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                phoneNumber = rs.getString("studNumber");
                roomNumber = rs.getString("roomID");
            } else {
                System.err.println("Error: Student details not found for ID: " + studentId + " in RequestMaintenanceServlet doGet.");
                request.setAttribute("message", "Student details not found. Please log in again.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);

            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found.");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error retrieving student details: " + e.getMessage());
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}