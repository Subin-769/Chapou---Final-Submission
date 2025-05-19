package com.chapou.controller;

import com.chapou.model.OrderModel;
import com.chapou.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(urlPatterns = {"/order"})
public class OrderManagementController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(OrderManagementController.class.getName());
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String statusFilter = request.getParameter("status");
            String query = request.getParameter("q");

            List<OrderModel> orders;
            if (query != null && !query.trim().isEmpty()) {
                orders = orderService.searchOrders(query.trim());
            } else if (statusFilter != null && !statusFilter.isEmpty()) {
                orders = orderService.getOrdersByStatus(statusFilter);
            } else {
                orders = orderService.getAllOrders();
            }

            int totalOrders = orders.size();
            int pendingOrders = 0;
            int completedOrders = 0;
            int cancelledOrders = 0;

            for (OrderModel order : orders) {
                switch (order.getStatus()) {
                    case "Pending" -> pendingOrders++;
                    case "Completed" -> completedOrders++;
                    case "Cancelled" -> cancelledOrders++;
                }
            }

            request.setAttribute("orders", orders);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("cancelledOrders", cancelledOrders);
            request.setAttribute("currentStatus", statusFilter);
            request.setAttribute("searchQuery", query);

            request.getRequestDispatcher("/WEB-INF/Pages/Admin/OrderManagement.jsp").forward(request, response);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching orders", e);
            response.sendRedirect(request.getContextPath() + "/admin?error=loadFailed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");

            boolean updated = orderService.updateOrderStatus(orderId, newStatus);

            if (updated) {
                response.sendRedirect(request.getContextPath() + "/order");
            } else {
                response.sendRedirect(request.getContextPath() + "/order?error=updateFailed");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating order status", e);
            response.sendRedirect(request.getContextPath() + "/order?error=exception");
        }
    }
}
