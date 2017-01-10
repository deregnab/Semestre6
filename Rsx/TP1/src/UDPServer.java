import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.ServerSocket;


public class UDPServer {

	public static void main(String[] args) throws Exception {
		
		//int host = 8080;
		int host = Integer.parseInt(args[0]);
		DatagramSocket socket = new DatagramSocket(host);
		byte[] receiveData, sendData;
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
