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

@WebServlet("/changePassword") // Map this servlet to /changePassword URL
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database connection details (consider moving these to a separate utility class for reusability)
    private String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private String jdbcUsername = "farish"; // Your database user [cite: image_8391d8.png]
    private String jdbcPassword = "kakilangit"; // Password for 'farish' user [cite: image_8391d8.png]

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Do not create a new session if one doesn't exist

        if (session == null || session.getAttribute("studentId") == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        // Just forward to the JSP to display the form.
        // No need to fetch current password unless you want to display it (which is not recommended for security).
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
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
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // 1. Basic validation for input fields
        if (oldPassword == null || oldPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmNewPassword == null || confirmNewPassword.trim().isEmpty()) {
            request.setAttribute("error", "All password fields are required.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // 2. Validate new password and confirm new password match
        if (!newPassword.equals(confirmNewPassword)) {
            request.setAttribute("error", "New password and confirm password do not match.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // 3. Verify old password against the database
            String selectSql = "SELECT studPassword FROM student WHERE studentID = ?";
            pstmtSelect = conn.prepareStatement(selectSql);
            pstmtSelect.setString(1, studentId);
            rs = pstmtSelect.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("studPassword");

                // **WARNING: This is the INSECURE plain-text comparison.**
                // In a real application, you would hash the 'oldPassword' and compare it to the stored hash.
                if (oldPassword.equals(storedPassword)) {
                    // Old password matches, proceed with update
                    String updateSql = "UPDATE student SET studPassword = ? WHERE studentID = ?";
                    pstmtUpdate = conn.prepareStatement(updateSql);
                    pstmtUpdate.setString(1, newPassword); // <--- CHANGE THIS TO HASHED PASSWORD IN REAL APP
                    pstmtUpdate.setString(2, studentId);

                    int rowsAffected = pstmtUpdate.executeUpdate();

                    if (rowsAffected > 0) {
                        // Password updated successfully
                        session.setAttribute("successMessage", "Password changed successfully!");
                        response.sendRedirect("dashboard.jsp"); // Redirect to dashboard with success message
                    } else {
                        // Should ideally not happen if old password matched and student ID is valid
                        request.setAttribute("error", "Password update failed. No records updated.");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    }
                } else {
                    // Old password does not match
                    request.setAttribute("error", "Incorrect old password.");
                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                }
            } else {
                // Student ID not found (should not happen if session is valid)
                request.setAttribute("error", "Student profile not found for password change.");
                response.sendRedirect("dashboard.jsp"); // Redirect to dashboard or login
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } finally {
            // Close resources in a finally block
            try { if (rs != null) rs.close(); } catch (SQLException e) { /* log */ }
            try { if (pstmtSelect != null) pstmtSelect.close(); } catch (SQLException e) { /* log */ }
            try { if (pstmtUpdate != null) pstmtUpdate.close(); } catch (SQLException e) { /* log */ }
            try { if (conn != null) conn.close(); } catch (SQLException e) { /* log */ }
        }
    }
}