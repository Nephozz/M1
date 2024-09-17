package entities;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.persistence.*;

@Entity
public class Etudiant {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String nom;
	
	private String prenom;
	
	private String mdp;
	
	private String idLog;
	
	@ManyToOne
	private Filiere filiere;
	
	private ArrayList<Cours> absences; // <id_cours>
	
	public Etudiant() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public Filiere getFiliere() {
		return filiere;
	}

	public void setFiliere(Filiere filiere) {
		this.filiere = filiere;
	}

	public ArrayList<Cours> getAbsences() {
		return absences;
	}

	public void setAbsences(ArrayList<Cours> absences) {
		this.absences = absences;
	}

	public void addAbscence(Cours cours) {
		this.absences.add(cours);
	}

	public String getMdp() {
		return mdp;
	}

	public void setMdp(String mdp) {
		this.mdp = mdp;
	}

	public String getIdLog() {
		return idLog;
	}

	public void setIdLog(String idLog) {
		this.idLog = idLog;
	}

}
