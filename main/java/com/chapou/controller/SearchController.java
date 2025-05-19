package com.chapou.controller;

import com.chapou.model.ProductModel;
import com.chapou.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String query = req.getParameter("q");
        if (query == null || query.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/product");
            return;
        }

        ProductModel exactMatch = productService.findProductByExactName(query.trim());

        if (exactMatch != null) {
            // If exact match is found, redirect to product detail page
            int id = exactMatch.getProductId();
            resp.sendRedirect(req.getContextPath() + "/product-detail?id=" + id);
        } else {
            // If no exact match, search for partial matches
            List<ProductModel> searchResults = productService.searchProducts(query.trim());
            
            req.setAttribute("searchQuery", query);
            req.setAttribute("searchResults", searchResults);
            req.setAttribute("resultsCount", searchResults.size());
            req.setAttribute("notFound", searchResults.isEmpty());
            
            req.getRequestDispatcher("/WEB-INF/Pages/SearchResults.jsp").forward(req, resp);
        }
    }
}