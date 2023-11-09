import java.net.*;
import java.io.*;

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