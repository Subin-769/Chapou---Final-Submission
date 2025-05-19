package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.ContactModel;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ContactService {

    public boolean saveContact(ContactModel contact) {
        boolean isSuccess = false;

        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "INSERT INTO contact (Name, Email, Phone_Number, Message) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getPhoneNumber());
            stmt.setString(4, contact.getMessage());

            int rows = stmt.executeUpdate();
            isSuccess = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }
}
