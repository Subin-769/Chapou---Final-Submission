<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.chapou.model.OrderModel" %>
<%
    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
    int totalOrders = orders != null ? orders.size() : 0;
    int pendingOrders = 0;
    int completedOrders = 0;
    
    if (orders != null) {
        for (OrderModel order : orders) {
            if ("Pending".equals(order.getStatus())) {
                pendingOrders++;
            } else if ("Completed".equals(order.getStatus())) {
                completedOrders++;
            }
        }
    }
    
    int cancelledOrders = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | Chapou Printers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/OrderManagement.css?v=1.1">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">
        <div class="logo-icon"><i class="fas fa-print"></i></div>
        <h1>Chapou</h1>
    </div>
    <div class="menu">
        <div class="item">
            <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
        </div>
        <div class="item">
            <a href="${pageContext.request.contextPath}/user"><i class="fas fa-users"></i> Users</a>
        </div>
        <div class="item">
            <a href="${pageContext.request.contextPath}/productmanagement"><i class="fas fa-box"></i> Products</a>
        </div>
        <div class="item active">
            <a href="${pageContext.request.contextPath}/order"><i class="fas fa-shopping-cart"></i> Orders</a>
        </div>
    </div>
    <div class="logout">
        <a href="${pageContext.request.contextPath}/logout" class="btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="main">
    <div class="header">
        <h2>Order Management</h2>
        <div class="right">
           <form action="${pageContext.request.contextPath}/order" method="get" class="search-form">
    <div class="search-bar-container">
        <i class="fas fa-search"></i>
        <input type="text" name="q" placeholder="Search by ID, user or product" value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
    </div>
</form>

            <div class="profile-dropdown">
                <div class="profile"><span>SD</span></div>
                <div class="dropdown-content">
                    <a href="#"><i class="fas fa-user"></i> Profile</a>
                    <a href="#"><i class="fas fa-cog"></i> Settings</a>
                    <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="header-section">
        <h2 class="header-title">Order Dashboard</h2>
        <p class="header-subtitle">Monitor, manage and fulfill customer orders</p>
    </div>

    <!-- Summary Cards -->
    <div class="summary-cards">
        <div class="summary-card">
            <div class="summary-icon total">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <h3 class="summary-title">Total Orders</h3>
            <p class="summary-value"><%= totalOrders %></p>
        </div>
        
        <div class="summary-card">
            <div class="summary-icon pending">
                <i class="fas fa-clock"></i>
            </div>
            <h3 class="summary-title">Pending</h3>
            <p class="summary-value"><%= pendingOrders %></p>
        </div>
        
        <div class="summary-card">
            <div class="summary-icon completed">
                <i class="fas fa-check-circle"></i>
            </div>
            <h3 class="summary-title">Completed</h3>
            <p class="summary-value"><%= completedOrders %></p>
        </div>
        
        <div class="summary-card">
            <div class="summary-icon cancelled">
                <i class="fas fa-times-circle"></i>
            </div>
            <h3 class="summary-title">Cancelled</h3>
<p class="summary-value"><%= request.getAttribute("cancelledOrders") %></p>
        </div>
    </div>

    <!-- Order Filters -->
  <div class="order-actions">
    <a href="${pageContext.request.contextPath}/order" class="filter-btn <%= (request.getParameter("status") == null) ? "active" : "" %>">
        <i class="fas fa-list"></i> All Orders
    </a>
    <a href="${pageContext.request.contextPath}/order?status=Pending" class="filter-btn <%= "Pending".equals(request.getParameter("status")) ? "active" : "" %>">
        <i class="fas fa-clock"></i> Pending
    </a>
    <a href="${pageContext.request.contextPath}/order?status=Completed" class="filter-btn <%= "Completed".equals(request.getParameter("status")) ? "active" : "" %>">
        <i class="fas fa-check-circle"></i> Completed
    </a>
    <a href="${pageContext.request.contextPath}/order?status=Cancelled" class="filter-btn <%= "Cancelled".equals(request.getParameter("status")) ? "active" : "" %>">
        <i class="fas fa-times-circle"></i> Cancelled
    </a>
</div>


    <!-- Orders Table Card -->
    <div class="order-card">
        <div class="card-header">
            <h3 class="card-title">Order List</h3>

        </div>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                  <% 
    String editId = request.getParameter("editId"); 
%>

<% if (orders != null && !orders.isEmpty()) {
    for (OrderModel order : orders) {
        boolean isEditing = (editId != null && editId.equals(String.valueOf(order.getOrderId())));
%>
<tr>
    <td>#<%= order.getOrderId() %></td>
    <td><%= order.getUsername() %></td>
    <td><%= order.getProductName() %></td>
    <td><%= order.getQuantity() %></td>
    <td>Rs. <%= order.getTotalPrice() %></td>
    
    <td>
        <% if (isEditing) { %>
        <form action="${pageContext.request.contextPath}/editorder" method="post">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <select name="status" class="status-dropdown <%= order.getStatus().toLowerCase() %>">
                <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Completed</option>
                <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
            </select>
            <button type="submit" class="btn-icon btn-save"><i class="fas fa-check"></i></button>
            <a href="${pageContext.request.contextPath}/order" class="btn-icon btn-cancel"><i class="fas fa-times"></i></a>
        </form>
        <% } else { %>
            <span class="badge <%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span>
        <% } %>
    </td>

    <td><%= order.getOrderDate() %></td>
<td class="action-cell">
    <a href="${pageContext.request.contextPath}/order?editId=<%= order.getOrderId() %>" class="btn-icon btn-edit"><i class="fas fa-pen"></i></a>
</td>

</tr>
<% }} else { %>
<tr>
    <td colspan="8">
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <h3 class="empty-title">No Orders Found</h3>
            <p class="empty-subtitle">There are no orders to display at this time.</p>
        </div>
    </td>
</tr>
<% } %>

                </tbody>
            </table>
        </div>
        
        <% if (orders != null && !orders.isEmpty() && orders.size() > 10) { %>
            <div class="pagination">
                <div class="page-item">
                    <a href="#" class="page-link">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </div>
                <div class="page-item">
                    <a href="#" class="page-link active">1</a>
                </div>
                <div class="page-item">
                    <a href="#" class="page-link">2</a>
                </div>
                <div class="page-item">
                    <a href="#" class="page-link">3</a>
                </div>
                <div class="page-item">
                    <a href="#" class="page-link">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Profile dropdown
        const profile = document.querySelector(".profile");
        const dropdown = document.querySelector(".dropdown-content");

        profile.addEventListener("click", () => {
            dropdown.classList.toggle("show");
        });

        window.addEventListener("click", function(e) {
            if (!e.target.closest('.profile-dropdown')) {
                dropdown.classList.remove("show");
            }
        });

        // Filter buttons functionality
        const filterButtons = document.querySelectorAll('.filter-btn');
        
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                filterButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');
                // Add actual filtering logic here (e.g., AJAX call or form submission)
            });
        });
        
        function toggleStatusEdit(orderId) {
            const form = document.getElementById("statusForm-" + orderId);
            if (form.style.display === "none") {
                form.style.display = "inline";
            } else {
                form.style.display = "none";
            }
        }

    });
</script>

</body>
</html>