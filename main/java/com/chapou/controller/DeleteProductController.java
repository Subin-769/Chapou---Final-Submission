package com.chapou.controller;

import com.chapou.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteproduct")
public class DeleteProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        productService.deleteProduct(productId);
        response.sendRedirect(request.getContextPath() + "/productmanagement");
    }
}
