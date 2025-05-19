package com.chapou.controller;

import com.chapou.model.ProductModel;
import com.chapou.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/addproduct")
@MultipartConfig
public class AddProductController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        double price = Double.parseDouble(req.getParameter("price"));

        Part imagePart = req.getPart("image");
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

        String savePath = req.getServletContext().getRealPath("/Resources/Products");
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        imagePart.write(savePath + File.separator + fileName);

        ProductModel product = new ProductModel();
        product.setName(name);
        product.setDescription(description);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setProduct_Image(fileName);

        productService.addProduct(product);

        resp.sendRedirect(req.getContextPath() + "/productmanagement");
    }
}
