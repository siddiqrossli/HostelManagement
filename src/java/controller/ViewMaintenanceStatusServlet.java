package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date; // Add this import for java.util.Date

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MaintenanceRequest;

@WebServlet("/viewMaintenanceStatus")
public class ViewMaintenanceStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish"; // Your database username
    private static final String DB_PASSWORD = "kakilangit"; // The password for the 'farish' user

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");

        List<MaintenanceRequest> maintenanceRequests = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            String sql = "SELECT mainID, mainCat, mainDescription, mainDate, mainStatus " +
                         "FROM maintenance " +
                         "WHERE studentID = ? " +
                         "ORDER BY mainDate DESC";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MaintenanceRequest req = new MaintenanceRequest();
                req.setMainID(String.format("MAT%03d", rs.getInt("mainID")));
                req.setMainCat(rs.getString("mainCat"));
                req.setMainDescription(rs.getString("mainDescription"));

                // --- CHANGE IS HERE ---
                // Get as java.sql.Date (which is a subclass of java.util.Date)
                java.sql.Date sqlDate = rs.getDate("mainDate");
                req.setMainDate(sqlDate); // Directly set java.sql.Date to java.util.Date field

                req.setMainStatus(rs.getString("mainStatus"));
                maintenanceRequests.add(req);
            }

            request.setAttribute("maintenanceRequests", maintenanceRequests);
            request.getRequestDispatcher("viewMaintenanceStatus.jsp").forward(request, response);

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
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}