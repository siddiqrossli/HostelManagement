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

@WebServlet("/requestMaintenance")
public class RequestMaintenanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish"; // Your database username
    private static final String DB_PASSWORD = "kakilangit"; // The password for the 'farish' user

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get existing session, don't create new one
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp"); // Redirect to login page if no session or studentId
            return;
        }

        // Retrieve studentId and studentName from session as separate attributes
        String studentId = (String) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");

        // Fetch student details (studNumber, roomID) from the database
        String phoneNumber = null;  // Will store value from studNumber
        String roomNumber = null;   // Will store value from roomID

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
            // Re-set student details for display on the JSP after error
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

        // Retrieve form parameters from JSP
        String category = request.getParameter("category");
        String details = request.getParameter("details");

        // Input validation
        if (category == null || category.trim().isEmpty() || details == null || details.trim().isEmpty()) {
            request.setAttribute("message", "Please select a category and provide maintenance details.");
            request.setAttribute("messageType", "error");
            // Re-set student details and submitted category/details for display on the JSP after validation error
            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);
            request.setAttribute("category", category); // To retain user input for category
            request.setAttribute("details", details);   // To retain user input for details
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
            return;
        }

        // --- Prepare mainDescription (now ONLY details) ---
        String mainDescription = details; // <--- CHANGE IS HERE!

        // --- Get mainDate ---
        LocalDate mainDate = LocalDate.now();

        // Initial status
        String mainStatus = "Pending";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet generatedKeys = null;
        String generatedMainID = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            // SQL to insert the maintenance request into the 'maintenance' table
            // Assuming mainID is AUTO_INCREMENT, so we don't include it in the INSERT list
            String sql = "INSERT INTO maintenance (mainCat, mainDescription, mainDate, mainStatus, staffID, studentID, roomID) VALUES (?, ?, ?, ?, ?, ?, ?)";

            // Use Statement.RETURN_GENERATED_KEYS to get the auto-generated ID
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set parameters for the INSERT statement
            pstmt.setString(1, category);        // mainCat
            pstmt.setString(2, mainDescription); // Only details now
            pstmt.setDate(3, java.sql.Date.valueOf(mainDate));
            pstmt.setString(4, mainStatus);
            pstmt.setNull(5, java.sql.Types.VARCHAR); // staffID is NULL initially
            pstmt.setString(6, studentId);
            pstmt.setString(7, roomNumber);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    long autoIncId = generatedKeys.getLong(1);
                    generatedMainID = String.format("MAT%03d", autoIncId); // Format: MAT001, MAT002, etc.
                }

                request.setAttribute("message", "Maintenance request submitted successfully! Your Request ID is: " + generatedMainID);
                request.setAttribute("messageType", "success");
                // Clear the form fields after successful submission
                request.setAttribute("category", "");
                request.setAttribute("details", "");
            } else {
                request.setAttribute("message", "Failed to submit maintenance request. Please try again.");
                request.setAttribute("messageType", "error");
            }
            // Re-set student details and submitted category/details for display on the JSP after submission/error
            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);
            // category and details are already set above for error or cleared for success
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "JDBC Driver not found.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if no session or studentId
            return;
        }

        // Retrieve studentId and studentName from session
        String studentId = (String) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");

        // Fetch remaining student details (studNumber, roomID) from the database
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
                phoneNumber = rs.getString("studNumber"); // Map studNumber to phoneNumber
                roomNumber = rs.getString("roomID");      // Map roomID to roomNumber
            } else {
                System.err.println("Error: Student details not found for ID: " + studentId + " in RequestMaintenanceServlet doGet.");
                request.setAttribute("message", "Student details not found. Please log in again.");
                request.setAttribute("messageType", "error");
                request.getRequestDispatcher("login.jsp").forward(request, response); // Redirect to login if critical
                return;
            }

            // Set attributes to be displayed on the JSP
            request.setAttribute("studentId", studentId);
            request.setAttribute("studentName", studentName);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("roomNumber", roomNumber);

            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found.");
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error retrieving student details: " + e.getMessage());
            request.getRequestDispatcher("requestMaintenance.jsp").forward(request, response); // Forward to requestMaintenance.jsp
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