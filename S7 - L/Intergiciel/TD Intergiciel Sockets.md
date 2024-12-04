# TD Intergiciel Sockets
#TODO

---
## Rappels Cours
#notes 

socket => porte de sortie sur l'extérieur 

fd 0 1 2 => stdin stdout stdr

socket() -> crée une entrée dans la fd table 
bind() -> donne une addr et un port au socket (UDP)

TCP/UDP -> voir cours [[Internet]]
UDP pas fiable
TCP, connect() et accept() => Server Side soit processus lourd (multirpogrammé) création de nouveau processus  soit léger avec des threads 

package java.net
- InetAddress
- Socket
- ServerSocket

new Socket -> socket(), connect(), bind()

*javap -c pour decompiler des .class*

server les sockets sont sur le même port sinon la machine est surchargée

passage d'objet à bytes par serialization/deserialization (pas de socket, thread, ie ce qui est liée à la machine)

---
## Problème 1

host[] -> IP/nom des machines

HTTP : 200 = OK (404 = NOT FOUND)

le serveur web est sur le port 8080

```java
public class LB extends Threads {
	... //Cf sujet
	static String hosts[] = {"host1", "host2"};
	static int ports[] = {8081,8082};
	static int nbHosts = 2;
	static Random rand = new Random();
	static Socket client;


	public LB(Socket s) {
		client = s;
	} 

	public void run() {
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
		cos.write(buffer, 0, nbLu);

		server.close();
		client.close();
	}
	
	public static void main(String args[]) {
		SeverSocket ss = new ServerSocket(8080);
		while(true) {
			Socket s = ss.accept();
			new LB(s).start();
		}
	}
}
```
---
## Problème 2
#TODO 

```java
public class UserClient extends Threads {
	final static String hosts[] = {"host1", "host2", "host3"};
	final static int ports[] = {8081,8082,8083};
	final static int nb = 3;
	static String document[] = new String[nb];
	  
	private int server_id;
	private Socket server;
	
	
	public UserClient(Socket s, int id) {
		this.server = s;
		this.server_id = id;
	}
	  
	public run() {
		ObjectInputStream sois = new ObjectInputStream(this.server.getInputStream());
		document[this.server_id] = (String)sois.readObject();
		  
		this.server.close();
	}
	
	public static void main(String args[]) {
		for (i = 0; i < nb; i++) {
			s = new Socket(hosts[i], ports[i]);
			new UserClient(s, i).start();
		}
	}
}

public class UserServer_i {
	final static int ports[] = {8081,8082,8083};
	final static int nb = 3;
	final static String document[] = new String[nb];
	  
	  
	document[0] = "Début du document.";
	document[1] = "Milieu du document.";
	document[2] = "Fin du document.";
	  
	public static void main(String args[]) {
		int server_id = Integer.parseInt(args[0]);
		  
		ServerSocket ss = new ServerSocket(port[server_id]);
		  
		while(true) {
			Socket client = ss.accept();
			ObjectOutputStream coos = new ObjectOutputStream( 
				client.getOutputStream()
			);
			coos.writeObject(document[server_id]);
			  
			client.close();
		}
	}
}
```

---
[[0. Sommaire Intergiciel|<- retour]]

#TD/IG  