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
		
		int port = Integer.parseInt(args[1]);
		//BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		DatagramSocket socket = new DatagramSocket();
		InetAddress IPAddress = InetAddress.getByName("localhost");
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];
		//String sentence = reader.readLine();
		String sentence = args[2];
		sendData=sentence.getBytes();
		DatagramPacket sendPacket = new DatagramPacket(sendData,sendData.length,IPAddress,port);
		socket.send(sendPacket);
		DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
		socket.receive(receivePacket);
		String modifiedSentence = new String (receivePacket.getData());
		System.out.println("From Server : "+ modifiedSentence);
		socket.close();
	}
}
