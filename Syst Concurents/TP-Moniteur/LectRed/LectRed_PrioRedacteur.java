// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioRedacteur implements LectRed
{
    private int nR;
    private int nL;
    private int nbRedAtt;

    private Condition AccesLecture;
    private Condition AccesEcriture;

    private Lock mon;

    public LectRed_PrioRedacteur() {
        this.mon = new ReentrantLock();
        this.AccesEcriture = mon.newCondition();
        this.AccesLecture = mon.newCondition();
    }

    public void demanderLecture() throws InterruptedException {
        mon.lock();
        if (nR != 0 || nbRedAtt != 0 ) {
            AccesLecture.await();
        }
        nL++;
        AccesLecture.signal();
        mon.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        mon.lock();
        nL--;
        if (nL == 0) {
            AccesEcriture.signal();
        }
        mon.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        mon.lock();
        while (nL != 0 || nR != 0 ) {
            nbRedAtt++;
            AccesEcriture.await();
            nbRedAtt--;
        }
        nR++;
        mon.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        mon.lock();
        nR--;
        if (nbRedAtt > 0) {
            AccesEcriture.signal();
        } else {
            AccesLecture.signal();
        }
        mon.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
