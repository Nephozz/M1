# Récap Intergiciel

## Sockets

```java
import java.net.*;
import java.util.Random;
import java.io.*;

public class LoadBalancer extends Thread {
	static String hosts[] = {"localhost", "localhost"};
	static int ports[] = {8081,8082};
	static int nbHosts = 2;
	static Random rand = new Random();
	static Socket client;

	public LoadBalancer(Socket s) {
		client = s;
	} 

	public void run() {
        try {
            int i = rand.nextInt(nbHosts);
            Socket server = new Socket(hosts[i], ports[i]);

            InputStream cis = client.getInputStream();
            OutputStream cos = client.getOutputStream();
            InputStream sis = server.getInputStream();
            OutputStream sos = server.getOutputStream();

            byte[] buffer = new byte[1024];

            int nbLu = cis.read(buffer);
            sos.write(buffer, 0, nbLu);
            // 0 est l'offet de lecture utile pour plusieur read
            nbLu = sis.read(buffer);
            while (nbLu > 0) {
                cos.write(buffer, 0, nbLu);
                nbLu = sis.read(buffer);
            }

            //Fermeture des streams
            cis.close();
            cos.close();
            sis.close();
            sos.close();

            //Fermeture des sockets
            server.close();
            client.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
	}
	
	public static void main(String args[]) {
        try {
            ServerSocket ss = new ServerSocket(8080);
            while(true) {
                Socket s = ss.accept();
                new LoadBalancer(s).start();
            }
        } catch (Exception e) {
            System.out.println("Error !");
        }
	}
}
```

```java
import java.net.*;
import java.io.*;

public class UserClient extends Thread {
	final static String hosts[] = {"localhost", "localhost", "localhost"};
	final static int ports[] = {8081,8082,8083};
	final static int nb = 3;
	static String document[] = new String[nb];
	  
	int fragment;
	
	
	public UserClient(int id) {
		this.fragment = id;
	}
	  
	public void run() {
		try {
			Socket server = new Socket(hosts[this.fragment], ports[this.fragment]);

			ObjectInputStream sois = new ObjectInputStream(server.getInputStream());
			ObjectOutputStream soos = new ObjectOutputStream(server.getOutputStream());

			soos.writeObject(this.fragment);
			document[this.fragment] = (String)sois.readObject();
			System.out.println(this.fragment + "bien reçu");

			soos.close();
			sois.close();
			server.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public static void main(String args[]) {
		try {
			Thread t[] = new Thread[nb];

			for (int i = 0; i < nb; i++) {
				t[i] = new UserClient(i);
				t[i].start();
			}

			for (int i = 0; i < nb; i++) {
				t[i].join();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

public class UserServer_i {
	final static int ports[] = {8081,8082,8083};
	final static int nb = 3;
	final static String document[] = new String[nb];

	public static void main(String args[]) {
        try {
            int server_id = Integer.parseInt(args[0]);
            
            document[0] = "Début du document.";
            document[1] = "Milieu du document.";
            document[2] = "Fin du document.";
            
            ServerSocket ss = new ServerSocket(ports[server_id]);
            
            while(true) {
                Socket client = ss.accept();
                ObjectOutputStream coos = new ObjectOutputStream(client.getOutputStream());
                ObjectInputStream cois = new ObjectInputStream(client.getInputStream());

                int fragment = (int)cois.readObject();
                coos.writeObject(document[fragment]);

                cois.close();
                coos.close();
                client.close();
            }
		} catch (Exception e) {
            e.printStackTrace();
        }
	}
}
```

## RMI

```java
import java.rmi.*;
import java.io.*;
import java.rmi.server.UnicastRemoteObject;

public interface RFiche extends Remote {
	public String getNom () throws RemoteException;
	public String getEmail () throws RemoteException;
}

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

public interface SFiche extends Serializable {

	public String getNom ();
	public String getEmail ();
}

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
```

```java
import java.rmi.*;
import java.rmi.registry.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;

public interface Carnet extends Remote {
	public void Ajouter(SFiche sf) throws RemoteException;
	public RFiche Consulter(String n, boolean forward) throws RemoteException;
}

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
```