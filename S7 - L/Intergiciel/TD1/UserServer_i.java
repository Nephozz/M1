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
			
			ObjectOutputStream coos = new ObjectOutputStream(client.getOutputStream());
			coos.writeObject(document[server_id]);

			client.close();
		}
	}
}