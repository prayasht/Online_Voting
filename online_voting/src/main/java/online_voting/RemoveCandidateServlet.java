package online_voting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class RemoveCandidateServlet
 */
@WebServlet("/RemoveCandidateServlet")
public class RemoveCandidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveCandidateServlet() {
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
		String cndId=request.getParameter("candidate_id");
		int candidateId=Integer.parseInt(cndId);
		RegisterCanDao rcDao=new RegisterCanDao();
		boolean dltCand=rcDao.deleteCandidate(candidateId);
		if(dltCand) {
			response.sendRedirect("CandidateRegister.jsp");
		}
		else {
			response.sendRedirect("CandidateRegister.jsp");
		}
		
	}

}
