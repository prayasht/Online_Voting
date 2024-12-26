<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Election</title>
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
	<br><h2>Create a new Election:</h2><br>
	</div>
	<div class="quote">
	<pre>
	"Voting is the expression of our commitment to 
		ourselves, one another, this country, and this world."
– Sharon Salzberg
	</pre>
	</div>
    <div class="container">
        <h2>Register Election</h2>
        <form action="RegisterEle" method="post">
            <label for="title">Enter the Title of the Election:</label>
            <input type="text" id="title" name="tle" required>

            <label for="stdate">Enter the Start Date and Time:</label>
            <input type="datetime-local" id="stdate" name="stdate" required>

            <label for="enddate">Enter the End Date and Time:</label>
            <input type="datetime-local" id="enddate" name="enddate" required>

            <input type="submit" value="Register Election">
        </form>
    </div>
    <span class="image-div">
    <img src="images/election_pic2.png" alt="Election picture">
    </span>
    </section>
     <% 
        // Check for error message
        String alertMessage = (String) request.getAttribute("alertMessage");
        if (alertMessage != null) { 
    %>
        <script>
            alert("<%= alertMessage %>");
        </script>
    <% 
        } 
    %>
</body>
</html>
