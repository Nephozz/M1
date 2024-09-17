package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import facades.FacadeAdmin;

/**
 * Servlet implementation class ServAdmin
 */
@WebServlet("/ServAdmin")
public class ServAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String nom;
	
	private String prenom;
	
	private String idLog;

	@EJB
	private FacadeAdmin facade;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opc = request.getParameter("opc");
		switch (opc) {
			case "salles":
				request.setAttribute("listeSalle", facade.getSalles());
				request.getRequestDispatcher("html/admin-rooms.jsp").forward(request,response);
				break;
			case "cours":
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.setAttribute("listeSalles", facade.getSalles());
				request.setAttribute("listeCours", facade.getCours());
				request.getRequestDispatcher("html/admin-seance.jsp").forward(request,response);
				break;
			case "etu":
				request.setAttribute("listeEtus", facade.getEtudiants());
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.getRequestDispatcher("html/admin-students.jsp").forward(request,response);
				break;
			case "prof":
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.getRequestDispatcher("html/admin-teachers.jsp").forward(request,response);
				break;
			case "fil":
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.getRequestDispatcher("html/admin-filiere.jsp").forward(request,response);
				break;
			case "mat":
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.getRequestDispatcher("html/admin-lesson.jsp").forward(request,response);
				break;
			default :
				break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("idLog",this.idLog);
		request.setAttribute("nom",this.nom);
		request.setAttribute("prenom",this.prenom);
		String op = request.getParameter("op");
		switch (op) {

			case "addSalle":
				String nomSalle = request.getParameter("nomSalle");
				int capaciteSalle = Integer.valueOf(request.getParameter("capaciteSalle"));
				facade.ajoutSalle(nomSalle, capaciteSalle);
				request.setAttribute("listeSalle", facade.getSalles());
				request.getRequestDispatcher("html/admin-rooms.jsp").forward(request,response);
				break;

			case "rmvSalle":
				int idSalle = Integer.parseInt(request.getParameter("idSalle"));
				facade.suprSalle(idSalle);
				request.setAttribute("listeSalle", facade.getSalles());
				request.getRequestDispatcher("html/admin-rooms.jsp").forward(request,response);
				break;
			
			case "addMat":
				String[] filieres = request.getParameterValues("filiere");
				String profRespo = request.getParameter("responsable");
				String nomMat = request.getParameter("nomMat");
				facade.ajoutMatiere(nomMat, Integer.parseInt(profRespo), filieres);
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.getRequestDispatcher("html/admin-lesson.jsp").forward(request,response);
				break;
			
			case "suprMat":
				String idMat = request.getParameter("idMat");
				facade.suprMatiere(Integer.parseInt(idMat));
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.getRequestDispatcher("html/admin-lesson.jsp").forward(request,response);
				break;
				
			case "addStudent":
				String nom = request.getParameter("nom");
				String prenom = request.getParameter("prenom");
				String filiere = request.getParameter("filiere");
				String ifLog = request.getParameter("idLog");
				String mdp = request.getParameter("mdp");
				facade.ajoutEtudiant(nom, prenom, Integer.parseInt(filiere), mdp, idLog);
				request.setAttribute("listeEtus", facade.getEtudiants());
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.getRequestDispatcher("html/admin-students.jsp").forward(request,response);
				break;

			case "suprStudent": 
				int idEtu = Integer.parseInt(request.getParameter("idEtu"));
				facade.suprEtudiant(idEtu);
				request.setAttribute("listeEtus", facade.getEtudiants());
				request.getRequestDispatcher("html/admin-students.jsp").forward(request,response);
				break;
			
			case "addTeacher":
				String nomT = request.getParameter("nom");
				String prenomT = request.getParameter("prenom");
				String idLog = request.getParameter("idLog");
				String mdpT = request.getParameter("mdp");
				facade.ajoutProfesseur(idLog, nomT, prenomT, mdpT);
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.getRequestDispatcher("html/admin-teachers.jsp").forward(request,response);
				break;

			case "suprTeacher":
				int idProf = Integer.parseInt(request.getParameter("idProf"));
				facade.suprProfesseur(idProf);
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.getRequestDispatcher("html/admin-teachers.jsp").forward(request,response);
				break;
				
			case "addSeance":
				String creneau = request.getParameter("creneau");
				String idProfS = request.getParameter("prof");
				String idMatiere = request.getParameter("matiere");
				String idSalleS = request.getParameter("salle");
				facade.ajoutCours(creneau,Integer.parseInt(idProfS),Integer.parseInt(idMatiere),Integer.parseInt(idSalleS));
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.setAttribute("listeSalles", facade.getSalles());
				request.setAttribute("listeCours", facade.getCours());
				request.getRequestDispatcher("html/admin-seance.jsp").forward(request,response);
				break;
				
			case "suprSeance":
				String idCours = request.getParameter("idCours");
				facade.suprCours(Integer.parseInt(idCours));
				request.setAttribute("listeProfs", facade.getProfesseurs());
				request.setAttribute("listeMatieres", facade.getMatieres());
				request.setAttribute("listeSalles", facade.getSalles());
				request.setAttribute("listeCours", facade.getCours());
				request.getRequestDispatcher("html/admin-seance.jsp").forward(request,response);
				break;
				
			case "addFil":
				String nomFil = request.getParameter("nomFil");
				facade.ajoutFiliere(nomFil);
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.getRequestDispatcher("html/admin-filiere.jsp").forward(request,response);
				break;
				
			case "suprFil":
				String idFiliere = request.getParameter("idFiliere");
				facade.suprFiliere(Integer.parseInt(idFiliere));
				request.setAttribute("listeFilieres", facade.getFilieres());
				request.getRequestDispatcher("html/admin-filiere.jsp").forward(request,response);
				break;

			default :
				
				break;
		}
	}

}
