package exercice2;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;

public class UDPServerMulticast {

	public static void main(String[] args) throws Exception {

		/*
		 * initialisation au port 7654 (consigne)
		 */
		int host = 7654;
		
		/*
		 * Création de la socket multicast
		 */
		MulticastSocket socket = new MulticastSocket(host);
		
		/*
		 * Initialisation de l'adresse IP à 224.0.0.1 (consigne)
		 */
		socket.joinGroup(InetAddress.getByName("224.0.0.1"));
		byte[] receiveData, sendData;
		
		/*
		 * boucle gérant la reception de message
		 */
		while (true) {
			receiveData = new byte[1024];
			sendData = new byte[1024];
			DatagramPacket receivePacket = new DatagramPacket(receiveData,
					receiveData.length);
			socket.receive(receivePacket);
			String sentence = new String(receivePacket.getData());
			System.out.println("["+receivePacket.getAddress()+"] :" + sentence);
			
		}

	}

}
