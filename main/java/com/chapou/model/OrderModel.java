package com.chapou.model;

import java.sql.Timestamp;

public class OrderModel {
    private int orderId;
    private int customerId;
    private String username;
    private int productId;
    private String productName;
    private int quantity;
    private Timestamp orderDate;
    private String status;
    private double totalPrice;

    public OrderModel() {}

    public OrderModel(int orderId, int customerId, String username, int productId, String productName, int quantity,
                      Timestamp orderDate, String status, double totalPrice) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.username = username;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.orderDate = orderDate;
        this.status = status;
        this.totalPrice = totalPrice;
    }

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
