<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-rooms.css" />
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
      <div class="add-salles">
        <form action="ServAdmin" method="post">
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              name="nomSalle"
              placeholder="Nom de la salle"
              required
            />
          </div>
          <div class="input-box">
            <input
              type="text"
              name="capaciteSalle"
              class="input-field"
              placeholder="CapacitÃ©"
              required
            />
          </div>
          
          <div class="add-submit">
            <button class="add-btn" id="add_room-btn"><i class="material-icons">add_circle</i></button>
            <input type="hidden" name="op" value="addSalle">
          </div>
        </form>
      </div>

      <form action="ServAdmin" method="post">

        <div class="salles">
          <% Collection<Salle> listeSalle = (Collection<Salle>) request.getAttribute("listeSalle");
          for (Salle s : listeSalle) { %>
  
            <div class="salle-container">
              <div class="salle">
                <div class="salle-header"><%=s.getNumero() %></div>
                <div class="salle-main">
                  <i class="material-icons">person</i>
                  <div class="capacity"><%=s.getCapacite() %></div>
                </div>
              </div> 
              <div class="remove-submit">
                <button class="remove-btn" id="add_room-btn" name="idSalle" value=<%=s.getId()%>><i class="material-icons">do_not_disturb_on</i></button>
                <input type="hidden" name="op" value="rmvSalle"> 
              </div>
            </div>
  
          <% } %>
  
        </div>

      </form>

      
    </div>

    <!-- <footer>
      <p>&copy; RÃ©alisÃ© par : S. Afker, M. Roure, T. BocandÃ© et B. SchlÃ¶gel.</p>
    </footer> -->
  </body>
</html>
