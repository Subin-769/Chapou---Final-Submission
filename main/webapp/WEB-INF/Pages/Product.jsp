<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.chapou.model.ProductModel" %>
<% List<ProductModel> products = (List<ProductModel>) request.getAttribute("products"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
</head>
<body>
    <%@ include file="Header.jsp" %>

    <div class="products-container">
        <h2 class="product-title">Printers (<%= products != null ? products.size() : 0 %> Results)</h2>
        <hr class="underline" />

        <div class="product-grid">
            <% if (products != null && !products.isEmpty()) {
                for (ProductModel product : products) { %>
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${pageContext.request.contextPath}/Resources/Products/<%= product.getProduct_Image() %>"
                                alt="<%= product.getName() %>" />
                            <div class="color-dot"></div>
                        </div>
                        <h3><%= product.getName() %></h3>
                        <p class="description"><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>
                        <div class="product-details">
                            <div class="pill-tag quantity-tag">
                                <span>Quantity: <%= product.getQuantity() %></span>
                            </div>
                            <div class="pill-tag price-tag">
                                <span>Price: Rs. <%= product.getPrice() %></span>
                            </div>
                        </div>
                        <div class="button-group">
                            <a href="${pageContext.request.contextPath}/product-detail?id=<%= product.getProductId() %>" class="shop-btn">View More</a>
                        </div>
                    </div>
                <% }
            } else { %>
                <p>No products found.</p>
            <% } %>
        </div>
    </div>

    <%@ include file="Footer.jsp" %>
</body>
</html>