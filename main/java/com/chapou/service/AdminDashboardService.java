package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.OrderModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class AdminDashboardService {

	public Map<String, Object> getDashboardStats() {
	    Map<String, Object> stats = new HashMap<>();

	    String totalProductsQuery = "SELECT COUNT(*) AS total FROM products";
	    String totalUsersQuery = "SELECT COUNT(*) AS total FROM customer";
	    String totalOrdersQuery = "SELECT COUNT(*) AS total FROM orders";
	    
	    String totalRevenueQuery = "SELECT SUM(total_price) AS revenue FROM orders WHERE status != 'Cancelled'";

	    try (Connection conn = DbConfig.getDbConnection()) {

	        // Total Products
	        try (PreparedStatement stmt = conn.prepareStatement(totalProductsQuery);
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                stats.put("totalProducts", rs.getInt("total"));
	            }
	        }

	        // Total Users
	        try (PreparedStatement stmt = conn.prepareStatement(totalUsersQuery);
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                stats.put("totalUsers", rs.getInt("total"));
	            }
	        }

	        // Total Orders
	        try (PreparedStatement stmt = conn.prepareStatement(totalOrdersQuery);
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                stats.put("totalOrders", rs.getInt("total"));
	            }
	        }

	        // Total Revenue (excluding Cancelled)
	        try (PreparedStatement stmt = conn.prepareStatement(totalRevenueQuery);
	             ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                double revenue = rs.getDouble("revenue");
	                revenue = rs.wasNull() ? 0 : revenue; 
	                stats.put("totalRevenue", revenue);
	                stats.put("profit", revenue * 0.3); // assume 30% margin
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return stats;
	}

    public String getTopSellingProduct() {
        String sql = "SELECT product_name FROM orders GROUP BY product_name ORDER BY SUM(quantity) DESC LIMIT 1";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getString("product_name");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "N/A";
    }

    public String getMostActiveUser() {
        String sql = "SELECT username FROM orders GROUP BY username ORDER BY COUNT(*) DESC LIMIT 1";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getString("username");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "N/A";
    }

    public String getLastOrderDate() {
        String sql = "SELECT order_date FROM orders ORDER BY order_date DESC LIMIT 1";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getTimestamp("order_date").toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "N/A";
    }
    
    public List<OrderModel> searchOrders(String query) {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE username LIKE ? OR product_name LIKE ? OR status LIKE ? ORDER BY order_date DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String likeQuery = "%" + query + "%";
            stmt.setString(1, likeQuery);
            stmt.setString(2, likeQuery);
            stmt.setString(3, likeQuery);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setUsername(rs.getString("username"));
                order.setProductId(rs.getInt("product_id"));
                order.setProductName(rs.getString("product_name"));
                order.setQuantity(rs.getInt("quantity"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setStatus(rs.getString("status"));
                order.setTotalPrice(rs.getDouble("total_price"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }


    public List<OrderModel> getRecentOrders(int limit) {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC LIMIT ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setUsername(rs.getString("username"));
                order.setProductId(rs.getInt("product_id"));
                order.setProductName(rs.getString("product_name"));
                order.setQuantity(rs.getInt("quantity"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setStatus(rs.getString("status"));
                order.setTotalPrice(rs.getDouble("total_price"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}
