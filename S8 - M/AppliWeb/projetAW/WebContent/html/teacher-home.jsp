<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/teacher-home.css" />
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
            <a href="./login.html">Se déconnecter</a>
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
      <form action="ServProf" method="post">
        <h2 class="title">Vos cours</h2>

        <div class="absences">
          <table>
            <thead>
              <tr>
                <th>Date</th>
                <th>Heure</th>
                <th>Matière</th>
                <th>Appel</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <% Collection<Cours> listeCours = (Collection<Cours>) request.getAttribute("listeCours");
                for (Cours c : listeCours) { 
                  Creneau cr = c.getCreneau(); 
                  Matiere m = c.getMatiere(); %>
                  <td><%=cr.getDate()%></td>
                  <td><%=cr.getHeure()%></td>
                  <td><%=m.getNom()%></td>
                  <td>
                    <% if (!c.isAppelOk()) { %>
                      <button class="call-btn" id="add_room-btn" name="idCours" value=<%=c.getId()%>>
                      <i class="material-icons">contactless</i>
                      </button>
                      <input type="hidden" name="op" value="appelCours">
                    <% } else { %>
                      <i class="material-icons">check</i>
                    <% } %>
                    
                  </td>
                <% } %>
              </tr>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </body>
</html>
