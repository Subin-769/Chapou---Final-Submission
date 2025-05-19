package com.chapou.controller;

import com.chapou.model.ProductModel;
import com.chapou.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/editproduct")
public class EditProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        double price = Double.parseDouble(req.getParameter("price"));

        ProductModel product = new ProductModel();
        product.setProductId(productId);
        product.setName(name);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setPrice(price);

        productService.updateProduct(product);

        resp.sendRedirect(req.getContextPath() + "/productmanagement");
    }
}
