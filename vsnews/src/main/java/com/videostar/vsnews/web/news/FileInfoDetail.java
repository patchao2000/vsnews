package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsFileInfo;

/**
 * FileInfoDetail
 *
 * Created by patchao2000 on 14-9-24.
 */
public class FileInfoDetail {

    private static final long serialVersionUID = 1L;

    private NewsFileInfo newsFileInfo;
    private String userName;
    private String fileTypeName;

    public NewsFileInfo getNewsFileInfo() {
        return newsFileInfo;
    }

    public void setNewsFileInfo(NewsFileInfo newsFileInfo) {
        this.newsFileInfo = newsFileInfo;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFileTypeName() {
        return fileTypeName;
    }

    public void setFileTypeName(String fileTypeName) {
        this.fileTypeName = fileTypeName;
    }
}
