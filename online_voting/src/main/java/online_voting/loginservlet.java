package online_voting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.Map;

/**
 * Servlet implementation class loginservlet
 */
@WebServlet("/loginservlet")
public class loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginservlet() {
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
	    String uid = request.getParameter("uname");
        String pass = request.getParameter("pass");
        
        RegisterUserDao ruDao=new RegisterUserDao();
        Map<String,Object> userDetail=ruDao.validateLogin(uid, pass);
        
        HttpSession session=request.getSession();
      if(!userDetail.isEmpty()) {
    	  
    	  session.setAttribute("uid", userDetail.get("uid"));
    	  session.setAttribute("uname", userDetail.get("username"));
    	  session.setAttribute("email", userDetail.get("email"));
    	  response.sendRedirect("Dashboard.jsp");  	  
      }
      else {
    	  session.setAttribute("errorMessage", "Invalidate Username or Password.Please Try again.");
    	  response.sendRedirect("login.jsp");
      		} 
	 
        }

}
