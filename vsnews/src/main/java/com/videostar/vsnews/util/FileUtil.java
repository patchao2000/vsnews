package com.videostar.vsnews.util;

/**
 * FileUtil
 *
 * Created by patchao2000 on 14-8-29.
 */
public class FileUtil {

    public static String getFileNameExt(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >-1) && (dot < (filename.length() - 1))) {
                return filename.substring(dot + 1);
            }
        }

        return filename;
    }
}
