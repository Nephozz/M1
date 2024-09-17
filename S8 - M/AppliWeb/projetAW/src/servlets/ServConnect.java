package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import facades.FacadeConnect;

/**
 * Servlet implementation class ServConnect
 */
@WebServlet("/ServConnect")
public class ServConnect extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private FacadeConnect facade;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServConnect() {
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
		String role = request.getParameter("role");
		String idLog = request.getParameter("name");
		String mdp = request.getParameter("mdp");
		ArrayList<String> listInfo = facade.isRegistered(idLog, mdp, role);
		if (listInfo.size() == 4) {
			request.setAttribute("idLog",listInfo.get(0));
			request.setAttribute("nom",listInfo.get(1));
			request.setAttribute("prenom",listInfo.get(2));
			switch (role) {
				case "prof":
					request.setAttribute("listeCours", facade.getCours(Integer.parseInt(listInfo.get(3))));
					request.getRequestDispatcher("html/teacher-home.jsp").forward(request,response);
					break;
				case "etudiant":
					request.setAttribute("listeAbsences", facade.getAbsences(Integer.parseInt(listInfo.get(3))));
					request.getRequestDispatcher("html/student-home.jsp").forward(request,response);
					break;
				case "admin":
					request.getRequestDispatcher("html/admin-home.jsp").forward(request,response);
					break;
				default :
					break;
			}
		} else {
			response.getWriter().println("<html><body>"+listInfo.get(0)+"</body></html>");
		}
	}

}
