<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-teachers.css" />
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
        <div class="add-teacher">
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

          <div class="add-submit">
            <button class="add-btn" id="add_room-btn"><i class="material-icons">add_circle</i></button>
            <input type="hidden" name="op" value="addTeacher"/>
          </div>
        </div>

        <div class="teachers">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>PrÃ©nom</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <% Collection<Professeur> listeProfs = (Collection<Professeur>) request.getAttribute("listeProfs");
              int numProf = 1;
              for (Professeur p : listeProfs) { %>
                <tr>
                  <td><%=numProf%></td>
                  <td><%=p.getNom()%></td>
                  <td><%=p.getPrenom()%></td>
                  <td>
                    <button class="remove-btn" id="add_room-btn" name="idProf" value=<%=p.getId() %>><i class="material-icons">do_not_disturb_on</i></button>
                    <input type="hidden" name="op" value="suprTeacher">
                  </td>
                </tr>
              <% numProf++ ; } %>
            </tbody>
          </table>
        </div>
      </form>
    </div>


  </body>
</html>
