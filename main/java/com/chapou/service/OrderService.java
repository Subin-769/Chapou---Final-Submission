package com.chapou.service;

import com.chapou.config.DbConfig;
import com.chapou.model.OrderModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    // Insert a new order
    public boolean insertOrder(int customerId, String username, int productId, String productName, int quantity, double totalPrice) throws ClassNotFoundException {
        String sql = "INSERT INTO orders (customer_id, username, product_id, product_name, quantity, order_date, status, total_price) " +
                     "VALUES (?, ?, ?, ?, ?, NOW(), 'Pending', ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            stmt.setString(2, username);
            stmt.setInt(3, productId);
            stmt.setString(4, productName);
            stmt.setInt(5, quantity);
            stmt.setDouble(6, totalPrice);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update the order status
    public boolean updateOrderStatus(int orderId, String newStatus) throws ClassNotFoundException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all orders without status filtering
    public List<OrderModel> getAllOrders() {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                orders.add(buildOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // Get orders filtered by status
    public List<OrderModel> getOrdersByStatus(String status) {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE status = ? ORDER BY order_date DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(buildOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    
    public List<OrderModel> searchOrders(String keyword) {
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE CAST(order_id AS CHAR) LIKE ? OR username LIKE ? OR product_name LIKE ? ORDER BY order_date DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String like = "%" + keyword + "%";
            stmt.setString(1, like);
            stmt.setString(2, like);
            stmt.setString(3, like);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(buildOrder(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // Helper method to create an OrderModel from ResultSet
    private OrderModel buildOrder(ResultSet rs) throws SQLException {
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
        return order;
    }
}
