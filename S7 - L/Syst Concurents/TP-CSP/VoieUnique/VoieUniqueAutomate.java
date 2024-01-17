// Time-stamp: <06 jui 2023 11:58 Philippe Queinnec>

import java.security.AllPermission;

import CSP.*;

/** Réalisation de la voie unique avec des canaux JCSP. */
/* Version par automate d'états */
public class VoieUniqueAutomate implements VoieUnique {

    enum ChannelId { EntrerNS, EntrerSN, Sortir };
    
    private Channel<ChannelId> entrerNS;
    private Channel<ChannelId> entrerSN;
    private Channel<ChannelId> sortir;
    
    public VoieUniqueAutomate() {
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

    public String nomStrategie() {
        return "Automate";
    }

    /****************************************************************/
    enum Etat {Libre, NS, SN};
    class Scheduler implements Runnable {
        private Etat etat = Etat.Libre;
        private int nbtrain = 0;
        public void run() {
            var altLibre = new Alternative<>(entrerNS, entrerSN);
            var altEnCoursNS = new Alternative<>(entrerNS,sortir);
            var altEnCoursSN = new Alternative<>(entrerSN,sortir);
            while (true) {
                if (etat == Etat.Libre) {
                    switch (altLibre.select()) {
                        case EntrerNS:
                            entrerNS.read();
                            etat = Etat.NS;
                            nbtrain = 1;
                            break;
                        case EntrerSN:
                            entrerSN.read();
                            etat = Etat.SN;
                            nbtrain = 1;
                            break;
                    }
                } else if (etat == Etat.NS) {
                    switch (altEnCoursNS.select()) {
                        case EntrerNS:
                            entrerNS.read();
                            nbtrain += 1;
                            break;
                        case Sortir:
                            sortir.read();
                            nbtrain -= 1;
                            if (nbtrain == 0) {etat = Etat.Libre;}
                            break;
                    }
                } else if (etat == Etat.SN) {
                    switch (altEnCoursSN.select()) {
                        case EntrerSN:
                            entrerSN.read();
                            nbtrain += 1;
                            break;
                        case Sortir:
                            sortir.read();
                            nbtrain -= 1;
                            if (nbtrain == 0) {etat = Etat.Libre;}
                            break;
                    }
                }
            }
        }
    } // class Scheduler
}

