package com.chapou.controller;

import com.chapou.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/delete-user")
public class DeleteUserController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("id"));
            userService.deleteUser(userId);
            resp.sendRedirect(req.getContextPath() + "/user?deleted=true");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/user?deleted=false");
        }
    }
}
