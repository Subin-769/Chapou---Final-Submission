package com.chapou.controller;

import com.chapou.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/editorder")
public class EditOrderController extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");

            boolean updated = orderService.updateOrderStatus(orderId, newStatus);

            if (updated) {
                // Redirect back to order page after success
                response.sendRedirect(request.getContextPath() + "/order");
            } else {

                response.sendRedirect(request.getContextPath() + "/order?error=updateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/order?error=exception");
        }
    }
}
