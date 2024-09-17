package entities;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.*;

@Entity
public class Professeur {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String nom;
	
	private String mdp;
	
	private String prenom;
	
	private String idLog;
	
	@OneToMany(mappedBy="responsable")
	private Collection<Matiere> listMatiere;
	
	@OneToMany(mappedBy="professeur")
	private Collection<Cours> listCours;
	
	public Professeur(String idLog, String nom, String prenom, String mdp) {
		this.idLog = idLog;
		this.nom = nom;
		this.prenom = prenom;
		this.mdp = mdp;
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

	public String getMdp() {
		return mdp;
	}

	public void setMdp(String mdp) {
		this.mdp = mdp;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getIdLog() {
		return idLog;
	}

	public void setIdLog(String idLog) {
		this.idLog = idLog;
	}

	public Collection<Matiere> getListMatiere() {
		return listMatiere;
	}

	public void setListMatiere(Collection<Matiere> listMatiere) {
		this.listMatiere = listMatiere;
	}

	public Collection<Cours> getListCours() {
		return listCours;
	}

	public void setListCours(Collection<Cours> listCours) {
		this.listCours = listCours;
	}
	
}
