package facades;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

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
public class FacadeEtu {
	
	@PersistenceContext
	private EntityManager em;
	
	public FacadeEtu() {}
	
	// Obtenir la liste des cours associé à l'id d'un étudiant où il était absent
	public Collection<Cours> getAbsenceCours(int id) {
		Etudiant e = em.find(Etudiant.class,id);
		ArrayList<Cours> listAbs = e.getAbsences();
		Collection<Cours> listCours = new ArrayList<Cours>();
		//for (Map.Entry<Integer,Integer> abs : listAbs.entrySet()) {
		//	int idCours = abs.getKey();
		//	Cours c = em.find(Cours.class, idCours);
		//	listCours.add(c);
		//}
		return listCours;
	}
	
	// Obtenir le nombre d'abscence d'un élève pour un cours
	public Integer getAbscenceCour(int idEtu, int idCours) {
		Etudiant e = em.find(Etudiant.class,idEtu);
		ArrayList<Cours> listAbs = e.getAbsences();
		//if (listAbs.get(idCours) != null) {
		//	return listAbs.get(idCours);
		//} else {
		//	return 0;
		//}
		return null;
	}
}
