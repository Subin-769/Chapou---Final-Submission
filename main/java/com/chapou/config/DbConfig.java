package com.chapou.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DbConfig manages the connection setup for the Chapou MySQL database.
 */
public class DbConfig {

    // Database connection settings
    private static final String DB_NAME = "chapou";
    private static final String URL = "jdbc:mysql://localhost:3316/" + DB_NAME;
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; 

    /**
     * Provides a Connection object to the database.
     *
     * @return Connection instance to the database
     * @throws SQLException           if a DB access error occurs
     * @throws ClassNotFoundException if JDBC driver class is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}