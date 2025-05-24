package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:derby://localhost:1527/HostelManagementNB";
    private static final String USER = "app";
    private static final String PASSWORD = "app"; // Leave empty if no password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver"); // Load Derby Driver
            System.out.println("Derby Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Derby Driver not found", e);
        }

        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection to database established.");
            return conn;
        } catch (SQLException e) {
            System.err.println("Error establishing connection: " + e.getMessage());
            throw e;
        }
    }
}
