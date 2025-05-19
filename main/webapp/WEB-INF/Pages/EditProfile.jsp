
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ page import="com.chapou.model.ProfileModel" %>
        <% ProfileModel profile=(ProfileModel) request.getAttribute("profile"); if (profile==null) {
            response.sendRedirect(request.getContextPath() + "/Login" ); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Edit Profile</title>
                <link rel="stylesheet" type="text/css"
                    href="${pageContext.request.contextPath}/css/EditProfile.css?v=2.0">
            </head>

            <body>

                <%@ include file="/WEB-INF/Pages/Header.jsp" %>

                    <div class="wrapper">
                        <div class="header">
                            <h2>My Account</h2>
                            <span class="title">Edit Profile</span>
                        </div>

                        <div class="content">
                            <div class="side">
                                <div class="profile-pic">
                                    <img src="${pageContext.request.contextPath}/<%= profile.getProfile_Image() %>"
                                        alt="Profile Picture" />
                                </div>
                                <div class="upload-btn-wrapper">
                                    <button class="btn-upload">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                            <polyline points="17 8 12 3 7 8"></polyline>
                                            <line x1="12" y1="3" x2="12" y2="15"></line>
                                        </svg>
                                        Change Photo
                                    </button>
                                    <input type="file" name="profileImage" form="editProfileForm" accept="image/*"
                                        onchange="previewImage(this)" />
                                </div>
                            </div>

                            <div class="form">
                                <h3>Personal Info</h3>
                                <form id="editProfileForm" action="${pageContext.request.contextPath}/editprofile"
                                    method="post" enctype="multipart/form-data">
                                    <div class="row">
                                        <div class="group">
                                            <label>Full Name</label>
                                            <input type="text" name="full_name" value="<%= profile.getFullName() %>"
                                                required />
                                        </div>
                                        <div class="group">
                                            <label>Username</label>
                                            <input type="text" name="username" value="<%= profile.getUsername() %>"
                                                readonly />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="group">
                                            <label>Password</label>
                                            <input type="password" name="password" value="<%= profile.getPassword() %>"
                                                required />
                                        </div>
                                        <div class="group">
                                            <label>Gender</label>
                                            <input type="text" name="gender" value="<%= profile.getGender() %>" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="group">
                                            <label>Email</label>
                                            <input type="email" name="email" value="<%= profile.getEmail() %>"
                                                required />
                                        </div>
                                        <div class="group">
                                            <label>Date of Birth</label>
                                            <input type="date" name="dob" value="<%= profile.getDob() %>" />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="group full">
                                            <label>Phone Number</label>
                                            <input type="text" name="phone" value="<%= profile.getPhone() %>"
                                                required />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="group full">
                                            <button type="submit" class="update-btn">Update Profile</button>
                                            <a href="${pageContext.request.contextPath}/profile"
                                                class="cancel-btn">Cancel</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script>
                        function previewImage(input) {
                            if (input.files && input.files[0]) {
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    document.querySelector('.profile-pic img').src = e.target.result;
                                };
                                reader.readAsDataURL(input.files[0]);
                            }
                        }
                    </script>

                    <%@ include file="/WEB-INF/Pages/Footer.jsp" %>

            </body>

            </html>