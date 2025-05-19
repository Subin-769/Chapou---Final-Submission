package com.chapou.controller;

import com.chapou.model.ProfileModel;
import com.chapou.service.ProfileService;
import com.chapou.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/editprofile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 15)   // 15MB
public class EditProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProfileModel currentUser = (ProfileModel) SessionUtil.getAttribute(request, "currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        request.setAttribute("profile", currentUser);
        request.getRequestDispatcher("/WEB-INF/Pages/EditProfile.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProfileModel currentUser = (ProfileModel) SessionUtil.getAttribute(request, "currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // Extract form fields
        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");

        // Handle file upload
        Part filePart = request.getPart("profileImage");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString().trim();

        String imagePath = currentUser.getProfile_Image(); // fallback to existing image

        if (filePart != null && filePart.getSize() > 0 && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "Resources" + File.separator + "UserProfile";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File uploadedFile = new File(uploadDir, fileName);
            filePart.write(uploadedFile.getAbsolutePath());

            imagePath = "Resources/UserProfile/" + fileName;
        }

        // Update ProfileModel
        ProfileModel updated = new ProfileModel();
        updated.setFullName(fullName);
        updated.setUsername(username);
        updated.setPassword(password);
        updated.setGender(gender);
        updated.setEmail(email);
        updated.setDob(dob);
        updated.setPhone(phone);
        updated.setProfile_Image(imagePath);

        boolean updatedSuccessfully = profileService.updateProfile(updated);

        if (updatedSuccessfully) {
            SessionUtil.setAttribute(request, "currentUser", updated);
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("error", "Update failed.");
            request.setAttribute("profile", updated);
            request.getRequestDispatcher("/WEB-INF/Pages/EditProfile.jsp").forward(request, response);
        }
    }
}
