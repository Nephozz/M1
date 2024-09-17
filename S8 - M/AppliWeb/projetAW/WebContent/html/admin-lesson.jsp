<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-lesson.css" />
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
      <form action="ServAdmin" method="post">
        <div class="add-lesson">
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              name="nomMat"
              placeholder="Nom de la matière"
              required
            />
          </div>
          
          <div class="input-box">
	        <select class="role-field" id="role-select" name="responsable" required>
	          <option value="choice-message" selected disabled hidden>
	            Responsable
	          </option>
	          <% Collection<Professeur> listeProfs = (Collection<Professeur>) request.getAttribute("listeProfs");
              for (Professeur p : listeProfs) { %>
	          <option value=<%=p.getId() %>><%=p.getNom() + " " + p.getPrenom() %></option>
              <% } %>
	        </select>
	      </div>

          <div class="check-boxes">
            <% Collection<Filiere> listeFilieres = (Collection<Filiere>) request.getAttribute("listeFilieres");
            for (Filiere f : listeFilieres) { %>
            <div class="checkbox-choice">
              <input
                type="checkbox"
                class="input-field"
                name="filiere"
                value=<%=f.getId() %>
              />
              <a><%=f.getNom() %></a>
            </div>
            <% } %>
            
          </div>

          <div class="add-submit">
            <button class="add-btn" id="add_room-btn">
              <i class="material-icons">add_circle</i>
            </button>
            <input type="hidden" name="op" value="addMat" />
          </div>
        </div>
      </form>
    </div>
  </body>
</html>
