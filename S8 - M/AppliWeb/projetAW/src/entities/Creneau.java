package entities;

import javax.persistence.*;

import java.time.*;

@Entity
public class Creneau {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private LocalDateTime seance;
	
	@OneToOne(mappedBy="creneau", fetch=FetchType.EAGER)
	private Cours cours;
	
	public Creneau(int annee, int mois, int jour, int heure, int minute) {
		LocalDate ld = LocalDate.of(annee, mois, jour);
		LocalTime lt = LocalTime.of(heure, minute);
		this.seance = LocalDateTime.of(ld, lt);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getSeance() {
		return seance;
	}

	public void setSeance(LocalDateTime seance) {
		this.seance = seance;
	}

	public Cours getCours() {
		return cours;
	}

	public void setCours(Cours cours) {
		this.cours = cours;
	}
	
	public String getDate() {
		return this.seance.getDayOfMonth() + "/" + this.seance.getMonthValue() + "/" + this.seance.getYear();
	}
	
	public String getHeure() {
		return this.seance.getHour() + "h " + this.seance.getMinute();
	}

}
