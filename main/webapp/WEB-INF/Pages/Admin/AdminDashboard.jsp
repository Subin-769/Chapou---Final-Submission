<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.chapou.model.OrderModel" %>
<%@ page import="java.util.Map" %>

<%
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    int totalProducts = (int) stats.get("totalProducts");
    int totalUsers = (int) stats.get("totalUsers");
    int totalOrders = (int) stats.get("totalOrders");
    double totalRevenue = (double) stats.get("totalRevenue");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Chapou Printers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/AdminDashboard.css?v=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">
        <div class="logo-icon"><i class="fas fa-print"></i></div>
        <h1>Chapou</h1>
    </div>
    <div class="menu">
        <div class="item active">
            <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
        </div>
        <div class="item">
            <a href="${pageContext.request.contextPath}/user"><i class="fas fa-users"></i> Users</a>
        </div>
        <div class="item">
            <a href="${pageContext.request.contextPath}/productmanagement"><i class="fas fa-box"></i> Products</a>
        </div>
        <div class="item">
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
        <h2>Dashboard</h2>
        <div class="right">
<form action="${pageContext.request.contextPath}/admin" method="get" class="search-form">
    <div class="search-bar-container">
        <i class="fas fa-search"></i>
        <input type="text" name="q" placeholder="Search users, products, orders..." value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">
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

    <!-- Stat Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon products"><i class="fas fa-box"></i></div>
            <div class="stat-info">
                <h3>Total Products</h3>
<p class="value"><%= ((Map<String, Object>) request.getAttribute("stats")).get("totalProducts") %></p>
                <p class="subtitle">In Stock / Selling</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon users"><i class="fas fa-users"></i></div>
            <div class="stat-info">
                <h3>Total Users</h3>
<p class="value"><%= ((Map<String, Object>) request.getAttribute("stats")).get("totalUsers") %> </p>          
 <p class="subtitle"><span class="positive">+12%</span> growth</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon orders"><i class="fas fa-shopping-cart"></i></div>
            <div class="stat-info">
                <h3>Total Orders</h3>
<p class="value"><%= ((Map<String, Object>) request.getAttribute("stats")).get("totalOrders") %></p>
                <p class="subtitle"><span class="positive">+18</span> new orders</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon revenue"><i class="fas fa-rupee-sign"></i></div>
            <div class="stat-info">
                <h3>Total Revenue</h3>
<p class="value">Rs. <%= String.format("%,.2f", ((Map<String, Object>) request.getAttribute("stats")).get("totalRevenue")) %></p>
<p class="subtitle">Profit: <span class="positive">Rs. <%= String.format("%,.2f", ((Map<String, Object>) request.getAttribute("stats")).get("profit")) %></span></p>            </div>
        </div>
    </div>

<!-- Overview + Insights Section -->
<div class="overview-insights">
    <!-- Line Chart -->
    <div class="overview-chart">
        <div class="section-header">
            <h3>Platform Activity Overview</h3>
        </div>
        <canvas id="overviewChart"></canvas>
    </div>

 <!-- Platform Insights Card -->
<div class="platform-insights-card">
    <div class="insights-header">
        <h3>Platform Insights</h3>
    </div>
    <div class="insights-content">
        <div class="insight-item">
            <div class="insight-icon top-product"><i class="fas fa-crown"></i></div>
            <div class="insight-text">
                <h4>Top Product</h4>
                <p><%= request.getAttribute("topProduct") %></p>
            </div>
        </div>
        <div class="insight-item">
            <div class="insight-icon active-user"><i class="fas fa-user-check"></i></div>
            <div class="insight-text">
                <h4>Most Active User</h4>
                <p><%= request.getAttribute("topUser") %></p>
            </div>
        </div>
        <div class="insight-item">
            <div class="insight-icon last-order"><i class="fas fa-clock"></i></div>
            <div class="insight-text">
                <h4>Last Order</h4>
                <p><%= request.getAttribute("lastOrder") %></p>
            </div>
        </div>
    </div>
</div>



<div class="orders-section">
    <div class="section-header">
        <h3><i class="fas fa-shopping-cart"></i> Recent Orders</h3>
        <a href="${pageContext.request.contextPath}/order" class="view-all">
            View All <i class="fas fa-arrow-right"></i>
        </a>
    </div>
    <div class="orders-table">
        <table>
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Username</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Total</th>
                <th>Date</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
                if (orders != null && !orders.isEmpty()) {
                    for (int i = 0; i < Math.min(5, orders.size()); i++) {
                        OrderModel order = orders.get(i);
            %>
            <tr>
                <td>#<%= order.getOrderId() %></td>
                <td><%= order.getUsername() %></td>
                <td><%= order.getProductName() %></td>
                <td><%= order.getQuantity() %></td>
                <td>Rs. <%= order.getTotalPrice() %></td>
                <td><%= order.getOrderDate() %></td>
                <td>
                    <%
                        String status = order.getStatus();
                        String statusClass = "status ";
                        if ("Pending".equalsIgnoreCase(status)) {
                            statusClass += "pending";
                        } else if ("Completed".equalsIgnoreCase(status)) {
                            statusClass += "completed";
                        } else if ("Cancelled".equalsIgnoreCase(status)) {
                            statusClass += "cancelled";
                        } else {
                            statusClass += "other";
                        }
                    %>
                    <span class="<%= statusClass %>"><%= status %></span>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="8" class="no-data">No recent orders found.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const profile = document.querySelector(".profile");
        const dropdown = document.querySelector(".dropdown-content");

        profile.addEventListener("click", () => {
            dropdown.classList.toggle("show");
        });

        window.addEventListener("click", function (e) {
            if (!e.target.closest('.profile-dropdown')) {
                dropdown.classList.remove("show");
            }
        });
    });


    const ctx = document.getElementById('overviewChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
            datasets: [
                {
                    label: 'Products',
                    data: [10, 20, 30, 40, 55],
                    borderColor: '#4361ee',
                    backgroundColor: 'rgba(67,97,238,0.1)',
                    fill: true,
                    tension: 0.3
                },
                {
                    label: 'Users',
                    data: [5, 15, 25, 32, 48],
                    borderColor: '#00b4d8',
                    backgroundColor: 'rgba(0,180,216,0.1)',
                    fill: true,
                    tension: 0.3
                },
                {
                    label: 'Orders',
                    data: [8, 14, 22, 30, 39],
                    borderColor: '#f72585',
                    backgroundColor: 'rgba(247,37,133,0.1)',
                    fill: true,
                    tension: 0.3
                },
                {
                    label: 'Revenue',
                    data: [5000, 10000, 15000, 20000, 30000],
                    borderColor: '#4caf50',
                    backgroundColor: 'rgba(76,175,80,0.1)',
                    fill: true,
                    tension: 0.3
                }
            ]
        },
        options: {
            responsive: true,
            plugins: { legend: { position: 'bottom' } },
            scales: {
                y: { beginAtZero: true, ticks: { precision: 0 } },
                x: { grid: { display: false } }
            }
        }
    });
</script>


</body>
</html>
