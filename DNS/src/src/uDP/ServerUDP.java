package uDP;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;

public class ServerUDP {
	public final static int port = 1887;
	
	@SuppressWarnings("resource")
	public static void main(String[] args) {
		
		try {
			
			/*On ouvre avec DatagramSocket*/
			DatagramSocket recup = new DatagramSocket(port);
			
			System.out.println("Lancement du Serveur. Port : "+port);
			while (true) {
				
				/*Initialisation des objets en relation avec les paquets*/
				byte[] buffer = new byte[8200];
				DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
				
				/*Récupération du packet*/
				recup.receive(packet);
				
				
				/*Récupération du contenu du paquet*/
				String str = new String(packet.getData());
				System.out.println(""+packet.getAddress()
					+ " (port : "+ packet.getPort() + ") : "+str+"");
				
				/*Réinitialisation de la taille du packet*/
				packet.setLength(buffer.length);
				
				/*Petite pause*/
			}
		} catch (SocketException e) {
			e.printStackTrace();
		}  catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
}
