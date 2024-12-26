package online_voting;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class UpdateAccountServlet
 */
@WebServlet("/UpdateAccountServlet")
public class UpdateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccountServlet() {
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
		HttpSession session = request.getSession(false);
        if (session.getAttribute("uid") == null) {
            // Redirect to login page if not logged in
            response.getWriter().print(session.getAttribute("uname"));
            return;
        }

        int userId = (int) session.getAttribute("uid"); 
        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        try {
            // Add your DAO logic to update user details in the database
            RegisterUserDao userDao = new RegisterUserDao();
            boolean isUpdated = userDao.updateUser(userId, newUsername, newEmail, newPassword);

            if (isUpdated) {
                // Set success message and forward to the JSP
            	session.setAttribute("email",newEmail);
            	session.setAttribute("uname",newUsername);
                request.setAttribute("successMessage", "Account updated successfully!");
            } else {
                throw new Exception("Failed to update account. Please try again.");
            }
        } catch (Exception e) {
            // Set error message and forward to the JSP
            request.setAttribute("errorMessage", e.getMessage());
        }

        // Forward back to the update account page
        request.getRequestDispatcher("Accounts.jsp").forward(request, response);
    
	}

}
