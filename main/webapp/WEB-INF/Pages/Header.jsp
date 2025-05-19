<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    HttpSession userSession = request.getSession(false);
    String currentUser = (userSession != null) ? (String) userSession.getAttribute("username") : null;
    pageContext.setAttribute("currentUser", currentUser);
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" type="text/css" href="${contextPath}/css/Header.css?v=1.3.0" />

<div id="header">
    <div class="header">
        <!-- Logo -->
        <div class="logo">
            <a href="${contextPath}/Home">
                <div class="logo-img"></div>
            </a>
        </div>

        <!-- Navigation -->
        <div class="right-nav">
            <div class="main-nav">
                <a href="${contextPath}/Home">Home</a>
                <a href="${contextPath}/product">Products</a>
                <a href="${contextPath}/About">About Us</a>
                <a href="${contextPath}/contact">Contact Us</a>
            </div>

            <!-- Icons -->
            <div class="nav-icons">
                <!-- 🔍 Search Form -->
                <form action="${contextPath}/search" method="get" class="search-form">
                    <input type="text" name="query" placeholder="Search..." class="search-input" required />
                    <button type="submit" class="icon search-icon"></button>
                </form>

                <!-- 👤 User Dropdown -->
                <div class="user-dropdown" onclick="toggleDropdown()">
                    <div class="icon user-icon"></div>
                    <div id="userDropdownContent" class="dropdown-content">
                        <a href="${contextPath}/profile" class="dropdown-link">My Account</a>
                        <hr />
                        <form action="${contextPath}/logout" method="post">
                            <input type="submit" value="Sign Out" class="dropdown-btn" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleDropdown() {
        document.getElementById("userDropdownContent").classList.toggle("show");
    }

    window.onclick = function (event) {
        if (!event.target.closest('.user-dropdown')) {
            document.getElementById("userDropdownContent").classList.remove("show");
        }
    };
</script>
