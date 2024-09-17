package facades;

import java.awt.List;
import java.util.ArrayList;
import java.util.Collection;

import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import entities.Cours;
import entities.Creneau;
import entities.Etudiant;
import entities.Filiere;
import entities.Matiere;
import entities.Professeur;
import entities.Salle;
import exception.UnauthorizedException;

@Singleton
public class FacadeAdmin {

	@PersistenceContext
	private EntityManager em;
	
	public FacadeAdmin() {}


	public void ajoutProfesseur(String idLog, String nom, String prenom, String mdp) {
		em.persist(new Professeur(idLog, nom, prenom, mdp));
	}

	public void suprProfesseur(int idProf) {
		Professeur p = em.find(Professeur.class, idProf);
		if (p!=null) {
			em.remove(p);
		}
	}

	public Collection<Professeur> getProfesseurs() {
		return em.createQuery("select p from Professeur p", Professeur.class).getResultList();
	}



	public Collection<Cours> getAbsenceCours(int idEtu) {
		// TODO Auto-generated method stub
		return null;
	}



	public Integer getAbscenceCour(int idEtu, int idCours) {
		// TODO Auto-generated method stub
		return null;
	}



	public void ajoutEtudiant(String nom, String prenom, int idFiliere, String mdp, String idLog) {
		Filiere f = em.find(Filiere.class, idFiliere);
		Etudiant e = new Etudiant();
		e.setFiliere(f);
		e.setNom(nom);
		e.setPrenom(prenom);
		e.setMdp(mdp);
		e.setIdLog(idLog);
		em.persist(e);
	}

	public Collection<Etudiant> getEtudiants() {
		return em.createQuery("select e from Etudiant e", Etudiant.class).getResultList();
	}


	public void ajoutSalle(String numero, int capacite) {
		em.persist(new Salle(numero,capacite));
	}

	public void suprEtudiant(int idEtu) {
		Etudiant e = em.find(Etudiant.class, idEtu);
		if (e!=null) {
			em.remove(e);
		}
	}
	
	public Collection<Salle> getSalles() {
		return em.createQuery("select s from Salle s",Salle.class).getResultList();
	}
	
	public void suprSalle(int idSalle) {
		Salle s = em.find(Salle.class, idSalle);
		if (s!=null) {
			em.remove(s);
		}
	}


	public Collection<Cours> getCours() {
		return em.createQuery("select c from Cours c",Cours.class).getResultList();
	}


	public Collection<Filiere> getFilieres() {
		return em.createQuery("select f from Filiere f",Filiere.class).getResultList();
	}


	public Collection<Matiere> getMatieres() {
		return em.createQuery("select m from Matiere m",Matiere.class).getResultList();
	}


	public void ajoutCours(String creneau, int idProf, int idMat, int idSalle) {
		Salle s = em.find(Salle.class, idSalle);
		Professeur p = em.find(Professeur.class, idProf);
		Matiere m = em.find(Matiere.class, idMat);
		Creneau c = null;
		switch (creneau) {
			case "c1":
				c = new Creneau(0, 0, 0, 8, 0);
				break;
			case "c2":
				c = new Creneau(0, 0, 0, 10, 15);
				break;
			case "c3":
				c = new Creneau(0, 0, 0, 14, 0);
				break;
			case "c4":
				c = new Creneau(0, 0, 0, 16, 15);
				break;
			default:
				break;
		}
		Cours cours = new Cours();
		cours.setCreneau(c);
		cours.setMatiere(m);
		cours.setProfesseur(p);
		cours.setSalle(s);
		em.persist(cours);
	}


	public void suprCours(int idCours) {
		Cours c = em.find(Cours.class, idCours);
		if (c!=null) {
			em.remove(c);
		}
	}


	public void ajoutMatiere(String nomMat, int idProfRespo, String[] idFilieres) {
		Matiere mat = new Matiere();
		mat.setNom(nomMat);
		mat.setResponsable(em.find(Professeur.class, idProfRespo));
		Collection<Filiere> colFil = new ArrayList<Filiere>();
		for (int i = 0; i < idFilieres.length; i++) {
			colFil.add(em.find(Filiere.class, Integer.parseInt(idFilieres[i])));
		}
		mat.setListeFilieres(colFil);
		em.persist(mat);
	}


	public void suprMatiere(int idMat) {
		Matiere m = em.find(Matiere.class, idMat);
		if (m!=null) {
			em.remove(m);
		}
	}


	public void ajoutFiliere(String nomFil) {
		Filiere f = new Filiere();
		f.setNom(nomFil);
		em.persist(f);
		
	}


	public void suprFiliere(int idFiliere) {
		Filiere f = em.find(Filiere.class, idFiliere);
		if (f!=null) {
			em.remove(f);
		}
		
	}
	
}
