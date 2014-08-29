package com.videostar.vsnews.web.news;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * FileMeta
 *
 * Created by patchao2000 on 14-8-26.
 */
//ignore "bytes" when return json format
@JsonIgnoreProperties({"bytes"})
public class FileMeta {

    private String fileName;
    private String fileSize;
    private String fileType;

    private byte[] bytes;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public byte[] getBytes() {
        return bytes;
    }

    public void setBytes(byte[] bytes) {
        this.bytes = bytes;
    }
}
