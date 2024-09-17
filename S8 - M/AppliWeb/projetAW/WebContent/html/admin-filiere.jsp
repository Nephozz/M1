<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-filiere.css" />
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />
    <title>Projet AppliWeb</title>
  </head>
  <body>
    <header>
      <img class="logo" src="${pageContext.request.contextPath}/images/n7.png" />
      <input type="checkbox" id="nav_check" hidden />
      <div class="nav-message">
        <a>Samy</a>
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
              name="nomFil"
              placeholder="Nom de la filière"
              required
            />
          </div>

          <div class="add-submit">
            <button class="add-btn" id="add_room-btn"><i class="material-icons">add_circle</i></button>
            <input type="hidden" name="op" value="addFil" />
          </div>
        </div>

        <div class="filieres">
          <table>
            <thead>
              <tr>
                <th>Id</th>
                <th>Nom</th>
                <th></th>
              </tr>
            </thead>
              <tbody>
                <% Collection<Filiere> listeFilieres = (Collection<Filiere>) request.getAttribute("listeFilieres");
            	int numFil = 1;
            	for (Filiere f : listeFilieres) { %>
                <tr>
                  <td><%=numFil%></td>
                  <td><%=f.getNom() %></td>
                  <td>
                    <button class="remove-btn" id="add_room-btn" name="idFiliere" value=<%=f.getId()%> ><i class="material-icons">do_not_disturb_on</i></button>
                  	<input type="hidden" name="op" value="suprFil">
                  </td>
                </tr>
                <% numFil ++ ;
            	} %>
              </tbody>
          </table>
        
      </form>
    </div>

  </body>
</html>
