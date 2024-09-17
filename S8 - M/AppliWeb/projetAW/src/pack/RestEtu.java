package pack;


import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

@Path("/etu")
public class RestEtu {

    @Context
    private UriInfo context;

    public RestEtu() {
        // TODO Auto-generated constructor stub
    }

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response getIt() {
        String output = "Served at: " + context.getAbsolutePath().toString();
        return Response.ok(output).build();
    }
}
