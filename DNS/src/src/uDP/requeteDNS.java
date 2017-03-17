package uDP;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;

public class requeteDNS {

	public void sendMessage() {
		/*Création du message à envoyer*/
		String syntax = "";
		byte[]buffer = syntax.getBytes();
		
		try {
			/*Socket pour le client*/
			@SuppressWarnings("resource")
			DatagramSocket client = new DatagramSocket();
			
			/*Création du packet, avec l'adresse du serveur*/
			InetAddress adress = InetAddress.getByName("172.18.12.8");
			
			/*On crée un datagramme packet avec comme destination le DNS, dont le port est 53*/
			DatagramPacket packet = new DatagramPacket(buffer, buffer.length, adress, 53);
			
			packet.setData(buffer);
			
			client.send(packet);
			
			try {
				Thread.sleep(4000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			/*System.out.println("{Paquet envoyé} ");*/
			
		} catch (SocketException e) {
			e.printStackTrace();
		}  catch (IOException e) {
			e.printStackTrace();
		}	
		
	}
}
