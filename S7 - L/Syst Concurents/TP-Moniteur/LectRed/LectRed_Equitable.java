import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;


public class LectRed_Equitable implements LectRed {
    private int nR;
    private int nL;
    public enum Mode {
        PIOLECT, PRIORED
    }
    private int nbLecAtt;
    private int nbRedAtt;
    private Mode mode;

    private Condition AccesLecture;
    private Condition AccesEcriture;

    private Lock mon;

    public LectRed_Equitable() {
        this.mon = new ReentrantLock();
        this.AccesEcriture = mon.newCondition();
        this.AccesLecture = mon.newCondition();
        this.mode = Mode.PRIORED;
    }

    public void demanderLecture() throws InterruptedException {
        mon.lock();
        while (nR != 0 || (mode == Mode.PRIORED && nbRedAtt != 0)) {
            nbLecAtt++;
            AccesLecture.await();
            nbLecAtt--;
        }
        nL++;
        mon.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        mon.lock();
        nL--;
        mode = Mode.PRIORED;
        if (nbRedAtt > 0) {
            AccesEcriture.signal();
        } 
        mon.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        mon.lock();
        while (nR !=0 || nL != 0 || (mode == Mode.PIOLECT && nbLecAtt != 0)) {
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
        mode = Mode.PIOLECT;
        if (nbLecAtt > 0) {
            AccesLecture.signalAll();
        } else {
            AccesEcriture.signal();
        }
        mon.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Equitable.";
    }
}
