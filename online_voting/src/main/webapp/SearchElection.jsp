<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="online_voting.RegisterCanDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Election</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/navbar.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/section.css"> 
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/search.css">  
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
    <section id="allElectionSection" >
        <div class="section-header">
        	<h2>Search results:</h2>
        	<div id="search-div">
			<form action="SearchElectionServlet" method="post" class="search-bar">
    		<input type="search" name="query" id="eleSearch" placeholder="Search...">
    		<button type="submit">Search</button><br>
    		<h3>Select an Election to vote:</h3>
			</form>
        	 </div>
        	 </div>
	</form>
	<form id="allElectionName" action="ElectionviewServlet" method="post">
	 <input type="hidden" name="electionId" id="buttonValue" />
	<ul id="election_id">
		<%
		session=request.getSession();
		List<String> eleSearchList=(List<String>) session.getAttribute("eleSearchList");
		if(eleSearchList.isEmpty()){%>
		<li>No match Found</li>
		<%}
		else{
			RegisterCanDao rcDao = new RegisterCanDao();
			 for (String ele : eleSearchList) {
             	Map<String,String> time = rcDao.getTime(ele);
             	 List<String> wins=rcDao.getWinners(ele);
                  String winners="";
                  if(wins.isEmpty()){
                  	winners="No voting is done.";
                  	wins.add("No voting done. Nobody ");
                  }
                  else
                  	winners=wins.toString()+" on lead.";
          %>
          <li>
          		<input type="hidden" class="isStarted" value="<%= time.get("start date") %>"/>
          		<input type="hidden" class="isEnded" value="<%= time.get("end date") %>" />
          		<input type="hidden" class="winners" value="<%= wins %>"/>
              <button type="button" class="election_btn" value="<%= ele %>">Election Name: <%= ele %>
              <div class="remaining-time">
              <span id="election-status"></span>
      		<span id="days">00</span> days, 
      		<span id="hours">00</span> hours,
      		<span id="minutes">00</span> minutes, 
      		<span id="seconds">00</span> seconds. 
      		</div>         		</button>

                 <div id="ResultBoard"><p><%=winners %></p></div>
             </li>
         <% 
             }
		}
         %>
	
	</ul>
	</form>
	</section>
	<script type="text/javascript">
	
	document.querySelectorAll("#election_id button").forEach((button) => {
        button.addEventListener("click", function () {
            document.getElementById("buttonValue").value = this.getAttribute("value"); // Set hidden input value
            document.getElementById("allElectionName").submit(); // Submit the form
        });
    });
	
	document.querySelectorAll("#election_id li").forEach((li) => {
	    let button = li.querySelector(".election_btn");
	    let stDate = li.querySelector(".isStarted").value;
	    let endDate = li.querySelector(".isEnded").value;
		let winner = li.querySelector(".winners").value;
		
		//console.log(winner.toString().replace(/\[|\]/g, ""));
	    
		let countdownElements = {
	        days: li.querySelector("#days"),
	        hours: li.querySelector("#hours"),
	        minutes: li.querySelector("#minutes"),
	        seconds: li.querySelector("#seconds"),
	    };

	    let stTime = new Date(stDate).getTime();
	    let endTime = new Date(endDate).getTime();
	    let now = new Date().getTime();

	    let targetTime = now < stTime ? stTime : endTime;
	    let electionStatus = button.querySelector("#election-status");
	    electionStatus.innerText = now < stTime ? "Election Starts in : " : "Election Ends in : ";

	    if (now >= endTime) {
	        button.querySelector(".remaining-time").innerText ="This Election has ended on "+new Date(endTime).toString();
	        if(winner != null || winner != ""){
	        	li.querySelector("#ResultBoard p").innerHTML= winner.toString().replace(/\[|\]/g,"")+" won the Election."
	        }
	        li.style.order=10;
	        return;
	    }

	    	let timer = setInterval(() => {
	        let now = new Date().getTime();
	        let remainingTime = targetTime - now;

	        if (remainingTime <= 0) {
	            clearInterval(timer);
	            button.innerText =button.innerText + "This Election alredy has ended on "+new Date(endTime).toString();
	            if(winner!= null || winner != "")
	            li.querySelector("#ResultBoard p").	innerHTML= winner+" won the Election."
	            return;
	        }

	        let days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
	        let hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	        let minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
	        let seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);

	        countdownElements.days.innerText = days;
	        countdownElements.hours.innerText = hours;
	        countdownElements.minutes.innerText = minutes;
	        countdownElements.seconds.innerText = seconds;
	    }, 1000);
	});
	
	function toggleSidebar() {
	    const sidebar = document.querySelector('.sidebar');
	    sidebar.classList.toggle('show');
	    document.querySelector("section").style.zIndex=1;
	    console.log(document.querySelector("section").style.zIndex);
	    console.log(document.querySelector(".sidebar .show").style.zIndex);
	}

	</script>
</body>
</html>