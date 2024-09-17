<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "entities.*,exception.*,facades.*,servlets.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <title>Projet AppliWeb</title>
  </head>
  <body>
    <header>
    <%String nom = (String) request.getAttribute("nom");
    String prenom = (String) request.getAttribute("prenom");
    String idLog = (String) request.getAttribute("idLog");%>
      <input type="hidden" name="nom" value=<%=nom%>>
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

    <div class="buttons-box">
    	<form action="ServAdmin" method="get">
    		  <div class="button">
    		    <button type="submit" class="submit-btn" id="submit" name="opc" value="salles">Salles</button>
		      </div>
		      <div class="button">
		        <button type="submit" class="submit-btn" id="submit" name="opc" value="prof">Professeurs</button>
		      </div>
		      <div class="button">
		        <button type="submit" class="submit-btn" id="submit" name="opc" value="fil">Filieres</button>
		      </div>
		      <div class="button">
		        <button type="submit" class="submit-btn" id="submit" name="opc" value="mat">Matières</button>
		      </div>
		      <div class="button">
		        <button type="submit" class="submit-btn" id="submit" name="opc" value="cours">Cours</button>
		      </div>
		      <div class="button">
		        <button type="submit" class="submit-btn" id="submit" name="opc" value="etu">Etudiants</button>
		      </div>
    	</form>
    </div>

  </body>
</html>
