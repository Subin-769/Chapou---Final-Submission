package com.chapou.controller;

import com.chapou.model.ProfileModel;
import com.chapou.service.ProfileService;
import com.chapou.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession(false);
    	ProfileModel currentUser = (session != null) ? (ProfileModel) session.getAttribute("currentUser") : null;

    	if (currentUser == null) {
    	    response.sendRedirect(request.getContextPath() + "/Login");
    	    return;
    	}

        request.setAttribute("profile", currentUser);
        request.getRequestDispatcher("/WEB-INF/Pages/UserProfile.jsp").forward(request, response);
    }

    // Update profile (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String profileImage = request.getParameter("profileImage"); 

        ProfileModel updatedProfile = new ProfileModel();
        updatedProfile.setFullName(fullName);
        updatedProfile.setUsername(username);
        updatedProfile.setPassword(password);
        updatedProfile.setGender(gender);
        updatedProfile.setEmail(email);
        updatedProfile.setDob(dob);
        updatedProfile.setPhone(phone);
        updatedProfile.setProfile_Image(profileImage);

        boolean success = profileService.updateProfile(updatedProfile);

        if (success) {
            ProfileModel refreshedProfile = profileService.getUserByUsername(username);
            SessionUtil.setAttribute(request, "currentUser", refreshedProfile);

            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("error", "Failed to update profile.");
            request.setAttribute("profile", updatedProfile);
            request.getRequestDispatcher("/WEB-INF/Pages/EditProfile.jsp").forward(request, response);
        }
    }
}
