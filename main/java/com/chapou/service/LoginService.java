package com.chapou.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.chapou.config.DbConfig;
import com.chapou.model.CustomerModel;
import com.chapou.util.PasswordUtil;

/**
 * Service class for handling login operations. Connects to the database,
 * verifies user credentials, and returns login status.
 */
public class LoginService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection.
     */
    public LoginService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    /**
     * Validates the user credentials against the database records.
     *
     * @param customer the CustomerModel object containing login credentials
     * @return true if credentials are valid, false otherwise; null if connection
     *         error
     */
    public Boolean loginUser(CustomerModel customer) {
        if (isConnectionError) {
            System.out.println("Connection Error!");
            return null;
        }

        String query = "SELECT username, password FROM customer WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, customer.getUsername());
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                return validatePassword(result, customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return false;
    }

    /**
     * Validates the password retrieved from the database.
     */
    private boolean validatePassword(ResultSet result, CustomerModel customer) throws SQLException {
        String dbUsername = result.getString("username");
        String dbPassword = result.getString("password");

        return dbUsername.equals(customer.getUsername()) &&
                PasswordUtil.decrypt(dbPassword, dbUsername).equals(customer.getPassword());
    }
}
