import java.rmi.*;
import java.rmi.registry.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;

public class CarnetImpl extends UnicastRemoteObject implements Carnet {
    protected HashMap<String, RFiche> carnet;
    protected int id;
    protected static String nom;

    public CarnetImpl(int id) throws RemoteException {
        this.carnet = new HashMap<String, RFiche>();
        this.id = id;
        nom = "Carnet" + this.id;
    }

    public String getNom() {
        return nom;
    }

    @Override
    public void Ajouter(SFiche sf) throws RemoteException {
        RFiche rf = new RFicheImpl(sf.getNom(), sf.getEmail());
        this.carnet.put(sf.getNom(), rf);

        System.out.println(sf.getNom() + " ajouté !");
    }

    @Override
    public RFiche Consulter(String n, boolean forward) throws RemoteException {
        RFiche rf = this.carnet.get(n);

        if (rf != null || !forward) {
            return this.carnet.get(n);
        } else {
            try {
                int next_id;
                if ((this.id+1)%2 == 0) {next_id = 2;} else {next_id = 1;}
                Carnet carnet2 = (Carnet)Naming.lookup("//localhost:4000/Carnet" + next_id);

                rf = carnet2.Consulter(n, false);

                return rf;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }
    }

    public static void main(String[] args) {
        int id = Integer.parseInt(args[0]);

        try {
            Registry registry = LocateRegistry.createRegistry(4000);
        } catch (Exception e) {
            System.out.println("Port déjà enregistré");
        }
        try {
            Carnet carnet = new CarnetImpl(id);
            Naming.rebind("//localhost:4000/Carnet" + id, carnet);
            System.out.println(nom + " bound in registry.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
