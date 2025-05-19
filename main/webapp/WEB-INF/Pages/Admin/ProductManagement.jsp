<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.chapou.model.ProductModel" %>
<%
    List<ProductModel> products = (List<ProductModel>) request.getAttribute("products");
    String editIdParam = request.getParameter("editId");
    int editId = -1;
    try { editId = Integer.parseInt(editIdParam); } catch (Exception e) {}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management | Chapou Printers</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/ProductManagement.css?v=3.0">
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
            <div class="item active">
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
            <h2>Product Management</h2>
            <div class="right">
                <form action="${pageContext.request.contextPath}/productmanagement" method="get" class="search-form">
                    <div class="search-bar-container">
                        <i class="fas fa-search"></i>
                        <input type="text" name="q" placeholder="Search products..." value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
                        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                    </div>
                </form>

                <button onclick="openAddForm()" class="addbtn"><i class="fas fa-plus"></i> Add Product</button>
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

        <!-- Products Table -->
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-box-open"></i> All Products</h3>
            </div>
            <div class="card-body">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Qty</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (products != null && !products.isEmpty()) {
                        for (ProductModel product : products) {
                            boolean isEditing = (product.getProductId() == editId);
                    %>
                        <tr>
                            <% if (isEditing) { %>
                                <form action="${pageContext.request.contextPath}/editproduct" method="post">
                                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                    <td><%= product.getProductId() %></td>
                                    <td><img src="${pageContext.request.contextPath}/Resources/Products/<%= product.getProduct_Image() %>" alt="<%= product.getName() %>"></td>
                                    <td><input type="text" name="name" value="<%= product.getName() %>" required></td>
                                    <td><input type="text" name="description" value="<%= product.getDescription() %>" required></td>
                                    <td><input type="number" name="quantity" value="<%= product.getQuantity() %>" min="0" required></td>
                                    <td><input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" required></td>
                                    <td class="action-cell">
                                        <button type="submit" class="btn-icon btn-edit"><i class="fas fa-save"></i></button>
                                        <a href="${pageContext.request.contextPath}/productmanagement" class="btn-icon btn-delete"><i class="fas fa-times"></i></a>
                                    </td>
                                </form>
                            <% } else { %>
                                <td><%= product.getProductId() %></td>
                                <td><img src="${pageContext.request.contextPath}/Resources/Products/<%= product.getProduct_Image() %>" alt="<%= product.getName() %>"></td>
                                <td><%= product.getName() %></td>
                                <td><%= product.getDescription() %></td>
                                <td><%= product.getQuantity() %></td>
                                <td>Rs. <%= product.getPrice() %></td>
                                <td class="action-cell">
                                    <a href="${pageContext.request.contextPath}/productmanagement?editId=<%= product.getProductId() %>" class="btn-icon btn-edit"><i class="fas fa-edit"></i></a>
                                    <form action="${pageContext.request.contextPath}/deleteproduct" method="post" style="display:inline;">
                                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                        <button type="submit" class="btn-icon btn-delete" onclick="return confirm('Are you sure you want to delete this product?');">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            <% } %>
                        </tr>
                    <% } } else { %>
                        <tr>
                            <td colspan="7" class="empty-state">
                                <i class="fas fa-box-open"></i>
                                <p>No products found</p>
                                <button onclick="openAddForm()" class="btn-primary"><i class="fas fa-plus"></i> Add Your First Product</button>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="addProductForm" class="modal-overlay">
        <div class="modal-content">
            <h3><i class="fas fa-plus-circle"></i> Add New Product</h3>
            <form action="${pageContext.request.contextPath}/addproduct" method="post" enctype="multipart/form-data">
                <div class="input-group">
                    <label for="productName"><i class="fas fa-tag"></i> Product Name</label>
                    <input type="text" id="productName" name="name" placeholder="Enter product name" required>
                </div>
                
                <div class="input-group">
                    <label for="productDescription"><i class="fas fa-align-left"></i> Product Description</label>
                    <textarea id="productDescription" name="description" placeholder="Enter detailed product description" required></textarea>
                </div>
                
                <div class="input-group" style="display: flex; gap: 1rem;">
                    <div style="flex: 1;">
                        <label for="productQuantity"><i class="fas fa-layer-group"></i> Quantity</label>
                        <input type="number" id="productQuantity" name="quantity" placeholder="Available stock" min="0" required>
                    </div>
                    <div style="flex: 1;">
                        <label for="productPrice"><i class="fas fa-rupee-sign"></i> Price (Rs.)</label>
                        <input type="number" id="productPrice" name="price" placeholder="Product price" step="0.01" required>
                    </div>
                </div>
                
                <div class="input-group">
                    <label for="image"><i class="fas fa-image"></i> Product Image</label>
                    <input type="file" id="image" name="image" accept="image/*" required>
                </div>

                <div class="modal-buttons">
                    <button type="submit" class="btn-primary"><i class="fas fa-plus"></i> Add Product</button>
                    <button type="button" class="btn-cancel" onclick="closeAddForm()"><i class="fas fa-times"></i> Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- JS -->
    <script>
        document.addEventListener
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

        function openAddForm() {
            document.getElementById("addProductForm").style.display = "flex";
            document.body.style.overflow = "hidden"; // Prevent scrolling when modal is open
        }

        function closeAddForm() {
            document.getElementById("addProductForm").style.display = "none";
            document.body.style.overflow = "auto"; // Re-enable scrolling
        }

        // Close modal if user clicks outside of it
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('addProductForm');
            if (event.target === modal) {
                closeAddForm();
            }
        });

        // Add escape key support to close modal
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeAddForm();
            }
        });
    </script>
</body>
</html>