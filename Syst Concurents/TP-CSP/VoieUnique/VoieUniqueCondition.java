// Time-stamp: <06 jui 2023 11:59 Philippe Queinnec>

import CSP.*;

/** Réalisation de la voie unique avec des canaux JCSP. */
/* Version avec condition d'acceptation */
public class VoieUniqueCondition implements VoieUnique {

    enum ChannelId { EntrerNS, EntrerSN, Sortir };
    
    private Channel<ChannelId> entrerNS;
    private Channel<ChannelId> entrerSN;
    private Channel<ChannelId> sortir;
    
    public VoieUniqueCondition() {
        this.entrerNS = new Channel<>(ChannelId.EntrerNS);
        this.entrerSN = new Channel<>(ChannelId.EntrerSN);
        this.sortir = new Channel<>(ChannelId.Sortir);
        (new Thread(new Scheduler())).start();
    }

    public void entrer(Sens sens) {
        System.out.println("In  entrer " + sens);
        switch (sens) {
          case NS:
            entrerNS.write(true);
            break;
          case SN:
            entrerSN.write(true);
            break;
        }
        System.out.println("Out entrer " + sens);
    }

    public void sortir(Sens sens) {
        System.out.println("In  sortir " + sens);
        sortir.write(true);
        System.out.println("Out sortir " + sens);
    }

    public String nomStrategie () {
        return "Condition";
    }

    /****************************************************************/

    class Scheduler implements Runnable {
        private int nbNS = 0;
        private int nbSN = 0;
        private final int CAPACITE = 3; 
        public void run() {
            var gentrerNS = new GuardedChannel<>(entrerNS, () -> (nbSN == 0 && nbNS < CAPACITE));
            var gentrerSN = new GuardedChannel<>(entrerSN, () -> (nbNS == 0 && nbSN < CAPACITE));
            var gsortir = new GuardedChannel<>(sortir, Predicate::True);
            var alt = new Alternative<>(gentrerNS, gentrerSN, gsortir);
            while (true) {
                switch (alt.select()) {
                    case EntrerNS:
                        entrerNS.read();
                        nbNS += 1;
                        break;
                    case EntrerSN:
                        entrerSN.read();
                        nbSN += 1;
                        break;
                    case Sortir:
                        sortir.read();
                        if (nbNS > 0) {
                            nbNS -= 1;
                        } else {
                            nbSN -= 1;
                        }
                        break;
                }
            }
        }
    } // class Scheduler
}

