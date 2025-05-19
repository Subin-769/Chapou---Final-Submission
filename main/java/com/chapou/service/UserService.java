package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.CustomerModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    public List<CustomerModel> getAllUsers() {
        List<CustomerModel> users = new ArrayList<>();

        String query = "SELECT * FROM customer";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CustomerModel user = new CustomerModel();
                user.setUser_Id(rs.getInt("User_Id"));
                user.setFull_Name(rs.getString("Full_Name"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setGender(rs.getString("Gender"));
                user.setEmail(rs.getString("Email"));
                user.setPhone_Number(rs.getString("Phone_Number"));

                Date dob = rs.getDate("DOB");
                if (dob != null) {
                    user.setDOB(dob.toLocalDate());
                }

                Timestamp createdAt = rs.getTimestamp("Created_At");
                if (createdAt != null) {
                    user.setCreated_At(createdAt);
                }

                user.setProfileImage(rs.getString("Profile_Image"));
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public void updateUser(CustomerModel user) {
        String sql = "UPDATE customer SET Full_Name=?, Username=?, Email=?, Phone_Number=?, Gender=? WHERE User_Id=?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFull_Name());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone_Number());
            stmt.setString(5, user.getGender());
            stmt.setInt(6, user.getUser_Id());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public void deleteUser(int userId) {
        String query = "DELETE FROM customer WHERE User_Id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public CustomerModel getUserById(int userId) {
        CustomerModel user = null;
        String sql = "SELECT * FROM customer WHERE User_Id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new CustomerModel();
                user.setUser_Id(rs.getInt("User_Id"));
                user.setFull_Name(rs.getString("Full_Name"));
                user.setUsername(rs.getString("Username"));
                user.setEmail(rs.getString("Email"));
                user.setPhone_Number(rs.getString("Phone_Number"));
                // Set other fields as needed
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    
    public List<CustomerModel> searchUsers(String keyword) {
        List<CustomerModel> users = new ArrayList<>();
        String sql = "SELECT * FROM customer WHERE Full_Name LIKE ? OR Username LIKE ? OR Email LIKE ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String like = "%" + keyword + "%";
            stmt.setString(1, like);
            stmt.setString(2, like);
            stmt.setString(3, like);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CustomerModel user = new CustomerModel();
                user.setUser_Id(rs.getInt("User_Id"));
                user.setFull_Name(rs.getString("Full_Name"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setGender(rs.getString("Gender"));
                user.setEmail(rs.getString("Email"));
                user.setPhone_Number(rs.getString("Phone_Number"));

                Date dob = rs.getDate("DOB");
                if (dob != null) {
                    user.setDOB(dob.toLocalDate());
                }

                user.setProfileImage(rs.getString("Profile_Image"));
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

}
