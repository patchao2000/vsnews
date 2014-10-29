package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsTopic;

/**
 * TopicDetail
 * 
 * Created by patchao2000 on 14-8-5.
 */
public class TopicDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsTopic Topic;
    private String userName;
    private String dispatcherName;
//    private String columnName;
//    private String plainTitle;
    private Boolean avFileReady;
    private Boolean articleReady;

    public NewsTopic getTopic() {
        return Topic;
    }

    public void setTopic(NewsTopic Topic) {
        this.Topic = Topic;
    }

//    public String getColumnName() {
//        return columnName;
//    }
//
//    public void setColumnName(String columnName) {
//        this.columnName = columnName;
//    }

//    public String getPlainTitle() {
//        return plainTitle;
//    }
//
//    public void setPlainTitle(String plainTitle) {
//        this.plainTitle = plainTitle;
//    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDispatcherName() {
        return dispatcherName;
    }

    public void setDispatcherName(String dispatcherName) {
        this.dispatcherName = dispatcherName;
    }

    public Boolean getAvFileReady() {
        return avFileReady;
    }

    public void setAvFileReady(Boolean avFileReady) {
        this.avFileReady = avFileReady;
    }

    public Boolean getArticleReady() {
        return articleReady;
    }

    public void setArticleReady(Boolean articleReady) {
        this.articleReady = articleReady;
    }
}

