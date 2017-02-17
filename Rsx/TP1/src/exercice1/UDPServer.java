package exercice1;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.ServerSocket;


public class UDPServer {

	public static void main(String[] args) throws Exception {
		
		/*
		 * Numero du port saisi dans les parametres
		 */
		int host = Integer.parseInt(args[0]);
		
		/*
		 *Création de la socket 
		 */
		DatagramSocket socket = new DatagramSocket(host);
		byte[] receiveData, sendData;
		
		/*
		 * boucle infinie qui gère la reception des paquets
		 */
		while(true){
			receiveData = new byte[1024];
			sendData = new byte[1024];
			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
			socket.receive(receivePacket);
			String sentence =new String (receivePacket.getData());
			System.out.println("Received : " + sentence);
			InetAddress IPAddress = receivePacket.getAddress();
			int port = receivePacket.getPort();
			String upperSentence = sentence.toUpperCase();
			sendData = upperSentence.getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, IPAddress,port);
			socket.send(sendPacket);
			System.out.println("Response : "+ upperSentence);
			
		}
		
	} 
	
}
