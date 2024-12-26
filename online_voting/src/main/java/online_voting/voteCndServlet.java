package online_voting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class voteCndServlet
 */
@WebServlet("/voteCndServlet")
public class voteCndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public voteCndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		int cndId=Integer.parseInt(request.getParameter("cndVote"));
		
		HttpSession session=request.getSession();
		String electionName=(String) session.getAttribute("electionName");
		int userId=(int) session.getAttribute("uid");
		
		
		RegisterCanDao rcDao=new RegisterCanDao();
		int electionId=rcDao.getElectionId(electionName);
		
		String res=rcDao.vote(userId, cndId, electionId);
		
		response.sendRedirect("Elections.jsp");
		
	}

}
