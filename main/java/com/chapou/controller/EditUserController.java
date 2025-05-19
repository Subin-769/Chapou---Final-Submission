package com.chapou.controller;

import com.chapou.model.CustomerModel;
import com.chapou.service.UserService;
import com.chapou.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/edit-user")
public class EditUserController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            String fullName = req.getParameter("fullName");
            String username = req.getParameter("username");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");

            // Perform validation
            if (!ValidationUtil.isValidFullName(fullName) ||
                !ValidationUtil.isValidUsername(username) ||
                !ValidationUtil.isValidEmail(email) ||
                !ValidationUtil.isValidPhone(phone) ||
                !ValidationUtil.isValidGender(gender)) {
                req.setAttribute("error", "Invalid input detected. Please correct and try again.");
                resp.sendRedirect(req.getContextPath() + "/user?editId=" + userId + "&error=true");
                return;
            }

            // If all valid, update user
            CustomerModel updatedUser = new CustomerModel();
            updatedUser.setUser_Id(userId);
            updatedUser.setFull_Name(fullName);
            updatedUser.setUsername(username);
            updatedUser.setEmail(email);
            updatedUser.setPhone_Number(phone);
            updatedUser.setGender(gender);

            userService.updateUser(updatedUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/user");
    }
}
