package entities;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.*;

@Entity
public class Matiere {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String nom;
	
	@ManyToOne
	private Professeur responsable;
	
	@OneToMany(mappedBy="matiere", fetch=FetchType.EAGER)
	private Collection<Cours> listeCours;
	
	@ManyToMany
	private Collection<Filiere> listeFilieres;
	
	public Matiere() {}

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

	public Professeur getResponsable() {
		return responsable;
	}

	public void setResponsable(Professeur responsable) {
		this.responsable = responsable;
	}

	public Collection<Cours> getListeCours() {
		return listeCours;
	}

	public void setListeCours(ArrayList<Cours> listeCours) {
		this.listeCours = listeCours;
	}

	public Collection<Filiere> getListeFilieres() {
		return listeFilieres;
	}

	public void setListeFilieres(Collection<Filiere> listeFilieres) {
		this.listeFilieres = listeFilieres;
	}

	public void setListeCours(Collection<Cours> listeCours) {
		this.listeCours = listeCours;
	}
	
	

}
