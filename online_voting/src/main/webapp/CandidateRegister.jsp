<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="online_voting.RegisterCanDao" %>
<%@ page import="online_voting.Candidate" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Candidates</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
    
    <script src="js/register.js"></script>
    <script src="js/navbar.js"></script>
</head>
<body>
	<%
		session = request.getSession();
        String electionName = (String) session.getAttribute("electionName");
	%> 
					
	<nav class="navbar">
        <div class="logo"><a href="Dashboard.jsp">Online Voting</a></div>
    <!-- Sidebar -->
	<aside class="sidebar">
    <ul>
        <li><a href="Accounts.jsp">Accounts</a></li>
        <li><a href="Dashboard.jsp">Home</a></li>
        <li><a href="CreateElection.jsp">Create a new Election</a></li>
        <li><a href="ShowAllElection.jsp">All Elections</a></li>
        <li><a id="showMyElections" href="ShowMyElection.jsp">My Elections</a></li>
        <li><a href="${pageContext.request.contextPath}/LogoutServlet" onclick="return logout(this);">Logout</a></li>

    </ul>
	</aside>
<!-- Toggle Button -->
<button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>

    </nav>
    <section >
    <div class="section-header">
    <br><h2>Candidate Manage for <%=electionName %>: </h2><br>
    </div>
    <div class="quote">
     <pre>"A leader is not the one who merely holds power 
     	but one who inspires trust, serves selflessly,
     	and leads with integrity for the greater good."
— Mahatma Gandhi</pre>
	</div>
     <div class="container">
    
        <h2>Add Candidate</h2>
        
        <form action="RegisterCandidate" method="post" onsubmit="return confirmAdd()">
            <label for="id">Candidate ID:</label>
            <input type="number" id="id" name="id" required>

            <label for="name">Candidate Name:</label>
            <input type="text" id="name" name="name" required>

            <input type="submit" value="Add Candidate">
        </form>

        <h2>Remove Candidate</h2>
        <form action="RemoveCandidateServlet" method="post" onsubmit="return confirmDelete()">
        
            <label for="candidate_id">Select Candidate:</label>
            <select id="candidate_id" name="candidate_id" required>
                
                    <%
                    RegisterCanDao rcDao = new RegisterCanDao();
                    int electionId = rcDao.getElectionId(electionName);
					
                    
                    List<Candidate> candidateList = rcDao.getCandidateName(electionId);

                    if (candidateList != null && !candidateList.isEmpty()) {
                %>
                    <option value="" disabled selected>Select a candidate to remove</option>
                    <%
                        for (Candidate cnd : candidateList) {
                    %>
                        <option value="<%= cnd.getId() %>"><%= cnd.getName() %></option>
                    <%
                        }
                    } else {
                    %>
                        <option value="" disabled>No candidates registered.</option>
                    <%
                    }
                %>
            </select>
            <input type="submit" value="Remove Candidate">
        </form>
        <form action="ElectionviewServlet" method="post">
        <input type="hidden" name="electionId" value="<%=electionName %>">
        <input type="submit"  value="Done">
       </form>
        </div>
        <span class="image-div">
        <img src="images/vote-us-pic.webp" alt="candidate-image">
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
