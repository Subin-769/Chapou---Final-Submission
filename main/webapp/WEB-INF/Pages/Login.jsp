<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Login.css?v=1.3.0">
</head>

<%
    Object currentUser = session.getAttribute("currentUser");
    if (currentUser != null) {
        String role = ((com.chapou.model.ProfileModel) currentUser).getRole();
        if ("admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
        return;
    }
%>


<body>
    <div class="login-form">
        <%
            String errorMessage = (String) request.getAttribute("error");
            String successMessage = (String) request.getAttribute("success");

            if (errorMessage != null && !errorMessage.isEmpty()) {
                out.println("<p class=\"error-message\">" + errorMessage + "</p>");
            }

            if (successMessage != null && !successMessage.isEmpty()) {
        %>
            <p class="success-message"><%= successMessage %></p>
        <%
            }
        %>

        <div class="login-box">
            <h2>Sign in to Chapou</h2>
           <div class="role">
    <button class="role-btn active" id="userBtn" onclick="switchRole('user')">User</button>
    <button class="role-btn" id="adminBtn" onclick="switchRole('admin')">Administrator</button>
    <div class="slider" id="slider"></div>
</div>


 <form id="loginForm" action="${pageContext.request.contextPath}/Login" method="post">
    <input type="hidden" name="role" id="roleInput" value="user" />

    <label for="username" id="usernameLabel">Email or username</label>
    <input type="text" id="username" name="username" placeholder="" required />

    <label for="password" id="passwordLabel">Password</label>
    <input type="password" id="password" name="password" required />

    <button type="submit" class="login-button">Sign In</button>

    <div class="social-icons" id="socialIcons">
        <img src="https://img.icons8.com/color/48/000000/google-logo.png" alt="Google" />
        <img src="https://img.icons8.com/ios-filled/48/000000/facebook-new.png" alt="Facebook" />
        <img src="https://img.icons8.com/ios-filled/48/000000/mac-os.png" alt="Apple" />
    </div>
</form>

            <p class="signup-text" id="signupText">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/Registration"><b><u>Sign Up</u></b></a>
            </p>
        </div>

        <footer>
            <p>Chapou &copy; 2025 • Secure Printer Management</p>
        </footer>
    </div>

<script>
    let currentRole = "user";

    function switchRole(role) {
        const userBtn = document.getElementById("userBtn");
        const adminBtn = document.getElementById("adminBtn");
        const slider = document.getElementById("slider");
        const signupText = document.getElementById("signupText");
        const usernameLabel = document.getElementById("usernameLabel");
        const passwordLabel = document.getElementById("passwordLabel");
        const socialIcons = document.getElementById("socialIcons");
        const roleInput = document.getElementById("roleInput");

        currentRole = role;
        roleInput.value = role; 

        if (role === "user") {
            slider.style.transform = "translateX(0%)";
            userBtn.classList.add("active");
            adminBtn.classList.remove("active");

            usernameLabel.innerText = "Email or username";
            passwordLabel.innerText = "Password";

            signupText.innerHTML = `Don't have an account?
                <a href="${pageContext.request.contextPath}/Registration"><b><u>Sign Up</u></b></a>`;

            socialIcons.style.display = "flex";
        } else {
            slider.style.transform = "translateX(100%)";
            adminBtn.classList.add("active");
            userBtn.classList.remove("active");

            usernameLabel.innerText = "Admin Username";
            passwordLabel.innerText = "Admin Password";

            signupText.innerHTML = 'Contact IT support.';
            socialIcons.style.display = "none";
        }
        
        window.onload = () => {
            document.getElementById("username").value = "";
            document.getElementById("password").value = "";
        };

    }
</script>

</body>

</html>
