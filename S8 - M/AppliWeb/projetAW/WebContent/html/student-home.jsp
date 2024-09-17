<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-home.css" />
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

      <h2 class="title">Liste des absences</h2>

      <div class="absences">
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Heure</th>
              <th>Matière</th>
            </tr>
          </thead>
          <tbody>
            <% Collection<Cours> listeAbsences = (Collection<Cours>) request.getAttribute("listeAbsences");
            for (Cours c : listeAbsences) { 
              Creneau cr = c.getCreneau(); 
              Matiere m = c.getMatiere(); %>
	            <tr>
	              <td><%=cr.getDate()%></td>
	              <td><%=cr.getHeure()%></td>
	              <td><%=m.getNom()%></td>
	            </tr>
	          <% }; %>
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
