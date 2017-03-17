package data;

public class TriData {

	private byte [] identifiant = new byte[2];
	private byte [] parametre = new byte[2];

	private byte [] qdCount = new byte[2];
	
	private byte [] anCount = new byte[2];
	private byte [] nsCount = new byte [2];
	private byte [] arCount = new byte [2];
	
	private byte [] msg;
	
	public TriData (byte [] donnees) {
		for (int i = 0 ; i < 2  ; i++) {
			identifiant[i] = donnees[i];
		}
		
		for (int i = 0 ; i < 2 ; i++) {
			parametre[i] = donnees[i+2];
		}
		
		for (int i = 0 ; i < 2 ; i++) {
			qdCount[i] = donnees[i+4];
		}
		
		for (int i = 0 ; i < 2 ; i++) {
			anCount[i] = donnees[i+6];
		}
		
		for (int i = 0; i < 2 ; i++) {
			nsCount[i] = donnees[i+8];
		}
		
		for (int i = 0; i < 2 ; i++) {
			arCount[i] = donnees[i+10];
		}
		msg = new byte [donnees.length-12];
		for (int i = 12 ; i < donnees.length ; i++) {
			msg[i-12] = donnees[i];
		}
	}
	
	/*-------------String's Realm----------------------*/

	public static String bytesToHexaString(byte[] bytes) {
		String rep = "";
		
		for (byte b : bytes) {
			if (b >= 0 && b < 16)
				rep += "0";
			rep += Integer.toHexString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	public static String bytesToBinaryString(byte[] bytes) {
		String rep = "";
		
		for (byte b : bytes) {
			if (b >= 0 && b < 16)
				rep += "0";
			rep += Integer.toBinaryString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	
	public String getDataStringBinary () {
		String rep = "Affichage du paquet\n";
		
		rep += "Identifiant : "+ TriData.bytesToBinaryString(this.identifiant)+"\n";
		rep += "Paramètre : "+ TriData.bytesToBinaryString(this.parametre)+"\n";
		
		rep += "QDCount : "+ TriData.bytesToBinaryString(this.qdCount)+"\n";
		rep += "AnCount : "+ TriData.bytesToBinaryString(this.anCount)+"\n";
		rep += "NSCount : "+ TriData.bytesToBinaryString(this.nsCount)+"\n";
		rep += "ARCount : "+ TriData.bytesToBinaryString(this.arCount)+"\n";
		
		rep += "Message : "+ TriData.bytesToBinaryString(this.msg)+"\n";
		return rep;
	}
	
	public String getDataStringHex () {
		String rep = "Affichage du paquet\n";
		
		rep += "Identifiant : "+ TriData.bytesToHexaString(this.identifiant)+"\n";
		rep += "Paramètre : "+ TriData.bytesToHexaString(this.parametre)+"\n";
		
		rep += "QDCount : "+ TriData.bytesToHexaString(this.qdCount)+"\n";
		rep += "AnCount : "+ TriData.bytesToHexaString(this.anCount)+"\n";
		rep += "NSCount : "+ TriData.bytesToHexaString(this.nsCount)+"\n";
		rep += "ARCount : "+ TriData.bytesToHexaString(this.arCount)+"\n";
		
		rep += "Message : "+ TriData.bytesToHexaString(this.msg)+"\n";
		return rep;
	}
	
    public static String fromHexString(String hex) {
    	
        StringBuilder output = new StringBuilder();
        for (int i = 0; i < hex.length(); i+=2) {
            String str = hex.substring(i, i+2);
            output.append((char)Integer.parseInt(str, 16));
        }
        return new String(output);
    }
    /*-------Analyse du message---------------------*/
    
    public static String getWWW (byte [] msg) {
    	String rep = "Le message : \n";
    	Integer tmp;
    	int cpt = 0;
    	Integer separator = new Integer (msg[0]);
    	int i = 0;
    	while (i < msg.length && cpt != 3) {
    		tmp = new Integer (msg[i]);
    		while (!separator.equals(0) && cpt != 3) {
    			//rep+=TriData.fromHexString(tmp+"");
    			System.out.print(tmp);
    			separator = new Integer(separator.intValue()-1);
    			i++;
    		}
    		separator = new Integer(msg[i]);
    		cpt++;
    		i++;
    	}
    	return rep;
    }
    
	/*-------Getter's Realm-------------------------*/
	
	public byte [] getId () {
		return this.identifiant;
	}
	
	public byte [] getParametre () {
		return this.parametre;
	}
	public byte [] getQdCount () {
		return this.qdCount;
	}
	
	public byte [] getAnCount () {
		return this.anCount;
	}
	
	public byte [] getNsCount () {
		return this.nsCount;
	}
	
	public byte [] getArCount () {
		return this.arCount;
	}
	
	public byte []getMessage () {
		return this.msg;
	}
}
