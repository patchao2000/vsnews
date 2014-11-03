package com.videostar.vsnews.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.File;
import java.io.FileNotFoundException;

/**
 * ConfigXmlReader
 *
 * Created by patchao2000 on 14-8-26.
 */
public class ConfigXmlReader extends DefaultHandler {

    private static Logger logger = LoggerFactory.getLogger(ConfigXmlReader.class);

    private static StringBuffer currentValue = new StringBuffer();

    private final static String configFileName = "vsnews.cfg.xml";

    private static String nginxUrl = "http://192.168.1.1/";
    private static String fileUploadDir = "/Temp/";
    private static Integer maxUploadSize = 1024 * 1024;

    private static String sambaPath = "smb://127.0.0.1/Samba/";
    private static String sambaUserName = "test";
    private static String sambaPassword = "test";


    private static Boolean initParsed = false;

    public ConfigXmlReader() {
        super();
    }

    private static String getWebAppsDir() {
        try {
            String resoucePath = ConfigXmlReader.class.getResource("/").getPath();
            String webappsDir = (new File(resoucePath, "../../")).getCanonicalPath();

            logger.debug("webapps dir: {}", webappsDir);

            return webappsDir;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void parseConfig() {
        if (!initParsed) {
            String cfgFile = getWebAppsDir() + "/" + configFileName;
            try {
                SAXParserFactory sf = SAXParserFactory.newInstance();
                SAXParser sp = sf.newSAXParser();
                ConfigXmlReader reader = new ConfigXmlReader();
                sp.parse(new InputSource(cfgFile), reader);
                initParsed = true;
            } catch (FileNotFoundException e) {
                logger.error("cfg file {} not found!", cfgFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        currentValue.delete(0, currentValue.length());
    }

    public void characters(char[] ch, int start, int length) throws SAXException {
        currentValue.append(ch, start, length);
    }

    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (qName.toUpperCase().equals("NGINXURL")) {
            nginxUrl = currentValue.toString().trim();
//            logger.debug("nginxUrl set: {}", nginxUrl);
        }
        else if (qName.toUpperCase().equals("FILEUPLOADDIR")) {
            fileUploadDir = currentValue.toString().trim();
//            logger.debug("fileUploadDir set: {}", fileUploadDir);
        }
        else if (qName.toUpperCase().equals("MAXUPLOADSIZE")) {
            maxUploadSize = Integer.parseInt(currentValue.toString().trim());
//            logger.debug("maxUploadSize set: {}", maxUploadSize);
        }
        else if (qName.toUpperCase().equals("SAMBAPATH")) {
            sambaPath = currentValue.toString().trim();
//            logger.debug("sambaPath set: {}", sambaPath);
        }
        else if (qName.toUpperCase().equals("SAMBAUSERNAME")) {
            sambaUserName = currentValue.toString().trim();
//            logger.debug("sambaUserName set: {}", sambaUserName);
        }
        else if (qName.toUpperCase().equals("SAMBAPASSWORD")) {
            sambaPassword = currentValue.toString().trim();
//            logger.debug("sambaPassword set: {}", sambaPassword);
        }
    }

    public static String getNginxUrl() {
        return nginxUrl;
    }

    public static String getFileUploadDir() {
        return fileUploadDir;
    }

    public static Integer getMaxUploadSize() {
        return maxUploadSize;
    }

    public static String getSambaPath() {
        return sambaPath;
    }

    public static String getSambaUserName() {
        return sambaUserName;
    }

    public static String getSambaPassword() {
        return sambaPassword;
    }
}
