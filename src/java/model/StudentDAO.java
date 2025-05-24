package model;

import java.sql.*;

public class StudentDAO {
    private Connection conn;

    // Constructor: Initialize database connection
    public StudentDAO() {
        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelmanagement", "root", "");

            // Check if the connection is successful
            if (conn != null) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Database connection failed.");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
        }
    }

    // INSERT: Add student to the database
    public void addStudent(Student student) {
        String sql = "INSERT INTO student (studentID, studPasswords, studName, studNumber, studEmergencyNumber, studSemester, studCGPA, houseIncome, studGender, roomID) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set the values for each parameter in the SQL statement
            stmt.setString(1, student.getStudentId());          // studentID
            stmt.setString(2, student.getPassword());           // studPasswords
            stmt.setString(3, student.getName());               // studName
            stmt.setString(4, student.getPhone());              // studNumber
            stmt.setString(5, student.getEmergencyContact());   // studEmergencyNumber
            stmt.setInt(6, student.getSemester());              // studSemester
            stmt.setString(7, student.getCgpa());               // studCGPA
            stmt.setString(8, student.getHouseIncome());        // houseIncome
            stmt.setString(9, student.getGender());             // studGender
            stmt.setString(10, student.getRoomId());            // roomID

            // Execute the insert statement
            stmt.executeUpdate();
            System.out.println("Student added successfully.");
        } catch (SQLException e) {
            System.err.println("SQL Error: Failed to add student. " + e.getMessage());
            e.printStackTrace();
        }
    }

    // LOGIN: Get student by ID and password
    public Student getStudentByIdAndPassword(String id, String password) {
        Student student = null;
        String sql = "SELECT * FROM student WHERE studentID = ? AND stuPassword = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
                student.setPassword(rs.getString("stuPassword"));
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: Failed to retrieve student. " + e.getMessage());
            e.printStackTrace();
        }

        return student;
    }

    // Method to close the connection when it's no longer needed
    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing database connection: " + e.getMessage());
        }
    }
}
