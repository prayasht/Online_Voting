<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="online_voting.RegisterCanDao" %>
<%@ page import="online_voting.Candidate" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.JSONArray" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Elections</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/elections.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
	<%
		session=request.getSession();
		String electionName=(String) session.getAttribute("electionName");
		
		RegisterCanDao rcDao=new RegisterCanDao();
		int electionId=rcDao.getElectionId(electionName);
		
		Map<String,String> time = rcDao.getTime(electionName);
        List<String> wins=rcDao.getWinners(electionName);
        String winners="";
        if(wins.isEmpty()){
        	winners="No voting is done.";
        	wins.add("No voting done. Nobody ");
        }
        else
        	winners=wins.toString()+" on lead.";
	%>
	<h1 ><%=electionName %></h1>
	<input type="hidden" id="isStarted" value="<%= time.get("start date") %>"/>
	<input type="hidden" id="isEnded" value="<%= time.get("end date") %>" />
    <input type="hidden" id="winners" value="<%= wins %>"/>
     <div id="remaining-time">
    	<span id="election-status"></span>
        <span id="days">00</span> days, 
        <span id="hours">00</span> hours,
        <span id="minutes">00</span> minutes, 
        <span id="seconds">00</span> seconds. 
     </div>

	<canvas id="electionChat"></canvas>
	
	
   <form id="votes_form" action="voteCndServlet" method="post">

   <input type="hidden" id="cndVote" name="cndVote">
   <h2>Select Candidates to Vote:</h2>
 		<ol id="voteCnd">
 		        <%
	    	List<Candidate> candidateList = new ArrayList<>();
        	candidateList = rcDao.getCandidateName(electionId);
        	if (candidateList != null && !candidateList.isEmpty()) {
        %>
        	<%
        	for(Candidate cnd:candidateList){   
        	%>
        	<li><button value="<%= cnd.getId() %>"><%=cnd.getName()%></button></li>
        	<%
        		}
        	}else {   %>
        		<li value="" >No Candidate registered.</li>
        		<%
        	}
        	%> 		
 		</ol>  
   
   </form>
   <div class="quote">
   <pre>"The vote is the most powerful nonviolent tool we have."
– John Lewis</pre>
   </div>
   <div class="image-div">
   <image src="images/vote_pic_4.png" alt="Vote here picture">
   </div>
   </section>
    <script>
   
    <%
     rcDao=new RegisterCanDao();
	 electionId=rcDao.getElectionId(electionName);
	
	List<Map<String, Object>> graphData=rcDao.getEleGraphData(electionId);
	session.setAttribute("eleGraph", graphData); 
	
	int userId=(int)session.getAttribute("uid");
    %>
    
    window.onload = function () {
        const userId = <%= userId %>;
        const electionId = <%= electionId %>;
        const isValidVote = <%= rcDao.validVote(userId, electionId) %>;

        if (isValidVote) {
            document.getElementById("votes_form").innerHTML = "<h3>You have already voted. Please wait for the results.</h3>";
        }

        setupCountdown();
        setupChart();
        setupVoting();
    };

    function setupChart() {
        const eleGraph = <%= new org.json.JSONArray((List) session.getAttribute("eleGraph")).toString() %>;

        const candidates = eleGraph.map(point => point.x);
        const votes = eleGraph.map(point => point.y);

        const ctx = document.getElementById('electionChat').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: candidates,
                datasets: [{
                    label: 'Votes',
                    data: votes,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(153, 102, 255, 0.5)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function setupVoting() {
        const hiddenInput = document.getElementById("cndVote");
        document.querySelectorAll("#voteCnd button").forEach(button => {
            button.addEventListener("click", function (event) {
                event.preventDefault();
                if (confirm(`Are you sure you want to vote for candidate?`)) {
                    hiddenInput.value = this.value;
                    document.getElementById("votes_form").submit();
                }
            });
        });
    }

    function setupCountdown() {
    	const winner=document.getElementById("winners").value;
    	
        const stDate = document.getElementById("isStarted").value;
        const endDate = document.getElementById("isEnded").value;
        const now = new Date().getTime();
        
        if (now >= new Date(endDate).getTime()) {
            document.getElementById("remaining-time").innerHTML ="This Election has ended on "+new Date(endDate).toString();
            if(winner != null || winner != ""){
            	document.getElementById("votes_form").innerHTML= winner.toString().replace(/\[|\]/g,"")+" won the Election.";
            }
            return;
        }

        let targetTime = now < new Date(stDate).getTime() ? stDate : endDate;
        const electionStatus = document.getElementById("election-status");
        electionStatus.innerText = now < new Date(stDate).getTime() ? "Election Starts in: " : "Election Ends in: ";

        const timer = setInterval(() => {
            const now = new Date().getTime();
            const remainingTime = new Date(targetTime).getTime() - now;

            if (remainingTime <= 0) {
                clearInterval(timer);
                document.getElementById("remaining-time").innerHTML = "This Election has ended on"+new Date(endDate).toString();
                
                return;
            }

            const days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
            const hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);

            document.getElementById("days").innerText = days;
            document.getElementById("hours").innerText = hours;
            document.getElementById("minutes").innerText = minutes;
            document.getElementById("seconds").innerText = seconds;
        }, 1000);
    }

    function toggleSidebar() {
        const sidebar = document.querySelector('.sidebar');
        sidebar.classList.toggle('show');
        document.querySelector("section").style.zIndex = 1;
    }
</script>
 </body>
 </html>   
    
    