import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;

/* Squelette d'une solution avec un moniteur.
 * Il manque le moniteur (verrou + variables conditions).
 */
public class PhiloMon implements StrategiePhilo {

    // État d'un philosophe : pense, mange, demande ?
    private EtatPhilosophe[] etat;
    private Lock mon;

    private Condition[] manger;


    /****************************************************************/

    public PhiloMon (int nbPhilosophes) {
        this.etat = new EtatPhilosophe[nbPhilosophes];
        this.mon = new ReentrantLock();
        this.manger = new Condition[nbPhilosophes];
        for (int i = 0; i < nbPhilosophes; i++) {
            etat[i] = EtatPhilosophe.Pense;
            manger[i] = mon.newCondition();
        }
        
    }

    public void demanderFourchettes (int no) throws InterruptedException
    {
        mon.lock();
        etat[no] = EtatPhilosophe.Demande;

        boolean voisinsMangent = etat[Main.PhiloGauche(no)] == EtatPhilosophe.Mange || etat[Main.PhiloDroite(no)] == EtatPhilosophe.Mange;
        while (voisinsMangent) {
            manger[no].await();
        }
        etat[no] = EtatPhilosophe.Mange;
        // j'ai les fourchette G et D
        IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.AssietteDroite);
        IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.AssietteGauche);
        mon.unlock();
    }

    public void libererFourchettes (int no)
    {   
        mon.lock();
        IHMPhilo.poser (Main.FourchetteGauche(no), EtatFourchette.Table);
        IHMPhilo.poser (Main.FourchetteDroite(no), EtatFourchette.Table);
        etat[no] = EtatPhilosophe.Pense;
        if (etat[Main.PhiloGauche(no)] == EtatPhilosophe.Demande 
        && etat[Main.PhiloGauche(Main.PhiloGauche(no))] != EtatPhilosophe.Mange) {
            manger[Main.PhiloGauche(no)].signal();
        }
        if (etat[Main.PhiloDroite(no)] == EtatPhilosophe.Demande 
        && etat[Main.PhiloDroite(Main.PhiloDroite(no))] != EtatPhilosophe.Mange) {
            manger[Main.PhiloDroite(no)].signal();
        }
        mon.unlock();
    }

    public String nom() {
        return "Moniteur";
    }

}

