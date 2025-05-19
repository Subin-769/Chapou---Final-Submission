package com.chapou.controller;

import com.chapou.model.ProductModel;
import com.chapou.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = { "/product" })
public class ProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ProductModel> products = productService.getAllProducts();
        
        for (ProductModel p : products) {
            System.out.println("Loaded product image: " + p.getProduct_Image());
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/Pages/Product.jsp").forward(request, response);
    }
}
