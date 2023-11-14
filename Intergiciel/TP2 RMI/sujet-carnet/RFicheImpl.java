import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;

public class RFicheImpl extends UnicastRemoteObject implements RFiche {
    protected String nom;
    protected String email;

    public RFicheImpl(String nom, String email) throws RemoteException {
        this.nom = nom;
        this.email = email;
    }

    public String getNom() throws RemoteException {
        return this.nom;
    }

    public String getEmail() throws RemoteException {
        return this.email;
    }
}
