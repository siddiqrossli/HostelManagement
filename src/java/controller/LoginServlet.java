package controller;

import model.Student; // Assuming you have this model class
import java.io.*;
import java.sql.*; // Make sure ResultSet is imported from here
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet; // Don't forget this import for @WebServlet annotation

@WebServlet("/login") // This maps the URL '/login' to this servlet
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; // Recommended for Servlets

    @Override
    public void init() throws ServletException {
        // No code needed here for this scenario
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String pass = request.getParameter("password");

        // Validate input fields - basic null and empty check
        if (id == null || pass == null || id.trim().isEmpty() || pass.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both student ID and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
        String jdbcUsername = "farish"; // Your user created in phpMyAdmin
        String jdbcPassword = "kakilangit"; // The password for the 'farish' user

        String sql = "SELECT studPassword, studName FROM student WHERE studentID = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, id);

                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storedPlainPassword = rs.getString("studPassword");
                    String studentName = rs.getString("studName");

                    if (pass.equals(storedPlainPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("studentId", id);
                        session.setAttribute("studentName", studentName);

                        // --- CORRECTED PLACEMENT FOR DEBUG PRINTS ---
                        System.out.println("--- LoginServlet Debug ---");
                        System.out.println("Login Successful for Student ID: " + id);
                        System.out.println("Session ID created/retrieved: " + session.getId());
                        System.out.println("Session attribute 'studentId': " + session.getAttribute("studentId"));
                        System.out.println("Session attribute 'studentName': " + session.getAttribute("studentName"));
                        System.out.println("Redirecting to dashboard.jsp");
                        System.out.println("--------------------------");
                        // --- END DEBUG PRINTS ---

                        response.sendRedirect("dashboard.jsp"); // Redirect to student dashboard
                    } else {
                        request.setAttribute("error", "Invalid student ID or password.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Invalid student ID or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found. Please ensure MySQL Connector/J JAR is in your project libraries.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}