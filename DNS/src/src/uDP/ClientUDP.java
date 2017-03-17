package uDP;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;

public class ClientUDP {

	
	public void sendMessage(String a, int port, String mes) {
		/*Création du message à envoyer*/
		byte[]buffer = mes.getBytes();
		
		try {
			/*Socket pour le client*/
			@SuppressWarnings("resource")
			DatagramSocket client = new DatagramSocket();
			
			/*Création du packet*/
			InetAddress adress = InetAddress.getByName(a);
			DatagramPacket packet = new DatagramPacket(buffer, buffer.length, adress, port);
			
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
	public static void main (String [] args) {
		ClientUDP c = new ClientUDP();
		c.sendMessage("127.0.0.1", 1887, "{Yann|Nnay} : "+args [0]);
	}
}