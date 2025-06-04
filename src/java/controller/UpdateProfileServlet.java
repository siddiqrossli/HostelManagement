package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/updateProfile") // Map this servlet to /updateProfile URL
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details (consider moving these to a separate utility class for reusability)
    private String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private String jdbcUsername = "farish"; // Your database user
    private String jdbcPassword = "kakilangit"; // Password for 'farish' user

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Do not create a new session if one doesn't exist

        if (session == null || session.getAttribute("studentId") == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "SELECT studName, studNumber, studEmergencyNumber FROM student WHERE studentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Set existing profile data as request attributes to pre-fill the form
                request.setAttribute("studName", rs.getString("studName"));
                request.setAttribute("studNumber", rs.getString("studNumber"));
                request.setAttribute("studEmergencyNumber", rs.getString("studEmergencyNumber"));
                request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
            } else {
                // Should not happen if studentId is from a valid session
                request.setAttribute("error", "Student profile not found.");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } finally {
            // Close resources in a finally block
            try { if (rs != null) rs.close(); } catch (SQLException e) { /* log */ }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* log */ }
            try { if (conn != null) conn.close(); } catch (SQLException e) { /* log */ }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        String newStudName = request.getParameter("studName");
        String newStudNumber = request.getParameter("studNumber");
        String newStudEmergencyNumber = request.getParameter("studEmergencyNumber");

        // Basic validation for new data
        if (newStudName == null || newStudName.trim().isEmpty() ||
            newStudNumber == null || newStudNumber.trim().isEmpty() ||
            newStudEmergencyNumber == null || newStudEmergencyNumber.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required for update.");
            // Forward back to the form, pre-filling with already submitted data
            request.setAttribute("studName", newStudName);
            request.setAttribute("studNumber", newStudNumber);
            request.setAttribute("studEmergencyNumber", newStudEmergencyNumber);
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "UPDATE student SET studName = ?, studNumber = ?, studEmergencyNumber = ? WHERE studentID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStudName);
            pstmt.setString(2, newStudNumber);
            pstmt.setString(3, newStudEmergencyNumber);
            pstmt.setString(4, studentId); // Use the student ID from session for the WHERE clause

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Update session attributes with new name (if name was updated)
                session.setAttribute("studentName", newStudName);
                // Set a success message in session to be displayed on the dashboard
                session.setAttribute("successMessage", "Profile updated successfully!");
                response.sendRedirect("dashboard.jsp"); // Redirect back to dashboard
            } else {
                request.setAttribute("error", "Profile update failed. No records found or updated.");
                // Forward back to the form with current (failed) inputs
                request.setAttribute("studName", newStudName);
                request.setAttribute("studNumber", newStudNumber);
                request.setAttribute("studEmergencyNumber", newStudEmergencyNumber);
                request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
        } finally {
            // Close resources
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* log */ }
            try { if (conn != null) conn.close(); } catch (SQLException e) { /* log */ }
        }
    }
}