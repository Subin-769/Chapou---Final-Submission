package com.chapou.controller;

import com.chapou.model.CustomerModel;
import com.chapou.service.RegisterService;
import com.chapou.util.PasswordUtil;
import com.chapou.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/Registration")
@MultipartConfig
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/Pages/Registration.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Map<String, String> errors = new HashMap<>();

            String fullName = req.getParameter("Full_Name");
            String username = req.getParameter("Username");
            String dobStr = req.getParameter("DOB");
            String gender = req.getParameter("Gender");
            String email = req.getParameter("Email");
            String phone = req.getParameter("Phone_Number");
            String password = req.getParameter("Password");

            LocalDate dob = null;
            if (ValidationUtil.isNotEmpty(dobStr)) {
                try {
                    dob = LocalDate.parse(dobStr);
                } catch (Exception e) {
                    errors.put("DOB", "Invalid date format. Use YYYY-MM-DD.");
                }
            }

            if (!ValidationUtil.isNotEmpty(fullName)) errors.put("Full_Name", "Please enter your full name.");
            if (!ValidationUtil.isNotEmpty(username)) errors.put("Username", "Please enter your username.");
            if (!ValidationUtil.isNotEmpty(dobStr)) errors.put("DOB", "Please enter your date of birth.");
            if (!ValidationUtil.isNotEmpty(gender)) errors.put("Gender", "Please select your gender.");
            if (!ValidationUtil.isNotEmpty(email)) errors.put("Email", "Please enter your email.");
            if (!ValidationUtil.isNotEmpty(phone)) errors.put("Phone_Number", "Please enter your phone number.");
            if (!ValidationUtil.isNotEmpty(password)) errors.put("Password", "Please enter a password.");

            if (!ValidationUtil.isAlphanumericStartingWithLetter(username))
                errors.put("Username", "Username must start with letter.");
            if (!ValidationUtil.isValidGender(gender))
                errors.put("Gender", "Please select a valid gender.");
            if (!ValidationUtil.isValidEmail(email))
                errors.put("Email", "Invalid email address.");
            if (!ValidationUtil.isValidPhone(phone))
                errors.put("Phone_Number", "Number must be 10 digits starting with 98 or 97.");
            if (!ValidationUtil.isValidPassword(password))
                errors.put("Password", "Password must be 8+ characters with uppercase, number & symbol.");
            if (dob != null && !ValidationUtil.isAgeAtLeast16(dob))
                errors.put("DOB", "You must be at least 16 years old.");
            

            if (registerService.isUsernameExists(username)) {
                errors.put("Username", "Username already exists.");
            }

            if (registerService.isEmailExists(email)) {
                errors.put("Email", "Email already exists.");
            }

            if (registerService.isPhoneExists(phone)) {
                errors.put("Phone_Number", "Phone number already exists.");
            }


            if (!errors.isEmpty()) {
                CustomerModel customer = new CustomerModel();
                customer.setFull_Name(fullName);
                customer.setUsername(username);
                customer.setGender(gender);
                customer.setEmail(email);
                customer.setPhone_Number(phone);
                customer.setPassword(password);
                if (dob != null) customer.setDOB(dob);

                req.setAttribute("formData", customer);
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/WEB-INF/Pages/Registration.jsp").forward(req, resp);
                return;
            }

            CustomerModel customer = buildCustomerModel(req);
            customer.setDOB(dob);

            
            Boolean isAdded = registerService.addCustomer(customer);

            if (isAdded == null) {
                req.setAttribute("formData", customer);
                sendError(req, resp, "Server is under maintenance. Try again later.");
            } else if (isAdded) {
                resp.sendRedirect(req.getContextPath() + "/Login?success=1");
            } else {
                req.setAttribute("formData", customer);
                sendError(req, resp, "Registration failed. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(req, resp, "Unexpected error occurred. Try again later.");
        }
    }

    private CustomerModel buildCustomerModel(HttpServletRequest req)
            throws IOException, ServletException {
        CustomerModel customer = new CustomerModel();

        customer.setFull_Name(req.getParameter("Full_Name"));
        customer.setUsername(req.getParameter("Username"));
        customer.setGender(req.getParameter("Gender"));
        customer.setEmail(req.getParameter("Email"));
        customer.setPhone_Number(req.getParameter("Phone_Number"));

        String username = req.getParameter("Username");
        String password = req.getParameter("Password");
        if (username != null && password != null) {
            customer.setPassword(PasswordUtil.encrypt(username, password));
        }

        try {
            Part imagePart = req.getPart("image");
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

            if (!fileName.isEmpty()) {
                String uploadDirPath = getServletContext().getRealPath("/Resources/UserProfile");
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fullPath = uploadDirPath + File.separator + fileName;
                imagePart.write(fullPath);

                customer.setProfileImage("Resources/UserProfile/" + fileName);
            } else {
                customer.setProfileImage(null);
            }
        } catch (Exception e) {
            e.printStackTrace();
            customer.setProfileImage(null);
        }

        return customer;
    }

    private void sendError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/Pages/Registration.jsp").forward(req, resp);
    }

    private void sendSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String path)
            throws ServletException, IOException {
        req.setAttribute("success", message);
        req.getRequestDispatcher(path).forward(req, resp);
    }
}
