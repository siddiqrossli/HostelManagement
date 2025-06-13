package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.StudentAppeal;

public class ViewAppealServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // --- Database Connection Details (Now duplicated here) ---
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hostel_management?zeroDateTimeBehavior=convertToNull&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String DB_USERNAME = "farish"; // Your database username
    private static final String DB_PASSWORD = "kakilangit"; // Your database password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("studentId") == null && session.getAttribute("staffId") == null)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        String staffId = (String) session.getAttribute("staffId"); // Corrected to lowercase 'id'

        List<StudentAppeal> appealList = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USERNAME, DB_PASSWORD);

            String sql;
            if (studentId != null) {
                // SQL for student's view
                sql = "SELECT sa.appealID, sa.reason AS appealReason, sa.appealDate, sa.appealStatus, " +
                      "s.studentID, s.studName, s.studNumber, s.studCGPA, s.houseIncome " +
                      "FROM student_appeal sa " +
                      "LEFT JOIN student s ON sa.studentID = s.studentID " +
                      "WHERE sa.studentID = ? ORDER BY sa.appealDate DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, studentId);
            } else if (staffId != null) {
                // SQL for staff's view
                sql = "SELECT sa.appealID, sa.reason AS appealReason, sa.appealDate, sa.appealStatus, " +
                      "s.studentID, s.studName, s.studNumber, s.studCGPA, s.houseIncome " +
                      "FROM student_appeal sa " +
                      "LEFT JOIN student s ON sa.studentID = s.studentID " +
                      "ORDER BY sa.appealDate DESC";
                pstmt = conn.prepareStatement(sql);
            } else {
                response.sendRedirect("login.jsp"); // Fallback, though checked above
                return;
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                StudentAppeal appeal = new StudentAppeal();
                appeal.setAppealID(rs.getString("appealID"));
                appeal.setStudentID(rs.getString("studentID"));
                appeal.setStudName(rs.getString("studName"));
                appeal.setStudNumber(rs.getString("studNumber"));
                appeal.setStudCGPA(rs.getDouble("studCGPA"));
                appeal.setHouseIncome(rs.getDouble("houseIncome"));
                appeal.setAppealReason(rs.getString("appealReason"));
                appeal.setAppealDate(rs.getDate("appealDate"));
                appeal.setAppealStatus(rs.getString("appealStatus"));

                appealList.add(appeal);
            }

            request.setAttribute("appealList", appealList);
            
            String targetJSP;
            if (studentId != null) {
                targetJSP = "appealList.jsp"; // Assuming student also views appealList.jsp
            } else {
                targetJSP = "appealList.jsp"; // Staff's view
            }
            request.getRequestDispatcher(targetJSP).forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "System Error: JDBC driver not found.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            // Close JDBC resources in reverse order of creation
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