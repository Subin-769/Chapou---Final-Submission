package com.chapou.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
/**
 * HomeController - Handles home page requests and demonstrates database connectivity
 */
@WebServlet(urlPatterns = {"/About"})
public class AboutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles GET requests to the home page.
     * Adds user session information to request attributes if the user is logged in.
     *
     * @param request  HttpServletRequest object
     * @param response HttpServletResponse object
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("✅ AboutController is running...");

        // Check if user is logged in and set request attributes accordingly


        request.getRequestDispatcher("/WEB-INF/Pages/About.jsp").forward(request, response);
    }



    /**
     * Performs a sample query to list database tables.
     *
     * @param connection Database connection
     * @param request    HttpServletRequest to set attributes on
     */

}