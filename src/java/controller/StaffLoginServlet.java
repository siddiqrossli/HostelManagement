package controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/staffLogin")
public class StaffLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        // No specific initialization needed for this servlet at the moment.
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters for staff login
        String staffId = request.getParameter("staffId");
        String staffPass = request.getParameter("staffPassword");

        // Validate input fields - basic null and empty check
        if (staffId == null || staffPass == null || staffId.trim().isEmpty() || staffPass.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Staff ID and password.");
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
        String jdbcUsername = "farish";
        String jdbcPassword = "kakilangit";

        // SQL query to retrieve password, name, AND POSITION from the 'staff' table
        String sql = "SELECT staffPassword, staffName, staffPosition FROM staff WHERE staffID = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Explicitly load the JDBC driver

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, staffId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String storedPlainPassword = rs.getString("staffPassword");
                    String staffName = rs.getString("staffName");
                    String staffPosition = rs.getString("staffPosition"); // Retrieve the position

                    if (staffPass.equals(storedPlainPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("staffID", staffId);
                        session.setAttribute("staffName", staffName);
                        session.setAttribute("staffPosition", staffPosition); // Store position in session

                        // **Role-based redirection based on 'position'**
                        if ("Admin".equalsIgnoreCase(staffPosition)) { // Case-insensitive comparison
                            response.sendRedirect("adminDashboard.jsp");
                        } else {
                            response.sendRedirect("staffDashboard.jsp");
                        }
                    } else {
                        request.setAttribute("error", "Invalid Staff ID or password.");
                        request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Invalid Staff ID or password.");
                    request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found. Please ensure MySQL Connector/J JAR is in your project libraries.");
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("staffLogin.jsp");
    }
}