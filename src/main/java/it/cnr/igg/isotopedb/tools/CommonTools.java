package it.cnr.igg.isotopedb.tools;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CommonTools {

	public CommonTools() {

	}

	public static String Sha256(String in) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(in.getBytes());
		byte[] digest = md.digest();
		return CommonTools.byteArray2HexString(digest);
	}

	public static String byteArray2HexString(byte[] a) {
		StringBuilder sb = new StringBuilder(a.length * 2);
		for (byte b : a)
			sb.append(String.format("%02x", b));
		return sb.toString();
	}

}
