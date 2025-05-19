<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.chapou.model.ProductModel" %>
<% ProductModel product = (ProductModel) request.getAttribute("product"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductDetail.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <%@ include file="Header.jsp" %>

    <div class="product-detail-container">
        <div class="product-detail-section">
            <!-- Product Image Section -->
            <div class="product-image-section">
                <img src="${pageContext.request.contextPath}/Resources/Products/<%= product.getProduct_Image() %>"
                     alt="<%= product.getName() %>" class="product-main-image">
                <div class="color-dot"></div>
            </div>

            <!-- Product Info Section -->
            <div class="product-info-section">
                <h1 class="product-title"><%= product.getName() %></h1>

                <div class="rating-section">
                    <div class="stars">
                        <% for (int i = 0; i < 5; i++) { %>
                            <i class="fas fa-star"></i>
                        <% } %>
                    </div>
                    <span class="review-count">(3-Reviews)</span>
                </div>

                <div class="price-section">
                    <h2 class="price">Rs. <%= String.format("%,.0f", product.getPrice()) %></h2>
                </div>

                <div class="availability-section">
                    <div class="stock-status">
                        <% if (product.getQuantity() > 0) { %>
                            <span class="in-stock" id="stock-status-text">In Stock</span>
                        <% } else { %>
                            <span class="out-of-stock" id="stock-status-text">Out of Stock</span>
                        <% } %>
                    </div>
                    <div class="quantity-available">
                        <span>Quantity Available: <span id="available-quantity"><%= product.getQuantity() %></span></span>
                    </div>
                </div>

                <hr class="divider">

                <div class="description-section">
                    <h3>Description</h3>
                    <p><%= product.getDescription() %></p>
                </div>

                <div class="purchase-section">
                    <div class="quantity-selector">
                        <label for="quantity">Quantity:</label>
                        <div class="quantity-controls">
                            <button class="quantity-btn minus-btn" onclick="decrementQuantity()" <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="text" id="quantity" value="1" class="quantity-input" readonly>
                            <button class="quantity-btn plus-btn" onclick="incrementQuantity()" <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                                <i class="fas fa-plus"></i>
                            </button>
                        </div>
                    </div>

                    <button id="buy-now-btn" class="shop-now-btn <%= product.getQuantity() > 0 ? "in-stock-animation" : "" %>" 
                            onclick="addToCart(<%= product.getProductId() %>)" 
                            <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                        <i class="fas fa-shopping-cart"></i> Buy Now
                    </button>
                </div>

                <div id="success-message" class="success-message"></div>
            </div>
        </div>

        <div class="related-products-section">
            <h2 class="related-title">Related Printers</h2>
            <div class="related-products-grid">
                <% for (int i = 0; i < 3; i++) { %>
                    <div class="related-product-card">
                        <div class="related-product-image">
                            <img src="${pageContext.request.contextPath}/Resources/Products/<%= product.getProduct_Image() %>" alt="<%= product.getName() %>">
                            <div class="color-dot"></div>
                        </div>
                        <div class="related-product-info">
                            <h3>All-In-One Printers</h3>
                            <p>The perfect choice: multiple functions in a single device.</p>
                            <div class="related-product-details">
                                <span class="related-quantity">Quantity: 2</span>
                                <span class="related-price">Price: Rs. 9999</span>
                            </div>
                            <div class="related-product-buttons">
                                <button class="view-more-btn" onclick="location.href='${pageContext.request.contextPath}/product-detail?id=<%= product.getProductId() %>'">View More</button>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <%@ include file="Footer.jsp" %>

    <script>
        let availableStock = <%= product.getQuantity() %>;
        let productId = <%= product.getProductId() %>;

        function incrementQuantity() {
            const input = document.getElementById('quantity');
            let val = parseInt(input.value);
            if (val < availableStock) input.value = val + 1;
        }

        function decrementQuantity() {
            const input = document.getElementById('quantity');
            let val = parseInt(input.value);
            if (val > 1) input.value = val - 1;
        }

        function addToCart(productId) {
            const quantity = parseInt(document.getElementById('quantity').value);
            const messageBox = document.getElementById('success-message');
            const buyNowBtn = document.getElementById('buy-now-btn');

            buyNowBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            buyNowBtn.disabled = true;

            fetch('${pageContext.request.contextPath}/product-detail', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'id=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity)
            })
            .then(async response => {
                const data = await response.text();

                if (response.status === 401) {
                    window.location.href = '${pageContext.request.contextPath}/Login';
                    return;
                }

                if (response.ok && data.includes('successfully')) {
                    availableStock -= quantity;
                    document.getElementById('available-quantity').innerText = availableStock;
                    document.getElementById('quantity').value = 1;
                    updateStockStatus();
                    messageBox.className = 'success-message show';
                    messageBox.innerHTML = '<i class="fas fa-check-circle"></i> Product Purchased Successfully. It will be delivered soon!';
                } else {
                    messageBox.className = 'error-message show';
                    messageBox.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + (data || 'Failed to process request.');
                }

                buyNowBtn.innerHTML = '<i class="fas fa-shopping-cart"></i> Buy Now';
                buyNowBtn.disabled = availableStock <= 0;

                setTimeout(() => {
                    messageBox.classList.remove('show');
                }, 3000);
            })
            .catch(err => {
                messageBox.className = 'error-message show';
                messageBox.innerHTML = '<i class="fas fa-exclamation-circle"></i> An error occurred. Please try again.';
                buyNowBtn.innerHTML = '<i class="fas fa-shopping-cart"></i> Buy Now';
                buyNowBtn.disabled = availableStock <= 0;
                setTimeout(() => {
                    messageBox.classList.remove('show');
                }, 3000);
            });
        }

        function updateStockStatus() {
            const stockText = document.getElementById('stock-status-text');
            const btns = document.querySelectorAll('.quantity-btn');
            const buyNowBtn = document.getElementById('buy-now-btn');

            if (availableStock <= 0) {
                stockText.innerText = "Out of Stock";
                stockText.className = "out-of-stock";
                btns.forEach(btn => btn.disabled = true);
                buyNowBtn.disabled = true;
                buyNowBtn.classList.remove('in-stock-animation');
            } else {
                stockText.innerText = "In Stock";
                stockText.className = "in-stock";
                btns.forEach(btn => btn.disabled = false);
                buyNowBtn.disabled = false;
                buyNowBtn.classList.add('in-stock-animation');
            }
        }

        window.onload = updateStockStatus;
    </script>
</body>
</html>
