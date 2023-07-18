package it.cnr.igg.isotopedb.conf;

import java.io.InputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Conf {
	public static Properties readProperties() throws IOException {
		String confFile = "/etc/isotope/conf.properties";
		try (InputStream input = new FileInputStream(confFile)) {
			Properties prop = new Properties();
			prop.load(input);
			return prop;
		} catch (IOException ex) {
			ex.printStackTrace();
			throw ex;
		}
	}
}