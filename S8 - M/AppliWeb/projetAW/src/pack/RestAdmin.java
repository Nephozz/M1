package pack;


import facades.FacadeAdmin;

import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import entities.Cours;
import entities.Etudiant;
import entities.Filiere;
import entities.Professeur;
import entities.Salle;

import java.util.List;

@Path("/admin")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class RestAdmin {

    @EJB
    private FacadeAdmin facade;

    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/getAdmin")
    public String getAdmin() {
    	return "{\"message\":\"Admin endpoint\"}";
    }
    @GET
    @Path("/salles")
    public Response getSalles() {
        List<Salle> salles = (List<Salle>) facade.getSalles();
        return Response.ok(salles).build();
    }

    @GET
    @Path("/cours")
    public Response getCours() {
        List<Cours> cours = (List<Cours>) facade.getCours();
        return Response.ok(cours).build();
    }

    @GET
    @Path("/etudiants")
    public Response getEtudiants() {
        List<Etudiant> etudiants = (List<Etudiant>) facade.getEtudiants();
        List<Filiere> filieres = (List<Filiere>) facade.getFilieres();
        return Response.ok(new EtudiantsFilieresResponse(etudiants, filieres)).build();
    }

    @GET
    @Path("/professeurs")
    public Response getProfesseurs() {
        List<Professeur> professeurs = (List<Professeur>) facade.getProfesseurs();
        return Response.ok(professeurs).build();
    }

    @POST
    @Path("/addSalle")
    public Response addSalle(SalleRequest salleRequest) {
        facade.ajoutSalle(salleRequest.getNomSalle(), salleRequest.getCapaciteSalle());
        List<Salle> salles = (List<Salle>) facade.getSalles();
        return Response.ok(salles).build();
    }

    @DELETE
    @Path("/rmvSalle/{idSalle}")
    public Response removeSalle(@PathParam("idSalle") int idSalle) {
        facade.suprSalle(idSalle);
        List<Salle> salles = (List<Salle>) facade.getSalles();
        return Response.ok(salles).build();
    }

    @POST
    @Path("/addCours")
    public Response addCours(CoursRequest coursRequest) {
        facade.ajoutCours(coursRequest.getNomCours(), coursRequest.getFilieres());
        List<Cours> cours = (List<Cours>) facade.getCours();
        return Response.ok(cours).build();
    }

    @POST
    @Path("/addStudent")
    public Response addStudent(StudentRequest studentRequest) {
        facade.ajoutEtudiant(studentRequest.getNom(), studentRequest.getPrenom(), studentRequest.getFiliere());
        List<Etudiant> etudiants = (List<Etudiant>) facade.getEtudiants();
        List<Filiere> filieres = (List<Filiere>) facade.getFilieres();
        return Response.ok(new EtudiantsFilieresResponse(etudiants, filieres)).build();
    }

    @DELETE
    @Path("/suprStudent/{idEtu}")
    public Response removeStudent(@PathParam("idEtu") int idEtu) {
        facade.suprEtudiant(idEtu);
        List<Etudiant> etudiants = (List<Etudiant>) facade.getEtudiants();
        return Response.ok(etudiants).build();
    }

    @POST
    @Path("/addTeacher")
    public Response addTeacher(TeacherRequest teacherRequest) {
        facade.ajoutProfesseur(teacherRequest.getIdLog(), teacherRequest.getNom(), teacherRequest.getPrenom(), teacherRequest.getMdp());
        List<Professeur> professeurs = (List<Professeur>) facade.getProfesseurs();
        return Response.ok(professeurs).build();
    }

    @DELETE
    @Path("/suprTeacher/{idProf}")
    public Response removeTeacher(@PathParam("idProf") int idProf) {
        facade.suprProfesseur(idProf);
        List<Professeur> professeurs = (List<Professeur>) facade.getProfesseurs();
        return Response.ok(professeurs).build();
    }

    // Classes internes pour les requêtes et les réponses
    public static class SalleRequest {
        private String nomSalle;
        private int capaciteSalle;

        // Getters et setters
        public String getNomSalle() {
            return nomSalle;
        }

        public void setNomSalle(String nomSalle) {
            this.nomSalle = nomSalle;
        }

        public int getCapaciteSalle() {
            return capaciteSalle;
        }

        public void setCapaciteSalle(int capaciteSalle) {
            this.capaciteSalle = capaciteSalle;
        }
    }

    public static class CoursRequest {
        private String nomCours;
        private String[] filieres;

        // Getters et setters
        public String getNomCours() {
            return nomCours;
        }

        public void setNomCours(String nomCours) {
            this.nomCours = nomCours;
        }

        public String[] getFilieres() {
            return filieres;
        }

        public void setFilieres(String[] filieres) {
            this.filieres = filieres;
        }
    }

    public static class StudentRequest {
        private String nom;
        private String prenom;
        private String filiere;

        // Getters et setters
        public String getNom() {
            return nom;
        }

        public void setNom(String nom) {
            this.nom = nom;
        }

        public String getPrenom() {
            return prenom;
        }

        public void setPrenom(String prenom) {
            this.prenom = prenom;
        }

        public String getFiliere() {
            return filiere;
        }

        public void setFiliere(String filiere) {
            this.filiere = filiere;
        }
    }

    public static class TeacherRequest {
        private String idLog;
        private String nom;
        private String prenom;
        private String mdp;

        // Getters et setters
        public String getIdLog() {
            return idLog;
        }

        public void setIdLog(String idLog) {
            this.idLog = idLog;
        }

        public String getNom() {
            return nom;
        }

        public void setNom(String nom) {
            this.nom = nom;
        }

        public String getPrenom() {
            return prenom;
        }

        public void setPrenom(String prenom) {
            this.prenom = prenom;
        }

        public String getMdp() {
            return mdp;
        }

        public void setMdp(String mdp) {
            this.mdp = mdp;
        }
    }

    public static class EtudiantsFilieresResponse {
        private List<Etudiant> etudiants;
        private List<Filiere> filieres;

        public EtudiantsFilieresResponse(List<Etudiant> etudiants, List<Filiere> filieres) {
            this.etudiants = etudiants;
            this.filieres = filieres;
        }

        // Getters et setters
        public List<Etudiant> getEtudiants() {
            return etudiants;
        }

        public void setEtudiants(List<Etudiant> etudiants) {
            this.etudiants = etudiants;
        }

        public List<Filiere> getFilieres() {
            return filieres;
        }

        public void setFilieres(List<Filiere> filieres) {
            this.filieres = filieres;
        }
    }
}
