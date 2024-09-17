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
            <input
              type="text"
              class="input-field"
              name="nom"
              placeholder="Nom"
              required
            />
          </div>
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              name="prenom"
              placeholder="PrÃ©nom"
              required
            />
          </div>
          
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              name="idLog"
              placeholder="Identifiant de connexion"
              required
            />
          </div>
          
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              name="mdp"
              placeholder="Mot de passe"
              required
            />
          </div>

          <div class="input-box">
            <select class="role-field" id="role-select" name="filiere" required>
              <option value="choice-message" selected disabled hidden>FiliÃ¨re</option>
              <% Collection<Filiere> listeFilieres = (Collection<Filiere>) request.getAttribute("listeFilieres");
              for (Filiere f : listeFilieres) { %>
              <option value=<%=f.getId() %>><%=f.getNom() %></option>
              <% } %>
            </select>
        </div>

          <div class="add-submit">
            <button class="add-btn" id="add_room-btn"><i class="material-icons">add_circle</i></button>
            <input type="hidden" name="op" value="addStudent"/>
          </div>
        </div>

        <div class="students">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Filière</th>
                <th>Absences</th>
                <th></th>
              </tr>
            </thead>
            <% Collection<Etudiant> listeEtus = (Collection<Etudiant>) request.getAttribute("listeEtus");
            int numEtu = 1;
            for (Etudiant e : listeEtus) { %>
              <tbody>
                <tr>
                  <td><%=numEtu%></td>
                  <td><%=e.getNom()%></td>
                  <td><%=e.getPrenom()%></td>
                  <td><%=e.getFiliere()%></td>
                  <td><%=e.getAbsences().size()*1.75%>h</td>
                  <td>
                    <button class="remove-btn" id="add_room-btn" name="idEtu" value=<%=e.getId()%>><i class="material-icons">do_not_disturb_on</i></button>
                    <input type="hidden" name="op" value="suprStudent">
                  </td>
                </tr>
              </tbody>
              <% numEtu ++ ;
            } %>
          </table>
        
        </div>
        
      </form>

    </div>

  </body>
</html>
