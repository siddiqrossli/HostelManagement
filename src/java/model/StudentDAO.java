package model;

import java.sql.*;

public class StudentDAO {
    private static final String URL = "jdbc:derby://localhost:1527/HostelManagementNB";
    private static final String USER = "app"; // MySQL username
    private static final String PASSWORD = "app"; // MySQL password (if applicable)

    // Constructor: Initialize database connection
    public StudentDAO() {
        try {
            // Load the MySQL driver for MySQL 8.x
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    // INSERT: Add student to the database
    public void addStudent(Student student) {
    String sql = "INSERT INTO student (studentID, studPasswords, studName, studNumber, studEmergencyNumber, studSemester, studCGPA, houseIncome, studGender, roomID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NULL)";

    try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, student.getStudentId());
        stmt.setString(2, student.getPassword());
        stmt.setString(3, student.getName());
        stmt.setString(4, student.getPhone());
        stmt.setString(5, student.getEmergencyContact());
        stmt.setInt(6, student.getSemester());
        stmt.setString(7, student.getCgpa());
        stmt.setString(8, student.getHouseIncome());
        stmt.setString(9, student.getGender());

        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Student added successfully.");
        } else {
            System.out.println("Failed to add student.");
        }
    } catch (SQLException e) {
        System.err.println("SQL Error: Failed to add student. " + e.getMessage());
        e.printStackTrace();
    }
}


    // LOGIN: Get student by ID and password
    public Student getStudentByIdAndPassword(String id, String password) {
        Student student = null;
        String sql = "SELECT * FROM student WHERE studentID = ? AND studPasswords = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the parameters for the SQL query
            stmt.setString(1, id);
            stmt.setString(2, password);

            // Execute the query
            ResultSet rs = stmt.executeQuery();

            // Check if the student is found
            if (rs.next()) {
                student = new Student();
                student.setStudentId(rs.getString("studentID"));
                student.setName(rs.getString("studName"));
                student.setPhone(rs.getString("studNumber"));
                student.setEmergencyContact(rs.getString("studEmergencyNumber"));
                student.setSemester(rs.getInt("studSemester"));
                student.setCgpa(rs.getString("studCGPA"));
                student.setHouseIncome(rs.getString("houseIncome"));
                student.setGender(rs.getString("studGender"));
                student.setRoomId(rs.getString("roomID"));
                student.setPassword(rs.getString("studPasswords"));
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: Failed to retrieve student. " + e.getMessage());
            e.printStackTrace();
        }

        return student;
    }
}
