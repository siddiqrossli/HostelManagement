package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ApplyCollegeServlet extends HttpServlet {

    // Handle POST request (submit the application)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Retrieve the studentId from the form
        String studentId = request.getParameter("studentId");

        // Process the application - store it directly in the database
        applyToCollege(studentId);
        
        // Redirect to a confirmation page or back to the dashboard
        response.sendRedirect("studentDashboard.jsp");  // Redirect to dashboard or confirmation page
    }
    
    // Method to handle the application process and insert into database
    private void applyToCollege(String studentId) {
        // Database connection info
        String url = "jdbc:mysql://localhost:3306/hostelmanagement?zeroDateTimeBehavior=convertToNull";
        String user = "root";
        String password = ""; // Use your MySQL password if applicable

        String sql = "INSERT INTO college_applications (studentId) VALUES (?)";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the values for the PreparedStatement
            stmt.setString(1, studentId);

            // Execute the insert statement
            stmt.executeUpdate();
            System.out.println("Application submitted successfully.");
        } catch (SQLException e) {
            System.err.println("SQL Error: Failed to submit application. " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Handle GET request (if needed for additional functionality)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("applyCollege.jsp");  // If needed, redirect to the form page
    }
}
