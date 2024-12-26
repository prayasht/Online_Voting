

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import online_voting.Election;
import online_voting.RegisterEleDao;

/**
 * Servlet implementation class RegisterEle
 */
@WebServlet("/RegisterEle")
public class RegisterEle extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public RegisterEle() {
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
		String title=request.getParameter("tle");
		String stdate=request.getParameter("stdate");
		String enddate=request.getParameter("enddate");
		
		HttpSession session = request.getSession();
		int uid =(int) session.getAttribute("uid");
		
		Election ele =new Election(title,stdate,enddate,uid);
		RegisterEleDao rDao=new RegisterEleDao();
		
		String res=rDao.insertEle(ele);
		session.setAttribute("alertMessege", res);
		response.sendRedirect("CandidateRegister.jsp");
	}

}
