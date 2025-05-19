<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.chapou.model.CustomerModel" %>
            <% List<CustomerModel> users = (List<CustomerModel>) request.getAttribute("users");
                    String editIdParam = request.getParameter("editId");
                    int editId = -1;
                    try { editId = Integer.parseInt(editIdParam); } catch (Exception e) {}
                    String deleteSuccess = request.getParameter("deleted");
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <title>User Management | Chapou Printers</title>
                        <link rel="stylesheet"
                            href="${pageContext.request.contextPath}/css/Admin/AdminDashboard.css?v=1.0">
                        <link rel="stylesheet"
                            href="${pageContext.request.contextPath}/css/Admin/UserManagement.css?v=2.0">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
                                    <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i>
                                        Dashboard</a>
                                </div>
                                <div class="item active">
                                    <a href="${pageContext.request.contextPath}/user"><i class="fas fa-users"></i>
                                        Users</a>
                                </div>
                                <div class="item">
                                    <a href="${pageContext.request.contextPath}/productmanagement"><i
                                            class="fas fa-box"></i> Products</a>
                                </div>
                                <div class="item">
                                    <a href="${pageContext.request.contextPath}/order"><i
                                            class="fas fa-shopping-cart"></i> Orders</a>
                                </div>
                            </div>
                            <div class="logout">
                                <a href="${pageContext.request.contextPath}/logout" class="btn"><i
                                        class="fas fa-sign-out-alt"></i> Logout</a>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="main">
                            <div class="header">
                                <h2>Users Management</h2>
                                <div class="right">
                                    <form method="get" action="${pageContext.request.contextPath}/user"
                                        class="search-form">
                                        <div class="search-bar-container">
                                            <i class="fas fa-search"></i>
                                            <input type="text" name="q" placeholder="Search users..."
                                                value="<%= request.getParameter(" q") !=null ? request.getParameter("q")
                                                : "" %>">
                                            <button type="submit" class="search-btn"><i
                                                    class="fas fa-search"></i></button>
                                        </div>
                                    </form>

                                    <div class="profile-dropdown">
                                        <div class="profile"><span>SD</span></div>
                                        <div class="dropdown-content">
                                            <a href="#"><i class="fas fa-user"></i> Profile</a>
                                            <a href="#"><i class="fas fa-cog"></i> Settings</a>
                                            <a href="${pageContext.request.contextPath}/logout"><i
                                                    class="fas fa-sign-out-alt"></i> Logout</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- User Management Content -->
                            <div class="content-wrapper">
                                <% if ("true".equals(deleteSuccess)) { %>
                                    <div class="notification success">
                                        <div class="notification-icon">
                                            <i class="fas fa-check-circle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <h4>Success!</h4>
                                            <p>User has been deleted successfully.</p>
                                        </div>
                                        <button class="notification-close">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <% } %>

                                        <div class="users-management-card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-users"></i>
                                                    <h3>All Users</h3>
                                                    <span class="user-count badge">
                                                        <%= users !=null ? users.size() : 0 %> users
                                                    </span>
                                                </div>
                                             
                                            </div>

                                            <% if (users !=null && !users.isEmpty()) { %>
                                                <div class="users-table-container">
                                                    <table class="users-table">
                                                        <thead>
                                                            <tr>
                                                                <th class="th-id">ID</th>
                                                                <th class="th-profile">Profile</th>
                                                                <th class="th-name">Full Name</th>
                                                                <th class="th-username">Username</th>
                                                                <th class="th-email">Email</th>
                                                                <th class="th-phone">Phone</th>
                                                                <th class="th-gender">Gender</th>
                                                                <th class="th-dob">DOB</th>
                                                                <th class="th-role">Role</th>
                                                                <th class="th-actions">Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (CustomerModel user : users) { boolean
                                                                isEditing=(user.getUser_Id()==editId); String
                                                                profileImage=user.getProfileImage(); if
                                                                (profileImage==null || profileImage.trim().isEmpty()) {
                                                                profileImage="default.png" ; } %>


                                                                <tr class="user-row<%= isEditing ? " editing" : "" %>">
                                                                    <% if (isEditing) { %>
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/edit-user"
                                                                            method="post">
                                                                            <input type="hidden" name="userId"
                                                                                value="<%= user.getUser_Id() %>">
                                                                            <td class="user-id"><span class="id-badge">#
                                                                                    <%= user.getUser_Id() %></span></td>
                                                                            <td class="user-profile">
                                                                                <div class="avatar">
                                                                                    <img src="${pageContext.request.contextPath}/<%= profileImage %>"
                                                                                        alt="Profile">
                                                                            </td>
                                                                            <td class="user-name">
                                                                                <input type="text" name="fullName"
                                                                                    value="<%= user.getFull_Name() %>"
                                                                                    class="form-control" required>
                                                                            </td>
                                                                            <td class="user-username">
                                                                                <input type="text" name="username"
                                                                                    value="<%= user.getUsername() %>"
                                                                                    class="form-control" required>
                                                                            </td>
                                                                            <td class="user-email">
                                                                                <input type="email" name="email"
                                                                                    value="<%= user.getEmail() %>"
                                                                                    class="form-control" required>
                                                                            </td>
                                                                            <td class="user-phone">
                                                                                <input type="text" name="phone"
                                                                                    value="<%= user.getPhone_Number() %>"
                                                                                    class="form-control" required>
                                                                            </td>
                                                                            <td class="user-gender">
                                                                                <select name="gender"
                                                                                    class="form-control" required>
                                                                                    <option value="Male" <%="Male"
                                                                                        .equalsIgnoreCase(user.getGender())
                                                                                        ? "selected" : "" %>>Male
                                                                                    </option>
                                                                                    <option value="Female" <%="Female"
                                                                                        .equalsIgnoreCase(user.getGender())
                                                                                        ? "selected" : "" %>>Female
                                                                                    </option>
                                                                                    <option value="Prefer not to say"
                                                                                        <%="Prefer not to say"
                                                                                        .equalsIgnoreCase(user.getGender())
                                                                                        ? "selected" : "" %>>Prefer not
                                                                                        to say</option>
                                                                                </select>
                                                                            </td>
                                                                            <td class="user-dob">
                                                                                <input type="date" name="dob"
                                                                                    value="<%= user.getDOB() != null ? user.getDOB().toString() : "" %>"
                                                                                    class="form-control" required>
                                                                            </td>
                                                                            <td class="user-role">
                                                                                <span
                                                                                    class="role-badge user">User</span>
                                                                            </td>
                                                                            <td class="user-actions">
                                                                                <div class="action-buttons">
                                                                                    <button type="submit"
                                                                                        class="action-btn save-btn"
                                                                                        title="Save Changes">
                                                                                        <i class="fas fa-save"></i>
                                                                                    </button>
                                                                                    <a href="${pageContext.request.contextPath}/user"
                                                                                        class="action-btn cancel-btn"
                                                                                        title="Cancel">
                                                                                        <i class="fas fa-times"></i>
                                                                                    </a>
                                                                                </div>
                                                                            </td>
                                                                        </form>
                                                                        <% } else { %>
                                                                            <td class="user-id"><span class="id-badge">#
                                                                                    <%= user.getUser_Id() %></span></td>
                                                                            <td class="user-profile">
                                                                                <div class="avatar">
                                                                                    <img src="${pageContext.request.contextPath}/<%= profileImage %>"
                                                                                        alt="<%= user.getFull_Name() %>">
                                                                                </div>
                                                                            </td>
                                                                            <td class="user-name">
                                                                                <div class="user-name-info">
                                                                                    <span class="full-name">
                                                                                        <%= user.getFull_Name() %>
                                                                                    </span>
                                                                                </div>
                                                                            </td>
                                                                            <td class="user-username">
                                                                                <%= user.getUsername() %>
                                                                            </td>
                                                                            <td class="user-email">
                                                                                <div class="tooltip-container">
                                                                                    <%= user.getEmail() %>
                                                                                        <span class="tooltip">
                                                                                            <%= user.getEmail() %>
                                                                                        </span>
                                                                                </div>
                                                                            </td>
                                                                            <td class="user-phone">
                                                                                <div class="tooltip-container">
                                                                                    <%= user.getPhone_Number() %>
                                                                                        <span class="tooltip">
                                                                                            <%= user.getPhone_Number()
                                                                                                %>
                                                                                        </span>
                                                                                </div>
                                                                            </td>
                                                                            <td class="user-gender">
                                                                                <% if
                                                                                    ("Male".equalsIgnoreCase(user.getGender()))
                                                                                    { %>
                                                                                    <div class="gender-icon male"><i
                                                                                            class="fas fa-mars"></i>
                                                                                        Male</div>
                                                                                    <% } else if
                                                                                        ("Female".equalsIgnoreCase(user.getGender()))
                                                                                        { %>
                                                                                        <div class="gender-icon female">
                                                                                            <i class="fas fa-venus"></i>
                                                                                            Female</div>
                                                                                        <% } else { %>
                                                                                            <div
                                                                                                class="gender-icon other">
                                                                                                <i
                                                                                                    class="fas fa-genderless"></i>
                                                                                                Other</div>
                                                                                            <% } %>
                                                                            </td>
                                                                            <td class="user-dob">
                                                                                <%= user.getDOB() !=null ?
                                                                                    user.getDOB().toString() : "N/A" %>
                                                                            </td>
                                                                            <td class="user-role">
                                                                                <span
                                                                                    class="role-badge user">User</span>
                                                                            </td>
                                                                            <td class="user-actions">
                                                                                <div class="action-buttons">
                                                                                    <a href="${pageContext.request.contextPath}/user?editId=<%= user.getUser_Id() %>"
                                                                                        class="action-btn edit-btn"
                                                                                        title="Edit User">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </a>
                                                                                    <form
                                                                                        action="${pageContext.request.contextPath}/delete-user"
                                                                                        method="post"
                                                                                        class="delete-form">
                                                                                        <input type="hidden" name="id"
                                                                                            value="<%= user.getUser_Id() %>">
                                                                                        <button type="submit"
                                                                                            class="action-btn delete-btn"
                                                                                            title="Delete User"
                                                                                            onclick="return confirm('Are you sure you want to delete this user?');">
                                                                                            <i class="fas fa-trash"></i>
                                                                                        </button>
                                                                                    </form>
                                                                                    <button class="action-btn more-btn"
                                                                                        title="More Options">
                                                                                        <i
                                                                                            class="fas fa-ellipsis-v"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </td>
                                                                            <% } %>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="table-footer">
                                                    <div class="showing-entries">
                                                        Showing <strong>
                                                            <%= users.size() %>
                                                        </strong> of <strong>
                                                            <%= users.size() %>
                                                        </strong> entries
                                                    </div>
                                                    <div class="pagination">
                                                        <button class="pagination-btn" disabled>
                                                            <i class="fas fa-chevron-left"></i>
                                                        </button>
                                                        <button class="pagination-btn active">1</button>
                                                        <button class="pagination-btn" disabled>
                                                            <i class="fas fa-chevron-right"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <% } else { %>
                                                    <div class="empty-state">
                                                        <div class="empty-illustration">
                                                            <i class="fas fa-users-slash"></i>
                                                        </div>
                                                        <h3>No Users Found</h3>
                                                        <p>There are no users to display. Add a new user to get started.
                                                        </p>
                                                        <a href="${pageContext.request.contextPath}/Registration"
                                                            class="add-user-btn">
                                                            <i class="fas fa-plus"></i>
                                                            <span>Add New User</span>
                                                        </a>
                                                    </div>
                                                    <% } %>
                                        </div>
                            </div>
                        </div>

                        <!-- Scripts -->
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                // Profile dropdown
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

                                // Notification close
                                const notificationClose = document.querySelector(".notification-close");
                                if (notificationClose) {
                                    notificationClose.addEventListener("click", function () {
                                        this.closest(".notification").style.display = "none";
                                    });
                                }

                                // Auto-hide notification after 5 seconds
                                setTimeout(() => {
                                    const notification = document.querySelector(".notification");
                                    if (notification) {
                                        notification.style.display = "none";
                                    }
                                }, 5000);
                            });
                        </script>

                    </body>

                    </html>