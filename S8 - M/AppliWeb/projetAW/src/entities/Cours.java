package entities;

import java.util.Collection;

import javax.persistence.*;

@Entity
public class Cours {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@OneToOne
	private Salle salle;
	
	@ManyToOne
	private	Matiere matiere;
	
	@ManyToOne
	private Professeur professeur;	
	
	@OneToOne
	private Creneau creneau;

	private boolean appelOk;
	
	public Cours() {
		this.appelOk = false;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Salle getSalle() {
		return salle;
	}

	public void setSalle(Salle salle) {
		this.salle = salle;
	}

	public Matiere getMatiere() {
		return matiere;
	}

	public void setMatiere(Matiere matiere) {
		this.matiere = matiere;
	}

	public Professeur getProfesseur() {
		return professeur;
	}

	public void setProfesseur(Professeur professeur) {
		this.professeur = professeur;
	}

	public Creneau getCreneau() {
		return creneau;
	}

	public void setCreneau(Creneau creneau) {
		this.creneau = creneau;
	}

	public Collection<Filiere> getFilieres() {
		return this.matiere.getListeFilieres();
	}
	
	public String getNom() {
		return this.matiere.getNom();
	}

	public boolean isAppelOk() {
		return appelOk;
	}

	public void setAppelOk(boolean appelOk) {
		this.appelOk = appelOk;
	}
}
