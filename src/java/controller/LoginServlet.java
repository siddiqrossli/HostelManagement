package controller;

import model.Student;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String pass = request.getParameter("password");

        // Validate input fields
        if (id == null || pass == null || id.trim().isEmpty() || pass.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both student ID and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // SQL query to validate user credentials
        String sql = "SELECT * FROM student WHERE studentID = ? AND studPassword = ?";

        // Use try-with-resources to automatically close connection and statement
        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/HostelManagementNB", "app", "app");
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the parameters for the SQL query
            pstmt.setString(1, id);
            pstmt.setString(2, pass);

            // Execute the query
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // User found, create session and store student info in session
                HttpSession session = request.getSession();
                session.setAttribute("studentId", id);  // Store studentId in session
                session.setAttribute("studentName", rs.getString("studName"));  // Store studentName in session

                response.sendRedirect("studentDashboard.jsp");  // Redirect to student dashboard
            } else {
                // Invalid credentials
                request.setAttribute("error", "Invalid student ID or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);  // Stay on login page
            }

        } catch (SQLException e) {
            // Handle SQL exceptions (database errors)
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("login.jsp");  // Redirect to login page if accessed via GET
    }
}
