package controller;

// No direct model.Student import needed if staff has its own model or isn't used
// import model.Staff; // If you create a Staff model class, import it here
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet; // Don't forget this import for @WebServlet annotation

@WebServlet("/staffLogin") // IMPORTANT: Map this servlet to a new URL, e.g., "/staffLogin"
public class StaffLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; // Recommended for Servlets

    @Override
    public void init() throws ServletException {
        // No code needed here for this scenario
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Retrieve form parameters for staff login
        String staffId = request.getParameter("staffId"); // Assuming input field name is "staffId"
        String staffPass = request.getParameter("staffPassword"); // Assuming input field name is "staffPassword"

        // Validate input fields - basic null and empty check
        if (staffId == null || staffPass == null || staffId.trim().isEmpty() || staffPass.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Staff ID and password.");
            // Redirect to a staff login JSP, e.g., "staffLogin.jsp"
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
            return;
        }

        // Database connection details
        // **IMPORTANT: Ensure 'hostel_management' matches your exact database name (case-sensitive if on Linux)**
        String jdbcURL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
        String jdbcUsername = "farish"; // Or a specific staff-level database user if you create one
        String jdbcPassword = "kakilangit"; // The password for the 'farish' user

        // SQL query to retrieve the plain-text password and name for comparison from the 'staff' table
        // **WARNING: This approach is INSECURE for production applications.**
        // Passwords should always be hashed and compared securely.
        String sql = "SELECT staffPassword, staffName FROM staff WHERE staffID = ?";

        try {
            // Explicitly load the JDBC driver (recommended for robustness)
            Class.forName("com.mysql.cj.jdbc.Driver"); // Use "com.mysql.cj.jdbc.Driver" for MySQL Connector/J 8.x and later

            // Use try-with-resources to automatically close connection and statement
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                // Set the parameter for the SQL query (staffID)
                pstmt.setString(1, staffId);

                // Execute the query
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Staff ID found, now retrieve the stored plain-text password
                    String storedPlainPassword = rs.getString("staffPassword");
                    String staffName = rs.getString("staffName");

                    // Compare the provided plain-text password with the stored plain-text password
                    // **WARNING: This is the INSECURE comparison.**
                    if (staffPass.equals(storedPlainPassword)) {
                        // Password matches, create session and store staff info
                        HttpSession session = request.getSession();
                        session.setAttribute("staffId", staffId);       // Store staffId in session
                        session.setAttribute("staffName", staffName); // Store staffName in session

                        response.sendRedirect("staffDashboard.jsp"); // Redirect to staff dashboard
                    } else {
                        // Password does not match
                        request.setAttribute("error", "Invalid Staff ID or password.");
                        request.getRequestDispatcher("staffLogin.jsp").forward(request, response); // Stay on staff login page
                    }
                } else {
                    // Staff ID not found in the database
                    request.setAttribute("error", "Invalid Staff ID or password.");
                    request.getRequestDispatcher("staffLogin.jsp").forward(request, response); // Stay on staff login page
                }

            } // Connection, PreparedStatement, and ResultSet (implicitly) are automatically closed here
        } catch (ClassNotFoundException e) {
            // This catches errors if the JDBC driver class cannot be found
            e.printStackTrace(); // Print stack trace to server console for debugging
            request.setAttribute("error", "JDBC Driver not found. Please ensure MySQL Connector/J JAR is in your project libraries.");
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
        } catch (SQLException e) {
            // This catches any database-related errors (e.g., connection issues, query errors)
            e.printStackTrace(); // Print stack trace to server console for debugging
            request.setAttribute("error", "Database error: " + e.getMessage()); // Provide specific error message to user
            request.getRequestDispatcher("staffLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // If someone tries to access /staffLogin directly via GET, redirect them to the staff login form
        response.sendRedirect("staffLogin.jsp"); // Assuming a staff login JSP exists
    }
}