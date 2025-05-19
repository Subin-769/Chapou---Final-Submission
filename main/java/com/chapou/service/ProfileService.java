package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.ProfileModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProfileService {

    public ProfileModel getUserByUsername(String username) {
        ProfileModel profile = null;

        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT * FROM customer WHERE Username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                profile = new ProfileModel();
                profile.setFullName(rs.getString("Full_Name"));
                profile.setUsername(rs.getString("Username"));
                profile.setPassword(rs.getString("Password"));
                profile.setGender(rs.getString("Gender"));
                profile.setEmail(rs.getString("Email"));
                profile.setDob(rs.getString("DOB"));
                profile.setPhone(rs.getString("Phone_Number"));
                profile.setProfile_Image(rs.getString("Profile_Image")); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return profile;
    }
    
    public boolean updateProfile(ProfileModel profile) {
        boolean success = false;

        try (Connection conn = DbConfig.getDbConnection()) {
            String updateQuery = "UPDATE customer SET Full_Name = ?, Password = ?, Gender = ?, Email = ?, DOB = ?, Phone_Number = ?, Profile_Image = ? WHERE Username = ?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, profile.getFullName());
            stmt.setString(2, profile.getPassword());
            stmt.setString(3, profile.getGender());
            stmt.setString(4, profile.getEmail());
            stmt.setString(5, profile.getDob());
            stmt.setString(6, profile.getPhone());
            stmt.setString(7, profile.getProfile_Image());
            stmt.setString(8, profile.getUsername());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
    
    public int getCustomerIdByUsername(String username) {
        int id = -1;
        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT User_Id FROM customer WHERE Username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                id = rs.getInt("User_Id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

}
