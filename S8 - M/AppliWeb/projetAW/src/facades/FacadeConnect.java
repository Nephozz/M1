package facades;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import entities.Administrateur;
import entities.Cours;
import entities.Etudiant;
import entities.Filiere;
import entities.Professeur;

@Singleton
public class FacadeConnect {
	
	private static boolean init = false;
	
	@PersistenceContext
	private EntityManager em;
	
	public ArrayList<String> isRegistered(String idLog, String mdp, String role) {
		if (!init) {
			em.persist(new Administrateur("admin", "admin", "admin", "admin"));
		}
		ArrayList<String> listInfo = new ArrayList<String>();
		boolean found = false;
		try {
			switch (role) {
				case "prof":
					TypedQuery<Professeur> reqProf = em.createQuery("select p from Professeur p",Professeur.class);
					Iterator<Professeur> profs = reqProf.getResultList().iterator();
					Professeur p;
					while (profs.hasNext() && !found) {
						p = profs.next();
						if (idLog.equals(p.getIdLog()) && mdp.equals(p.getMdp())) {
							listInfo.add(idLog);
							listInfo.add(p.getNom());
							listInfo.add(p.getPrenom());
							listInfo.add(String.valueOf(p.getId()));
							found = true;
						}
					}
					break;
				
				case "etudiant":
					TypedQuery<Etudiant> reqEtu = em.createQuery("select e from Etudiant e",Etudiant.class);
					Iterator<Etudiant> etus = reqEtu.getResultList().iterator();
					Etudiant e;
					while (etus.hasNext() && !found) {
						e = etus.next();
						if (idLog.equals(e.getIdLog()) && mdp.equals(e.getMdp())) {
							listInfo.add(idLog);
							listInfo.add(e.getNom());
							listInfo.add(e.getPrenom());
							listInfo.add(String.valueOf(e.getId()));
							found = true;
						}
					}
					break;
				
				case "admin":
					TypedQuery<Administrateur> reqAdmin = em.createQuery("select a from Administrateur a",Administrateur.class);
					Iterator<Administrateur> admins = reqAdmin.getResultList().iterator();
					Administrateur a;
					while (admins.hasNext() && !found) {
						a = admins.next();
						if (idLog.equals(a.getIdLog()) && mdp.equals(a.getMdp())) {
							listInfo.add(idLog);
							listInfo.add(a.getNom());
							listInfo.add(a.getPrenom());
							listInfo.add(String.valueOf(a.getId()));
							found = true;
						}
					}
					break;	
				
				default:
					break;
			}
			if (!found) {
				listInfo.add("Votre identifiant ou votre mot de passe est incorrect.");
			}
		} catch (Exception e) {
			//listInfo.add(e.toString());
		} 
		return listInfo;
		
	}
	
	public Collection<Cours> getAbsences(int id) {
		Etudiant e = em.find(Etudiant.class, id);
		return e.getAbsences();
	}

	public Collection<Cours> getCours(int id) {
		Professeur p = em.find(Professeur.class, id);
		return p.getListCours();
	}
	
	public Collection<Integer> getSalles() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		list.add(1);
		list.add(2);
		return list;
	}

}
