package controller;

import model.Student;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        // The database connection setup should be done only when needed (in doPost)
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Retrieve form parameters and set them to the Student object
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String emergencyContact = request.getParameter("emergencyContact");
        String semesterStr = request.getParameter("semester");
        String cgpa = request.getParameter("cgpa");
        String houseIncome = request.getParameter("houseIncome");
        String gender = request.getParameter("gender");

        // Validate form fields
        if (studentId == null || password == null || name == null || phone == null || emergencyContact == null ||
            semesterStr == null || cgpa == null || houseIncome == null || gender == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Convert semester to integer
        int semester = Integer.parseInt(semesterStr);

        // SQL query to insert data into the student table
        String sql = "INSERT INTO student (studentID, studPassword, studName, studNumber, studEmergencyNumber, studSemester, studCGPA, houseIncome, studGender, roomID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // Use try-with-resources to automatically close connection and statement
        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/HostelManagementNB", "app", "app");
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Prepare the statement
            pstmt.setString(1, studentId);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, phone);
            pstmt.setString(5, emergencyContact);
            pstmt.setInt(6, semester);
            pstmt.setString(7, cgpa);
            pstmt.setString(8, houseIncome);
            pstmt.setString(9, gender);
            pstmt.setNull(10, Types.VARCHAR); // roomID is automatically set to NULL

            // Execute the SQL insert
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("login.jsp");  // Redirect to login page after successful registration
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            // Log error and set attribute for error message
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("register.jsp");  // Redirect to register page if accessed via GET
    }
}
