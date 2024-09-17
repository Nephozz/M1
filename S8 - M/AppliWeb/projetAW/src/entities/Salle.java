package entities;

import javax.persistence.*;

@Entity
public class Salle {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String numero;

	private int capacite;
	
	@OneToOne(mappedBy="salle")
	private Cours cours;
	
	public Salle() {
		
	}
	
	public Salle(String numero, int capacite) {
		this.numero = numero;
		this.capacite = capacite;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public int getCapacite() {
		return capacite;
	}

	public void setCapacite(int capacite) {
		this.capacite = capacite;
	}

	public Cours getCours() {
		return cours;
	}

	public void setCours(Cours cours) {
		this.cours = cours;
	}

}
