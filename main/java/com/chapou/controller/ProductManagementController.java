package com.chapou.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.chapou.model.ProductModel;
import com.chapou.service.ProductService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class ProductManagementController
 */
@WebServlet("/productmanagement")
public class ProductManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");
        List<ProductModel> products;

        if (query != null && !query.trim().isEmpty()) {
            products = productService.searchProducts(query);
        } else {
            products = productService.getAllProducts();
        }

        request.setAttribute("products", products);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/ProductManagement.jsp").forward(request, response);
    }
}
