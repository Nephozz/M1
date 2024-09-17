package entities;

import java.util.Collection;

import javax.persistence.*;

@Entity
public class Filiere {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String nom;
	
	@OneToMany(mappedBy="filiere")
	private Collection<Etudiant> etudiants;
	
	@ManyToMany(mappedBy="listeFilieres", fetch=FetchType.EAGER)
	private Collection<Matiere> listeMatieres;
	
	public Filiere() {
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

	public Collection<Etudiant> getEtudiants() {
		return etudiants;
	}

	public void setEtudiants(Collection<Etudiant> etudiants) {
		this.etudiants = etudiants;
	}

	public Collection<Matiere> getListeMatieres() {
		return listeMatieres;
	}

	public void setListeMatieres(Collection<Matiere> listeMatieres) {
		this.listeMatieres = listeMatieres;
	}

}
