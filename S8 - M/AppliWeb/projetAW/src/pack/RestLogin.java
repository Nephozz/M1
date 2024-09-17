package pack;


import javax.ejb.EJB;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import facades.FacadeConnect;

import java.util.ArrayList;

@Path("connect")
public class RestLogin {

    @EJB
    private FacadeConnect facade;

    @GET
    @Path("all")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStatus() {
        return Response.ok(facade.getSalles()).build();
    }

    @POST
    @Path("/login")
    public Response login(@FormParam("role") String role, @FormParam("name") String idLog, @FormParam("mdp") String mdp) {
        ArrayList<String> listInfo = facade.isRegistered(idLog, mdp, role);
        if (listInfo.size() == 3) {
            return Response.ok()
                    .entity(new UserResponse(listInfo.get(0), listInfo.get(1), listInfo.get(2), role))
                    .build();
        } else {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity(listInfo.get(0))
                    .build();
        }
    }

    public static class UserResponse {
        public String idLog;
        public String nom;
        public String prenom;
        public String role;

        public UserResponse(String idLog, String nom, String prenom, String role) {
            this.idLog = idLog;
            this.nom = nom;
            this.prenom = prenom;
            this.role = role;
        }
    }
}