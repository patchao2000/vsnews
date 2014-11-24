package com.videostar.vsnews.web.system;

import com.videostar.vsnews.entity.news.NewsLog;

/**
 * LogDetail
 *
 * Created by patchao2000 on 14/11/24.
 */
public class LogDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsLog log;
    private String userName;

    public NewsLog getLog() {
        return log;
    }

    public void setLog(NewsLog log) {
        this.log = log;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
