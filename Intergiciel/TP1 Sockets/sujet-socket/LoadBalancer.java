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