package com.recipe.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {
    private static final String DB_URL = "jdbc:sqlite:recipe_management.db";

    // Get database connection
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection(DB_URL);

            // Enable foreign keys
            Statement stmt = conn.createStatement();
            stmt.execute("PRAGMA foreign_keys = ON");
            stmt.close();

            return conn;
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQLite JDBC Driver not found", e);
        }
    }

    // Initialize database with tables
    public static void initializeDatabase() {
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            // Create users table
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "username TEXT NOT NULL UNIQUE," +
                    "password TEXT NOT NULL," +
                    "email TEXT NOT NULL," +
                    "role TEXT NOT NULL," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            // Create recipes table
            stmt.execute("CREATE TABLE IF NOT EXISTS recipes (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT," +
                    "name TEXT NOT NULL," +
                    "ingredients TEXT NOT NULL," +
                    "instructions TEXT NOT NULL," +
                    "category TEXT NOT NULL," +
                    "status TEXT NOT NULL," +
                    "user_id INTEGER NOT NULL," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                    "FOREIGN KEY (user_id) REFERENCES users(id))");

            // Insert admin user if not exists
            stmt.execute("INSERT OR IGNORE INTO users (username, password, email, role) " +
                    "VALUES ('admin', 'admin123', 'admin@example.com', 'admin')");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}