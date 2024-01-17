import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;

public class SFicheImpl extends UnicastRemoteObject implements SFiche {
    protected String nom;
    protected String email;

    public SFicheImpl(String nom, String email) throws RemoteException {
        this.nom = nom;
        this.email = email;
    }

    public String getNom() {
        return this.nom;
    }

    public String getEmail() {
        return this.email;
    }
}
