package com.chapou.model;

public class ProfileModel {
    private String fullName;
    private String username;
    private String password;
    private String gender;
    private String email;
    private String dob;
    private String phone;
    private String profileImage; 
    private String role;
    
    // Default constructor
    public ProfileModel() {}

    public ProfileModel(String fullName, String username, String password, String gender,
                        String email, String dob, String phone, String profileImage, String role) {
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.dob = dob;
        this.phone = phone;
        this.profileImage = profileImage;
        this.role = role;
    }

    // Getters and Setters
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getDob() {
        return dob;
    }
    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProfile_Image() {
        return profileImage;
    }
    public void setProfile_Image(String profileImage) {
        this.profileImage = profileImage;
    }

        public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
}
