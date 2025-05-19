<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="com.chapou.model.CustomerModel" %>
<%
    CustomerModel formData = (CustomerModel) request.getAttribute("formData");
    Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Registration.css?v=1.2.2">
    <style>
        .error-msg {
            color: red;
            font-size: 13px;
            margin-top: 4px;
            text-align: left;
        }

        .input-error {
            border: 1px solid red !important;
        }
    </style>
</head>
<body>
    <div class="registration-form">
        <h2>Create Your Account</h2>

        <form action="${pageContext.request.contextPath}/Registration" method="post" enctype="multipart/form-data">
            <div class="form-grid">

                <!-- Full Name -->
                <div class="input-field">
                    <label for="Full_Name">Full Name</label>
                    <input type="text" id="Full_Name" name="Full_Name"
                           class="<%= (errors != null && errors.get("Full_Name") != null) ? "input-error" : "" %>"
                           value="<%= formData != null && formData.getFull_Name() != null ? formData.getFull_Name() : "" %>">
                    <% if (errors != null && errors.get("Full_Name") != null) { %>
                        <div class="error-msg"><%= errors.get("Full_Name") %></div>
                    <% } %>
                </div>

                <!-- Username -->
                <div class="input-field">
                    <label for="Username">Username</label>
                    <input type="text" id="Username" name="Username"
                           class="<%= (errors != null && errors.get("Username") != null) ? "input-error" : "" %>"
                           value="<%= formData != null && formData.getUsername() != null ? formData.getUsername() : "" %>">
                    <% if (errors != null && errors.get("Username") != null) { %>
                        <div class="error-msg"><%= errors.get("Username") %></div>
                    <% } %>
                </div>

                <!-- Password -->
                <div class="input-field full-width">
                    <label for="Password">Password</label>
                    <input type="password" id="Password" name="Password"
                           class="<%= (errors != null && errors.get("Password") != null) ? "input-error" : "" %>">
                    <% if (errors != null && errors.get("Password") != null) { %>
                        <div class="error-msg"><%= errors.get("Password") %></div>
                    <% } %>
                </div>

                <!-- DOB -->
                <div class="input-field">
                    <label for="DOB">Birthday</label>
                    <input type="date" id="DOB" name="DOB"
                           class="<%= (errors != null && errors.get("DOB") != null) ? "input-error" : "" %>"
                           value="<%= formData != null && formData.getDOB() != null ? formData.getDOB().toString() : "" %>">
                    <% if (errors != null && errors.get("DOB") != null) { %>
                        <div class="error-msg"><%= errors.get("DOB") %></div>
                    <% } %>
                </div>

                <!-- Gender -->
                <div class="input-field">
                    <label for="Gender">Gender</label>
                    <select id="Gender" name="Gender"
                            class="<%= (errors != null && errors.get("Gender") != null) ? "input-error" : "" %>">
                        <option value="" disabled <%= formData == null || formData.getGender() == null ? "selected" : "" %>>Choose your gender:</option>
                        <option value="Male" <%= "Male".equals(formData != null ? formData.getGender() : "") ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(formData != null ? formData.getGender() : "") ? "selected" : "" %>>Female</option>
                        <option value="Unknown" <%= "Unknown".equals(formData != null ? formData.getGender() : "") ? "selected" : "" %>>Prefer not to say</option>
                    </select>
                    <% if (errors != null && errors.get("Gender") != null) { %>
                        <div class="error-msg"><%= errors.get("Gender") %></div>
                    <% } %>
                </div>

                <!-- Email -->
                <div class="input-field">
                    <label for="Email">Email</label>
                    <input type="email" id="Email" name="Email"
                           class="<%= (errors != null && errors.get("Email") != null) ? "input-error" : "" %>"
                           value="<%= formData != null && formData.getEmail() != null ? formData.getEmail() : "" %>">
                    <% if (errors != null && errors.get("Email") != null) { %>
                        <div class="error-msg"><%= errors.get("Email") %></div>
                    <% } %>
                </div>

                <!-- Phone -->
                <div class="input-field">
                    <label for="Phone_Number">Phone Number</label>
                    <input type="tel" id="Phone_Number" name="Phone_Number"
                           class="<%= (errors != null && errors.get("Phone_Number") != null) ? "input-error" : "" %>"
                           value="<%= formData != null && formData.getPhone_Number() != null ? formData.getPhone_Number() : "" %>">
                    <% if (errors != null && errors.get("Phone_Number") != null) { %>
                        <div class="error-msg"><%= errors.get("Phone_Number") %></div>
                    <% } %>
                </div>

                <!-- Image -->
                <div class="input-field full-width">
                    <label for="image">Profile Picture:</label>
                    <input type="file" id="image" name="image">
                </div>

                <!-- Terms -->
                <div class="input-field full-width terms">
                    <input type="checkbox" id="terms" name="terms"
                        <%= request.getParameter("terms") != null ? "checked" : "" %>>
                    <label for="terms">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                    <% if (errors != null && errors.get("terms") != null) { %>
                        <div class="error-msg"><%= errors.get("terms") %></div>
                    <% } %>
                </div>

                <!-- Buttons -->
                <div class="input-field full-width">
                    <button type="submit" class="register-button">Create Account</button>
                </div>

                <!-- Login Redirect -->
                <div class="login-link full-width">
                    <a href="${pageContext.request.contextPath}/Login">Login if you already have an account</a>
                </div>

            </div>
        </form>
    </div>
</body>
</html>
