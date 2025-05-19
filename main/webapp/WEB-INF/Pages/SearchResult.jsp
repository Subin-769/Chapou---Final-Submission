<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String query = (String) request.getAttribute("searchQuery");
    Boolean notFound = (Boolean) request.getAttribute("notFound");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search - <%= query %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/SearchResults.css">
</head>
<body>
    <div class="container">
        <h2>Search Results for "<%= query %>"</h2>

        <c:if test="${notFound}">
            <p>No product found for "<%= query %>".</p>
            <a href="${pageContext.request.contextPath}/product">Go back to Products</a>
        </c:if>

        <c:if test="${!notFound}">
            <c:forEach var="product" items="${searchResults}">
                <div class="product-redirect">
                    <script>
                        window.location.href = '${pageContext.request.contextPath}/product-detail?id=${product.productId}';
                    </script>
                </div>
            </c:forEach>
        </c:if>
    </div>
</body>
</html>
