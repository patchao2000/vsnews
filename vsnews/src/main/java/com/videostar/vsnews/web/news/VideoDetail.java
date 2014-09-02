package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsVideo;

/**
 * VideoDetail
 *
 * Created by patchao2000 on 14-9-2.
 */
public class VideoDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsVideo video;

    private String uploadUserName;
    private String columnName;

    public NewsVideo getVideo() {
        return video;
    }

    public void setVideo(NewsVideo video) {
        this.video = video;
    }

    public String getUploadUserName() {
        return uploadUserName;
    }

    public void setUploadUserName(String uploadUserName) {
        this.uploadUserName = uploadUserName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }
}
