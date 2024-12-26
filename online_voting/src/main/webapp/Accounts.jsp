<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css">
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
	<script src="js/navbar.js"></script>
</head>
<body>
	<nav class="navbar">
        <div class="logo"><a href="Dashboard.jsp">Online Voting</a></div>
        
    <!-- Sidebar -->
	<aside class="sidebar">
    <ul>
        <li><a href="Accounts.jsp">Accounts</a></li>
        <li><a href="Dashboard.jsp">Home</a></li>
        <li><a href="CreateElection.jsp">Create a new Election</a></li>
        <li><a href="ShowAllElection.jsp">All Elections</a>
        <li><a id="showMyElections" href="ShowMyElection.jsp">My Elections</a></li>
        <li><a href="${pageContext.request.contextPath}/LogoutServlet" onclick="return logout(this);">Logout</a></li>

    </ul>
	</aside>
<!-- Toggle Button -->
<button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
		</nav>
	<section>
	 <div class="section-header">
    <br><h2>User Manage for <%=session.getAttribute("uname") %>: </h2><br>
    </div>
    <div class="quote">
     <pre>"A leader is not the one who merely holds power 
     	but one who inspires trust, serves selflessly,
     	and leads with integrity for the greater good."
— Mahatma Gandhi</pre>
	</div>
    <div class="container">
        <h2>Update Account Information</h2>
        <form action="UpdateAccountServlet" method="post">
            <label for="username">New Username:</label>
            <input type="text" id="username" name="username" placeholder="Enter new username" required>

            <label for="email">New Email:</label>
            <input type="email" id="email" name="email" placeholder="Enter new email" required>

            <label for="password">New Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter new password" required>

            <input type="submit" value="Update">
        </form>

        <% 
            // Check for error and success messages
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            if (errorMessage != null) { 
        %>
            <script>
                alert("<%= errorMessage %>");
            </script>
        <% 
            } else if (successMessage != null) { 
        %>
            <script>
                alert("<%= successMessage %>");
            </script>
        <% 
            } 
        %>
    </div>
     <span class="image-div">
        <img src="images/vote-us-pic.webp" alt="candidate-image">
        </span>
    </section>
</body>
</html>
