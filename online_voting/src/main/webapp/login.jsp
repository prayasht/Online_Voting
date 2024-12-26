<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
</head>
<body>
<nav class="navbar">
        <div class="logo"><a href="login.jsp">Online Voting</a></div>
    </nav>
<section>

    <div class="container">
        <h2>Login</h2>
        <form id="loginForm" action="loginservlet" method="post" onsubmit="return validateForm()">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="uname" required placeholder="Enter your username or Email">
            </div>
      
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="pass" required placeholder="Enter your password">
            </div>
            <div class="form-footer">
                <button type="submit">Login</button>
                <p>Or a new user? Sign up here..</p>
                <button><a href="SignUp.jsp">Sign Up</a></button>
            </div>
        </form>
        </div>
      <div class="img-div">
      <img src="images/login_vote.webp" alt="login picture">
      </div>
</section>
        <script type="text/javascript">
        <%
        // Check for error message
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
    alert("<%= errorMessage %>");

	<% 
		} 
	%>
    
        function validateForm() {

            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;

            if (username === "" || password === "") {
                alert("Please fill out both fields.");
                return false;  
            }

            return true;  
        }

        </script>
    </div>
</body>
</html>