package exercice3;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.util.Scanner;


public class UDPClientThread {
	
	/*
	 * Pseudo de l'utilisateur
	 */
	private String utilisateur;

	
	/*
	 * cette methode gère l'envoi de paquets au sein d'un thread
	 */
	public void send(String adresse,int numeroPort) throws Exception{
		
		
		int port = numeroPort;
		//BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		
		/*
		 * Création de la socket Multicast sur le numero de port
		 */
		MulticastSocket socket = new MulticastSocket(port);
		
		/*
		 * Initialisation de l'adresse IP sur l'adresse passée en paramètre
		 */
		InetAddress IPAddress = InetAddress.getByName(adresse);
		
		/*
		 * La socket rejoint le groupe de l'adresse IP
		 */
		socket.joinGroup(IPAddress);
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];
		while (true) {
			/*
			 * Utilisation du scanner pour recuperer les messages de l'utilisateur
			 */
			Scanner in = new Scanner(System.in);
			
			/*
			 * Message qui va etre envoyer dans le chat
			 */
			String sentence = "[" + this.utilisateur +"] :"+ in.nextLine();
			
			if (sentence.equals("/exit"))
				break;
			
			sendData = sentence.getBytes();

			/* Envoi */

			DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress, port);
			socket.send(sendPacket);

			/*
			 * Le client attend maintenant une réponse du serveur, qui lui
			 * permettra de savoir si le message a bien été transmis ou s'il y a
			 * eu une potentielle erreur.
			 */

			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
			socket.receive(receivePacket);
			String modifiedSentence = new String(receivePacket.getData());
		}

		/* Pour finir, on ferme TOUJOURS la connexion établi avec le socket. */

		socket.leaveGroup(IPAddress);
		socket.close();

	}
	
	public void setUser(String utilisateur) {
		this.utilisateur = utilisateur;
	}
}
