package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBTest{

    public static void main(String[] args) {
        // Database connection details
        String url = "jdbc:derby://localhost:1527/HostelManagementNB";
        String user = "app";  // Replace with your MySQL username
        String password = "app";  // Replace with your MySQL password if necessary

        // Establish the connection
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            if (conn != null) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Database connection failed.");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
