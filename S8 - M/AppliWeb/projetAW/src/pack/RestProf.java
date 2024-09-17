package pack;


import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

@Path("/prof")
public class RestProf {

    @Context
    private UriInfo context;

    public RestProf() {
        // TODO Auto-generated constructor stub
    }

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response getIt() {
        String output = "Served at: " + context.getAbsolutePath().toString();
        return Response.ok(output).build();
    }

    @POST
    @Produces(MediaType.TEXT_PLAIN)
    public Response postIt() {
        // Réutilise la méthode GET pour la réponse POST
        return getIt();
    }
}
