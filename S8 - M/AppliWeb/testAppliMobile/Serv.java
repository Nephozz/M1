import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/processNfcTag")
public class Serv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Définir le type de contenu de la réponse
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Récupérer les paramètres envoyés par le client
        String salleId = request.getParameter("salleId");
        String userId = request.getParameter("userId");

        // Logique de validation et traitement ici
        boolean validTag = isValidTag(salleId, userId);

        // Envoyer la réponse
        if (validTag) {
            out.write("{\"status\":\"success\", \"message\":\"Tag validé\"}");
        } else {
            out.write("{\"status\":\"error\", \"message\":\"Tag non validé\"}");
        }
    }

    // Exemples de validation (adapté à votre logique d'entreprise)
    private boolean isValidTag(String salleId, String userId) {
        // Remplacez cette logique par votre propre implémentation
        if (salleId != null && userId != null) {
            return true;
        }
        return false;
    }

    // Optionnel: Implémenter la méthode GET pour d'autres utilisations
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // Déléguer au traitement POST
    }
}
