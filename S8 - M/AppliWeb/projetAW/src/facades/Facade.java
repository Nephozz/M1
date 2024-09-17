package facades;

import java.util.Collection;

import javax.ejb.Singleton;

import entities.*;
import exception.UnauthorizedException;

public interface Facade {

	// Méthodes pour l'admin
	
	public void ajoutEtudiant(String nom, String prenom, String filiere) throws UnauthorizedException;

	public void ajoutProfesseur(String nom, String prenom, Collection<Matiere> matieres, Collection<Cours> cours) throws UnauthorizedException;
	
	public void ajoutCours(Salle salle, Matiere matiere, Professeur prof) throws UnauthorizedException;
	
	public void ajoutSalle(String numero) throws UnauthorizedException;
	
	// Méthodes pour le prof
	
	public void appelEtudiants(Collection<Etudiant> etudiants, Creneau creneau) throws UnauthorizedException;
	
	// Méthodes pour l'étudiant
	
	public Collection<Cours> getAbsenceCours(int idEtu) throws UnauthorizedException;

	public Integer getAbscenceCour(int idEtu, int idCours) throws UnauthorizedException;
	
}
