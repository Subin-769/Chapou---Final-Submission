package com.chapou.controller;

import com.chapou.model.CustomerModel;
import com.chapou.model.ProfileModel;
import com.chapou.service.LoginService;
import com.chapou.service.ProfileService;
import com.chapou.util.CookieUtil;
import com.chapou.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/Login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final LoginService loginService;
    private final ProfileService profileService;

    public LoginController() {
        this.loginService = new LoginService();
        this.profileService = new ProfileService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            ProfileModel user = (ProfileModel) session.getAttribute("currentUser");
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        // Prevent browser cache from showing old login
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String role = req.getParameter("role"); 
        String username = req.getParameter("username");
        String password = req.getParameter("password");

     // ADMIN LOGIN
        if ("admin".equals(role)) {
            if ("admin".equals(username) && "admin".equals(password)) {
                ProfileModel admin = new ProfileModel();
                admin.setUsername("admin");
                admin.setRole("admin");

                SessionUtil.setAttribute(req, "currentUser", admin);
                CookieUtil.addCookie(resp, "role", "admin", 5 * 60);

                resp.sendRedirect(req.getContextPath() + "/admin");
                return;
            } else {
                req.setAttribute("error", "Invalid admin credentials.");
                req.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(req, resp);
                return;
            }
        }

        // USER LOGIN
        if ("user".equals(role)) {
            if ("admin".equals(username)) {
                req.setAttribute("error", "Admin cannot login from user tab.");
                req.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(req, resp);
                return;
            }

            CustomerModel customer = new CustomerModel();
            customer.setUsername(username);
            customer.setPassword(password);

            Boolean loginStatus = loginService.loginUser(customer);

            if (loginStatus != null && loginStatus) {
                ProfileModel user = profileService.getUserByUsername(username);
                user.setRole("user");

                SessionUtil.setAttribute(req, "currentUser", user);
                CookieUtil.addCookie(resp, "role", "user", 5 * 60);

                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("error", "Invalid user credentials.");
                req.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(req, resp);
            }
        }
    }
 }
