package com.chapou.controller;

import com.chapou.model.OrderModel;
import com.chapou.service.AdminDashboardService;
import com.chapou.model.ProfileModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = { "/admin" })
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AdminDashboardService dashboardService = new AdminDashboardService();

    public AdminDashboardController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        var session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        var user = (ProfileModel) session.getAttribute("currentUser");

        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            Map<String, Object> stats = dashboardService.getDashboardStats();
            request.setAttribute("stats", stats);

            String searchQuery = request.getParameter("q"); 
            List<OrderModel> orders;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                orders = dashboardService.searchOrders(searchQuery);
            } else {
                orders = dashboardService.getRecentOrders(5);
            }
            request.setAttribute("orders", orders);

            request.setAttribute("topProduct", dashboardService.getTopSellingProduct());
            request.setAttribute("topUser", dashboardService.getMostActiveUser());
            request.setAttribute("lastOrder", dashboardService.getLastOrderDate());

            request.getRequestDispatcher("/WEB-INF/Pages/Admin/AdminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Login");
        }
    }
}
