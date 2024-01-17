// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioLecteur implements LectRed
{
    private int nR;
    private int nL;
    private int nbLecAtt;

    private Condition AccesLecture;
    private Condition AccesEcriture;

    private Lock mon;

    public LectRed_PrioLecteur() {
        this.mon = new ReentrantLock();
        this.AccesEcriture = mon.newCondition();
        this.AccesLecture = mon.newCondition();
    }

    public void demanderLecture() throws InterruptedException {
        mon.lock();
        if (nR != 0) {
            nbLecAtt++;
            AccesLecture.await();
            nbLecAtt--;
        }
        nL++;
        AccesLecture.signal();
        mon.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        mon.lock();
        nL--;
        if (nbLecAtt > 0) {
            AccesLecture.signal();
        } else {
            AccesEcriture.signal();
        }
        mon.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        mon.lock();
        while (nL != 0 || nR != 0 || nbLecAtt != 0) {
            AccesEcriture.await();
        }
        nR++;
        mon.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        mon.lock();
        nR--;
        if (nR != 0) {
            AccesLecture.signal();
        }
        mon.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
