import java.net.*;

import javax.sound.midi.Track;

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