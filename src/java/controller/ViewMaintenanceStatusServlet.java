package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

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
    private static final String DB_USERNAME = "farish";
    private static final String DB_PASSWORD = "kakilangit";

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

            // Modified SQL query to LEFT JOIN with the staff table
            String sql = "SELECT m.mainID, m.mainCat, m.mainDescription, m.mainDate, m.mainStatus, " +
                         "s.staffName, s.staffNumber " + // Select staff details
                         "FROM maintenance m " +
                         "LEFT JOIN staff s ON m.staffID = s.staffID " + // Join on staffID
                         "WHERE m.studentID = ? " +
                         "ORDER BY m.mainDate DESC";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, studentId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MaintenanceRequest req = new MaintenanceRequest();
                req.setMainID(String.format("MAT%03d", rs.getInt("mainID")));
                req.setMainCat(rs.getString("mainCat"));
                req.setMainDescription(rs.getString("mainDescription"));

                java.sql.Date sqlDate = rs.getDate("mainDate");
                req.setMainDate(sqlDate);

                // Retrieve staff details and set them in the MaintenanceRequest object
                req.setStaffName(rs.getString("staffName")); //
                req.setStaffNumber(rs.getString("staffNumber")); //

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