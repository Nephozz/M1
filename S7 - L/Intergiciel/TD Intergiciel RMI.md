# TD Intergiciel RMI
#TODO 

---
## Rappels 
#notes

RPC = RMI en Java

Talon = Stub

client -> Stub
server -> Skeleton


- 1ère étape faire une interface 
	*ex : Hello.java*

- Implémentation server, on hérite de UnicastRemoteObject, constructeur -> throws RemoteExecption

- Après naming 

coté client

- registre et on fait un lookup et on récupère l'objet (appel de méthode)


Java RMI passage d'un obj en paramètre 
l'exécution d'un obj client sera exécuter côté client (i.e. le client à le skeleton de son obj)

---
# Problème 1

Côté Serveur
```java
public interface MOM extends java.rmi.Remote {
	public void publish(String topic, Message message)
		throws java.rmi.RemoteException;
		
	public void subscribe(String topic, Callback cb)
		throws java.rmi.RemoteException;
}
```

```java
Import java.rmi.*;
Import java.rmi.server.UnicastObject;

public class MOMImpl extends UnicastRemoteObject implements MOM {

	Callback cbs = new ArrayList<Callback>();
	HashMap<String> topics = new HashMap;

	//Construteur
	public MOMImpl(HashMap<String> topics) throws java.rmi.RemoteException {
		this.topics = topics;
	}

	public void publish(String topic, Message message) throws java.rmi.RemoteException {
		for i in this.cbs
			i.notify()
	}

	public void subscribe(String topic, Callback cb) throws java.rmi.RemoteException {
		this.cbs.add(cb);
	}

	public void main(String args[]) {
	
	}
}
```

Côté Client

```java
public interface Callback extends java.rmi.Remote {
	public void notify()
		throws java.rmi.RemoteException;
}

public class Callback extends UnicastRemoteObject {
	public void notify() {
		SystemOut.println("message"); 
	}
}

public class Subscriber extends UnicastRemoteObject  implements Callback {
	public Subscriber()
}
```

# Problème  2

Deamon.java
```java
public interface Deamon extends java.rmi.Remote {
	public void save(Remote object) throws java.rmi.RemoteException;
}

public class DeamonImpl extends UnicastRemoteObject implements Deamon {

	HashMap<Remote> RMIRegistry;
	
	public void DeamonImpl() throws java.rmi.RemoteException {
		this.RMIRegistry = new HashMap<Remote>;
	}

	public void save(Remote object) throws java.rmi.RemoteException {
		this.RMIRegistry.add(object);
	}
}
```

---
[[0. Sommaire Intergiciel|<- retour]]

#TD/IG 