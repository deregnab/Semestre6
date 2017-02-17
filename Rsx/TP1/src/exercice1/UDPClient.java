package exercice1;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.SocketException;
import java.net.UnknownHostException;


public class UDPClient {

	
	public static void main(String[] args) throws Exception{
		//int port = 8080;
		
		/*
		 * Numero du port saisi dans les parametres
		 */
		int port = Integer.parseInt(args[1]);
		//BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		
		/*
		 *Création de la socket 
		 */
		DatagramSocket socket = new DatagramSocket();
		
		/*
		 * initialisation de l'adresse à localhost
		 */
		InetAddress IPAddress = InetAddress.getByName("localhost");
		
		/*
		 * création de deux tableaux pour les données envoyées et reçues
		 */
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];
		//String sentence = reader.readLine();
		
		/*
		 * message à envoyer saisi dans les paramètres 
		 */
		String sentence = args[2];
		
		
		
		sendData=sentence.getBytes();
		
		/*
		 * création et envoi du paquet 
		 */
		DatagramPacket sendPacket = new DatagramPacket(sendData,sendData.length,IPAddress,port);
		socket.send(sendPacket);
		
		/*
		 * création du paquet de reception et reception des données dans la socket
		 */
		DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
		socket.receive(receivePacket);
		
		/*
		 * retour d'un message 
		 */
		String modifiedSentence = new String (receivePacket.getData());
		System.out.println("From Server : "+ modifiedSentence);
		socket.close();
	}
}
