package exercice3;

import java.util.Scanner;

public class Tchat{

	public static void main(String args[]) {
		Thread t_receive = new Thread(new Runnable() {

			@Override
			public void run() {
				UDPServerThread receive = new UDPServerThread();
				try {
					receive.receive(args[0], Integer.parseInt(args[1]));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});

		Thread t_send = new Thread(new Runnable() {

			@Override
			public void run() {
				UDPClientThread send = new UDPClientThread();
				System.out.print("Entrez votre pseudo : ");
				Scanner in = new Scanner(System.in);
				send.setUser(in.nextLine());

				try {
					send.send(args[0], Integer.parseInt(args[1]));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		});

		t_receive.start();
		t_send.start();
	}
}
