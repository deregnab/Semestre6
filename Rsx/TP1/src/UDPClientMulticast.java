import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;


public class UDPClientMulticast {
	public static void main(String[] args) throws Exception{
		
		
		int port = 7654;
		//BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		MulticastSocket socket = new MulticastSocket(port);
		InetAddress IPAddress = InetAddress.getByName("224.0.0.1");
		socket.joinGroup(IPAddress);
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];
		//String sentence = reader.readLine();
		String sentence = args[0];
		sendData=sentence.getBytes();
		DatagramPacket sendPacket = new DatagramPacket(sendData,sendData.length,IPAddress,port);
		socket.send(sendPacket);
		DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
		socket.receive(receivePacket);
		String modifiedSentence = new String (receivePacket.getData());
		System.out.println("From Server : "+ modifiedSentence);
		socket.leaveGroup(IPAddress);
		socket.close();
	}
}
