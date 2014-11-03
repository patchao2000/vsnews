package com.videostar.vsnews.util;

import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

/**
 * SambaUtil
 *
 * Created by patchao2000 on 14/11/3.
 */
public class SambaUtil {
    private static Logger logger = LoggerFactory.getLogger(SambaUtil.class);

    public static List<String> getFiles() {

        List<String> files = new ArrayList<String>();

        try {
            NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication("", ConfigXmlReader.getSambaUserName(),
                    ConfigXmlReader.getSambaPassword());

            SmbFile smbFile = new SmbFile(ConfigXmlReader.getSambaPath(), auth);
            for (String file : smbFile.list()) {
                if (!file.startsWith(".")) {
                    files.add(file);
                }
            }
        }
        catch (MalformedURLException e) {
            e.printStackTrace();
        }
        catch (SmbException e) {
            e.printStackTrace();
        }

        return files;
    }
}
