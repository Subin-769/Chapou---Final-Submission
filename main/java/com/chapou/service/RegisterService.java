package com.chapou.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.chapou.config.DbConfig;
import com.chapou.model.CustomerModel;

/**
 * RegisterService handles the registration of new customers.
 */
public class RegisterService {

    /**
     * Adds a new customer to the database.
     * Uses a fresh DB connection for each call to avoid stale connections.
     */
    public Boolean addCustomer(CustomerModel customer) {
        try (Connection dbConn = DbConfig.getDbConnection()) {

            String insertQuery = "INSERT INTO customer (Full_Name, Username, Password, DOB, Gender, Email, Phone_Number, Profile_Image) "
                               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
                insertStmt.setString(1, customer.getFull_Name());
                insertStmt.setString(2, customer.getUsername());
                insertStmt.setString(3, customer.getPassword());
                insertStmt.setDate(4, Date.valueOf(customer.getDOB()));
                insertStmt.setString(5, customer.getGender());
                insertStmt.setString(6, customer.getEmail());
                insertStmt.setString(7, customer.getPhone_Number());
                insertStmt.setString(8, customer.getProfileImage()); 

                boolean inserted = insertStmt.executeUpdate() > 0;
                System.out.println("Insert status: " + inserted);
                return inserted;

            } catch (java.sql.SQLIntegrityConstraintViolationException e) {
                System.err.println("Duplicate entry for username or email.");
                e.printStackTrace();
                return false;

            } catch (SQLException e) {
                System.err.println("Error during customer registration: " + e.getMessage());
                e.printStackTrace();
                return null;
            }

        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            return null;
        }
    }
    
 public boolean isUsernameExists(String username) {
	    String sql = "SELECT 1 FROM customer WHERE username = ?";
	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, username);
	        return stmt.executeQuery().next();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean isEmailExists(String email) {
	    String sql = "SELECT 1 FROM customer WHERE email = ?";
	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, email);
	        return stmt.executeQuery().next();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean isPhoneExists(String phone) {
	    String sql = "SELECT 1 FROM customer WHERE phone_number = ?";
	    try (Connection conn = DbConfig.getDbConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, phone);
	        return stmt.executeQuery().next();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}


}
