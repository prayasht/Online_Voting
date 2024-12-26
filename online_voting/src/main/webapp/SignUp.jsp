<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
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
	<h2>Sign Up</h2>
	<form action="RegisterUserServlet" method="post" onsubmit="return checkPass(event)">
		<div class="input-group">
		<label for="uid">Username:</label>
		<input type="text" id="uname" name="uname" required placeholder="Enter your Username">
		</div>
		<div class="input-group">
        <label for="email">Email:</label>
		<input type="email" id="email" name="email" required placeholder="Enter your email">
		</div>
		<div class="input-group">
		<label for="pass">Password:</label>
		<input type="password" id="pass" name="pass" required placeholder="Enter your password">
		</div>
		<div class="input-group">
		<label for="repass">Re-enter Password:</label>
		<input type="password" id="repass" name="repass" required placeholder="Re-Enter your password">
		</div>
		<div class="form-footer">
		<button type="submit">Sign up</button>
		<p>Or Already have an account? Login here...</p>
		<button><a href="login.jsp">Log-in</a></button>
		</div>
	</form>
	</div>
	<div class="img-div">
      <img src="images/sign-up.png" alt="login picture">
      </div>
	</section>
	<script type="text/javascript">
		function checkPass(event) {
			const pass = document.getElementById("pass").value;
			const repass = document.getElementById("repass").value;

			if (pass !== repass) {
				alert("Passwords do not match. Please recheck.");
				event.preventDefault(); 
				return false;
			}
			return true; 
		}
	</script>
</body>
</html>
