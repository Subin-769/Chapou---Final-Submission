package com.chapou.controller;

import com.chapou.model.CustomerModel;
import com.chapou.model.ProductModel;
import com.chapou.model.ProfileModel;
import com.chapou.service.OrderService;
import com.chapou.service.ProductService;
import com.chapou.service.ProfileService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(asyncSupported = true, urlPatterns = { "/product-detail" })
public class ProductDetailController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ProductDetailController.class.getName());

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productIdParam = request.getParameter("id");

        // Validate product ID param
        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            logger.warning("Product ID parameter is missing.");
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        ProductModel product = null;
        try {
            int productId = Integer.parseInt(productIdParam);
            logger.info("Fetching product details for ID: " + productId);
            product = productService.getProductById(productId);

            if (product == null) {
                logger.warning("No product found with ID: " + productId);
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }

        } catch (NumberFormatException e) {
            logger.warning("Invalid product ID format: " + productIdParam);
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/WEB-INF/Pages/ProductDetail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Object currentUserObj = request.getSession().getAttribute("currentUser");
        if (currentUserObj == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            response.getWriter().write("User not logged in.");
            return;
        }

        String productIdParam = request.getParameter("id");
        String quantityParam = request.getParameter("quantity");

        if (productIdParam == null || quantityParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing product ID or quantity.");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            ProductModel product = productService.getProductById(productId);
            if (product == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Product not found.");
                return;
            }

            if (product.getQuantity() < quantity) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Insufficient stock.");
                return;
            }

            ProfileModel user = (ProfileModel) currentUserObj;
            ProfileService profileService = new ProfileService();
            int customerId = profileService.getCustomerIdByUsername(user.getUsername());

            if (customerId == -1) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Could not find customer ID.");
                return;
            }


            double totalPrice = product.getPrice() * quantity;

            // Insert order
            OrderService orderService = new OrderService();
            String username = user.getUsername();
            String productName = product.getName();
            boolean orderInserted = orderService.insertOrder(customerId, username, productId, productName, quantity, totalPrice);


            if (orderInserted) {
                // Reduce product stock
            	productService.updateProductQuantity(productId, quantity);

                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Order placed successfully.");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to place order.");
            }

        } catch (NumberFormatException e) {
            logger.warning("Invalid product ID or quantity format.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid product ID or quantity.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred.");
        }
    }

}
