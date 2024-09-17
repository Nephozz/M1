<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-students.css" />
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />
    <title>Projet AppliWeb</title>
  </head>
  <body>
    <header>
      <%String nom = (String) request.getAttribute("nom");
      String prenom = (String) request.getAttribute("prenom");
      String idLog = (String) request.getAttribute("idLog");%>
      <img class="logo" src="${pageContext.request.contextPath}/images/n7.png" />
      <input type="checkbox" id="nav_check" hidden />
      <div class="nav-message">
        <a><%=prenom%> <%=nom %> - <%=idLog %></a>
      </div>
      <nav>
        <ul>
          <li>
            <a href="./admin-home.jsp" class="active">Accueil</a>
          </li>

          <li>
            <a href="./login.html">Se dÃ©connecter</a>
          </li>
        </ul>
      </nav>
      <label for="nav_check" class="hamburger">
        <div></div>
        <div></div>
        <div></div>
      </label>
    </header>

    <div class="main-container">
      <form action="ServAdmin" method="post">
        <div class="add-student">
          <div class="input-box">
            <input class="role-field" id="date-select" type="date" name="date" value="2024-01-01" required/>
          </div>
          <div class="input-box">
            <select class="role-field" id="role-select" name="creneau" required>
              <option value="choice-message" selected disabled hidden>CrÃ©neau</option>
              <option value="c1">8h-9h45</option>
              <option value="c2">10h15-12h</option>
              <option value="c3">14h-15h45</option>
              <option value="c4">16h15-18h</option>
            </select>
          </div>
          <div class="input-box">
            <select class="role-field" id="role-select" name="prof" required>
              <option value="choice-message" selected disabled hidden>Professeur</option>
              <% Collection<Professeur> listeProfs = (Collection<Professeur>) request.getAttribute("listeProfs");
              for (Professeur p : listeProfs) { %>
              <option value=<%=p.getId() %>><%=p.getNom() + " " + p.getPrenom() %></option>
              <% } %>
            </select>
          </div>

          <div class="input-box">
            <select class="role-field" id="role-select" name="matiere" required>
              <option value="choice-message" selected disabled hidden>MatiÃ¨re</option>
              <% Collection<Matiere> listeMatieres = (Collection<Matiere>) request.getAttribute("listeMatieres");
              for (Matiere m : listeMatieres) { %>
              <option value=<%=m.getId() %>><%=m.getNom() %></option>
              <% } %>
            </select>
          </div>

          <div class="input-box">
            <select class="role-field" id="role-select" name="salle" required>
              <option value="choice-message" selected disabled hidden>Salle</option>
              <% Collection<Salle> listeSalles = (Collection<Salle>) request.getAttribute("listeSalles");
              for (Salle s : listeSalles) { %>
              <option value=<%=s.getId() %>><%=s.getNumero() %></option>
              <% } %>
            </select>
        </div>

          <div class="add-submit">
            <button class="add-btn" id="add_room-btn"><i class="material-icons">add_circle</i></button>
            <input type="hidden" name="op" value="addSeance"/>
          </div>
        </div>

        <div class="teachers">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Cours</th>
                <th>Filières</th>
                <th></th>
              </tr>
            </thead>
            <tbody>

              <% Collection<Cours> listeCours = (Collection<Cours>) request.getAttribute("listeCours");
                int compteur = 1;
                for (Cours c : listeCours) { 
                  String filieresStr = "";
                  for (Filiere f : c.getFilieres()) { 
                    filieresStr = f.getNom() + " ";
                  } %>
                  <tr>
                    <td><%=compteur%></td>
                    <td><%=c.getNom()%></td> 
                    <td><%=filieresStr%></td>
                    <td>
                      <button class="remove-btn" id="add_room-btn" name="idCours" value=<%=c.getId()%>>
                        <i class="material-icons">do_not_disturb_on</i>
                      </button>
                      <input type="hidden" name="op" value="suprSeance">
                    </td>
                  </tr>
                  <% compteur ++;%>
                <% } %>


            </tbody>
          </table>
        </div>
   	  </form>
    </div>

  </body>
</html>
