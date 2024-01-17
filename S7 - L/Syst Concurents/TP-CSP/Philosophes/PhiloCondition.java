// Time-stamp: <06 jui 2023 11:57 Philippe Queinnec>

import CSP.*;

/** Solution au problème des philosophes.
 * Approche service avec 2 canaux par philosophe (demander/libérer).
 * Il faut 2 canaux par philosophes car la condition n'est pas la même pour les deux cas.
 */
public class PhiloCondition implements StrategiePhilo {

    private int nbPhilosophes;

    /** Un id de canal est un couple <mode (entrer/sortir), numéro>. */
    //private record ChannelId(boolean entrer, int num) {}
    private class ChannelId {
        public boolean entrer;
        public int num;
        public ChannelId(boolean entrer, int num) { this.entrer = entrer; this.num = num; }
    }
    /** Pour chaque philosophe, canal pour demander à entrer / à sortir. */
    private Channel<ChannelId> entrer[];
    private Channel<ChannelId> sortir[];
    
    /****************************************************************/

    public PhiloCondition (int nbPhilosophes) {
        this.nbPhilosophes = nbPhilosophes;
        this.entrer = new Channel[nbPhilosophes];
        this.sortir = new Channel[nbPhilosophes];
        for (int i = 0; i < nbPhilosophes; i++) {
            entrer[i] = new Channel<>(new ChannelId(true, i));
            sortir[i] = new Channel<>(new ChannelId(false, i));
        }
        new Thread(new Scheduler()).start();
    }

    public void demanderFourchettes (int no)
    {
        entrer[no].write(true);
        IHMPhilo.poser(Main.FourchetteGauche(no), EtatFourchette.AssietteDroite);
        IHMPhilo.poser(Main.FourchetteDroite(no), EtatFourchette.AssietteGauche);
    }

    public void libererFourchettes (int no)
    {
        IHMPhilo.poser(Main.FourchetteGauche(no), EtatFourchette.Table);
        IHMPhilo.poser(Main.FourchetteDroite(no), EtatFourchette.Table);
        sortir[no].write(true);
    }

    public String nom() {
        return "Famine possible";
    }

    /****************************************************************/

    class Scheduler implements Runnable {
        public void run() {
            /* Il faut construire un tableau de 2*nbphilo GuardedChannels, avec les canaux de demande d'entrée et leur condition (aucun des voisins ne mange), et les canaux de demande de sortie (condition = Predicate::True). */
            EtatPhilosophe etat[] = new EtatPhilosophe[nbPhilosophes];
            @SuppressWarnings("unchecked")
            GuardedChannel<ChannelId> gchan[] = new GuardedChannel[2 * nbPhilosophes];
            for (int i = 0; i < nbPhilosophes; i++) {
                final int j = i;
                gchan[i] = new GuardedChannel<>(entrer[j], () -> ((etat[Main.PhiloDroite(j)] != EtatPhilosophe.Mange) 
                    && (etat[Main.PhiloGauche(j)] != EtatPhilosophe.Mange)));
            }
            for (int i = nbPhilosophes; i < 2*nbPhilosophes; i++) {
                final int j = i - nbPhilosophes;
                gchan[i] = new GuardedChannel<>(sortir[j], Predicate::True);
            }
            var alt = new Alternative<>(gchan);

            while (true) {
                ChannelId ci = alt.select();
                if (ci.entrer) {
                    entrer[ci.num].read();
                    etat[ci.num] = EtatPhilosophe.Mange;
                } else {
                    sortir[ci.num].read();
                    etat[ci.num] = EtatPhilosophe.Pense;
                }
            }
        }
    } // class Scheduler

}

