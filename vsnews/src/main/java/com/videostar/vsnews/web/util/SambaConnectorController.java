package com.videostar.vsnews.web.util;

import com.videostar.vsnews.util.ConfigXmlReader;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * SambaConnectorController
 *
 * Created by patchao2000 on 14/12/5.
 */
@Controller
@RequestMapping(value = "/util/smb-conn")
public class SambaConnectorController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @RequestMapping(value = "get", method = {RequestMethod.POST, RequestMethod.GET}, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getFiles(@RequestBody Map<String, Object> map) {

        String preset = (String)map.get("preset");
        String dirMode = (String)map.get("dirmode");
        String dir = (String)map.get("dir");
        logger.debug("preset: {}   dir-mode: {}   dir: {}", preset, dirMode, dir);

        String html = "<ul class=\"jqueryFileTree\" style=\"display: none;\">";
        try {
            NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication("", ConfigXmlReader.getSambaUserName(),
                    ConfigXmlReader.getSambaPassword());

            SmbFile smbFile = new SmbFile("smb:" + dir, auth);
            SmbFile[] list = smbFile.listFiles();
            List<String> files = new ArrayList<String>();
            List<String> dirs = new ArrayList<String>();
            for (SmbFile subFile : list) {
                if (!subFile.getName().startsWith(".")) {
                    if (subFile.isDirectory()) {
                        dirs.add(subFile.getName());
                    } else {
                        files.add(subFile.getName());
                    }
                }
            }

            String[] sortDirs = dirs.toArray(new String[dirs.size()]);
            Arrays.sort(sortDirs, String.CASE_INSENSITIVE_ORDER);
            for (String file : sortDirs) {
                html += "<li class=\"directory collapsed\"><a href=\"#\" rel=\"" + dir + file + "/\">"
                        + file + "</a></li>";
            }

            String[] sortFiles = files.toArray(new String[files.size()]);
            Arrays.sort(sortFiles, String.CASE_INSENSITIVE_ORDER);
            for (String file : sortFiles) {
//                logger.debug("file: {}", file);
                int dotIndex = file.lastIndexOf('.');
                String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
                html += "<li class=\"file ext_" + ext + "\"><a href=\"#\" rel=\"" + dir + file + "\">"
                        + file + "</a></li>";
            }
        }
        catch (MalformedURLException e) {
            e.printStackTrace();
        }
        catch (SmbException e) {
            e.printStackTrace();
        }

        html += "</ul>";

        return html;
    }
}
