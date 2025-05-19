package com.chapou.filter;

import com.chapou.model.ProfileModel;
import com.chapou.util.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/Login";
    private static final String REGISTER = "/Registration";
    private static final String LOGOUT = "/logout";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String ABOUT = "/about";
    private static final String CONTACT = "/contact";
    private static final String PRODUCT = "/product";
    private static final String PRODUCT_DETAIL = "/product-detail";
    private static final String PROFILE = "/profile";
    private static final String ADMIN_DASHBOARD = "/admin";

    private static final String NOT_AUTHORIZED_JSP = "/WEB-INF/Pages/not_authorized.jsp";

    private Set<String> publicPages;
    private Set<String> guestOnlyPages;
    private Set<String> adminPages;

    public void init(FilterConfig filterConfig) {
    	publicPages = new HashSet<>(Arrays.asList(
    		    ROOT, HOME, ABOUT, CONTACT, PRODUCT, PRODUCT_DETAIL
    		));
        guestOnlyPages = new HashSet<>(Arrays.asList("/Login", "/Registration"));
    }


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Allow static assets
        if (path.matches(".*\\.(css|js|png|jpg|jpeg|gif|woff2?|ttf|svg|ico)$")) {
            chain.doFilter(req, res);
            return;
        }

        ProfileModel currentUser = SessionUtil.getLoggedInUser(req);
        boolean isLoggedIn = currentUser != null;
        boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(currentUser.getRole());

        // 1. Allow all public pages
        if (publicPages.contains(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 2. Guest-only pages
        if (guestOnlyPages.contains(path)) {
            if (isLoggedIn) {
                if (isAdmin) {
                    res.sendRedirect(contextPath + "/admin");
                } else {
                    res.sendRedirect(contextPath + "/home");
                }
            } else {
                chain.doFilter(req, res);
            }
            return;
        }

        //3. Require login for everything else
        if (!isLoggedIn && !publicPages.contains(path) && !guestOnlyPages.contains(path)) {
            res.sendRedirect(contextPath + LOGIN);
            return;
        }

        // 4. Restrict admin 
        if (path.startsWith("/admin")) {
            if (!isAdmin) {
                req.getRequestDispatcher("/WEB-INF/pages/not_authorized.jsp").forward(req, res);
            } else {
                chain.doFilter(req, res);
            }
            return;
        }
        
        if (path.equals(LOGOUT)) {
            if (isLoggedIn) {
                chain.doFilter(req, res);
            } else {
                res.sendRedirect(contextPath + LOGIN);
            }
            return;
        }
        
        publicPages = new HashSet<>(Arrays.asList(
        	    ROOT, HOME, ABOUT, CONTACT, PRODUCT, PRODUCT_DETAIL, "/search"
        	));


           chain.doFilter(req, res);
    }
}
