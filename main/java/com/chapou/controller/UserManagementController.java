package com.chapou.controller;

import com.chapou.model.CustomerModel;
import com.chapou.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("q");

        List<CustomerModel> users;
        if (query != null && !query.trim().isEmpty()) {
            users = userService.searchUsers(query.trim());
        } else {
            users = userService.getAllUsers();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/UserManagement.jsp").forward(request, response);
    }
}