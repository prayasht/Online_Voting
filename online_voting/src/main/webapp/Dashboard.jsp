<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="online_voting.RegisterCanDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DashBoard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css"> 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homePage.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/search.css"> 
	
	<script src="js/navbar.js"></script>
</head>
<body>
 <nav class="navbar">
        <div class="logo"><a href="Dashboard.jsp">Online Voting</a></div>
        <div class="nav-links">
            <a id="showAllElections" href="ShowAllElection.jsp">Show All Elections</a>
            <a id="showMyElections" href="ShowMyElection.jsp">My Elections</a>
        </div>
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


    <div class="content">
        <section id="home">
        	<div>
        	<h2>Hello!!<%= session.getAttribute("uname") %> ,Welcome to Our Online Voting System!</h2> Our platform is designed to provide a secure, transparent, and user-friendly environment for conducting elections. Whether you're a voter or an administrator, our system ensures a seamless experience from registration to results.
        	</div>
        	 <div id="search-div">
			<form action="SearchElectionServlet" method="post" class="search-bar">
    		<input type="search" name="query" id="eleSearch" placeholder="Search...">
    		<button type="submit">Search</button>
			</form>
        	 </div>
        	 <a id="showAllElections" href="ShowAllElection.jsp">See All Elections</a> 
        	 <div class="image-div">
        	 <img src="images/hello_vote_3.png" alt="Welcome Image">
        	 </div>
        </section>

      </div>

</body>
</html>
