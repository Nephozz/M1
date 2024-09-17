package facades;

import java.util.Collection;

import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import entities.Cours;
import entities.Creneau;
import entities.Etudiant;
import entities.Matiere;
import entities.Professeur;
import entities.Salle;
import exception.UnauthorizedException;

@Singleton
public class FacadeProf {
	
	@PersistenceContext
	private EntityManager em;
	
	public FacadeProf() {}

	public void appelEtudiants(Collection<Etudiant> etudiants, Creneau creneau) {
		// TODO Auto-generated method stub
		
	}

}
