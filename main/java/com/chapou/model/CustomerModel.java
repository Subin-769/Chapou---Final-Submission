package com.chapou.model;

import java.sql.Timestamp;
import java.time.LocalDate;

public class CustomerModel {
    private int User_Id;
    private String Full_Name;
    private String Username;
    private String Password;
    private LocalDate DOB;
    private String Gender;
    private String Email;
    private String Phone_Number;
    private String Profile_Image; 
    private Timestamp Created_At;

    // Constructor
    public CustomerModel() {}

    public CustomerModel(int User_Id, String Full_Name, String Username, String Password,
                         LocalDate DOB, String Gender, String Email, String Phone_Number,
                         String Profile_Image, Timestamp Created_At) {
        this.User_Id = User_Id;
        this.Full_Name = Full_Name;
        this.Username = Username;
        this.Password = Password;
        this.DOB = DOB;
        this.Gender = Gender;
        this.Email = Email;
        this.Phone_Number = Phone_Number;
        this.Profile_Image = Profile_Image;
        this.Created_At = Created_At;
    }

    // Getters and Setters
    public int getUser_Id() {
        return User_Id;
    }

    public void setUser_Id(int user_Id) {
        this.User_Id = user_Id;
    }

    public String getFull_Name() {
        return Full_Name;
    }

    public void setFull_Name(String full_Name) {
        this.Full_Name = full_Name;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        this.Username = username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String password) {
        this.Password = password;
    }

    public LocalDate getDOB() {
        return DOB;
    }

    public void setDOB(LocalDate DOB) {
        this.DOB = DOB;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        this.Gender = gender;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        this.Email = email;
    }

    public String getPhone_Number() {
        return Phone_Number;
    }

    public void setPhone_Number(String phone_Number) {
        this.Phone_Number = phone_Number;
    }

    public String getProfileImage() {
        return Profile_Image;
    }

    public void setProfileImage(String profileImage) {
        this.Profile_Image = profileImage;
    }

    public Timestamp getCreated_At() {
        return Created_At;
    }

    public void setCreated_At(Timestamp created_At) {
        this.Created_At = created_At;
    }
}
