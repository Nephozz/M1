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
		ObjectInputStream sois = new ObjectInputStream(server.getInputStream());
		document[this.server_id] = (String)sois.readObject();

		this.server.close();
	}

	public static void main(String args[]) {
		for (i = 0; i < nb; i++) {
			s = new Socket(hosts[i], ports[i]);
			new UserClient(i).start();
		}
	}
}