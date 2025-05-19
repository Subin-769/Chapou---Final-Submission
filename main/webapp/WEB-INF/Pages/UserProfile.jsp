<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.chapou.model.ProfileModel" %>
<%
    ProfileModel profile = (ProfileModel) request.getAttribute("profile");
    if (profile == null) {
        response.sendRedirect(request.getContextPath() + "/Login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/UserProfile.css?v=2.0">
</head>
<body>

    <%@ include file="/WEB-INF/Pages/Header.jsp" %>

    <div class="wrapper">
        <div class="header">
            <h2>My Account</h2>
            <span class="title">Profile</span>
        </div>

        <div class="content">
            <div class="side">
                <div class="profile-pic">
<img src="${pageContext.request.contextPath}/<%= profile.getProfile_Image() %>" alt="Profile Picture" />
                </div>
            </div>

            <div class="form">
                <h3>Personal Info</h3>
                <form>
                    <div class="row">
                        <div class="group"> 
                            <label>Full Name</label>
                            <input type="text" value="<%= profile.getFullName() %>" readonly />
                        </div>
                        <div class="group">
                            <label>Username</label>
                            <input type="text" value="<%= profile.getUsername() %>" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="group">
                            <label>Password*</label>
                            <input type="password" value="********" readonly />
                        </div>
                        <div class="group">
                            <label>Gender</label>
                            <input type="text" value="<%= profile.getGender() %>" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="group">
                            <label>Email</label>
                            <input type="email" value="<%= profile.getEmail() %>" readonly />
                        </div>
                        <div class="group">
                            <label>Date of Birth</label>
                            <input type="text" value="<%= profile.getDob() %>" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="group full">
                            <label>Phone Number</label>
                            <input type="text" value="<%= profile.getPhone() %>" readonly />
                        </div>
                    </div>

                    <div class="row">
                        <div class="group full">
							<a href="${pageContext.request.contextPath}/editprofile?action=edit">
    							<button type="button" class="edit-btn">Edit Personal Info</button>
							</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/Pages/Footer.jsp" %>

</body>
</html>
