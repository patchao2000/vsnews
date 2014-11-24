package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsArticle;

/**
 * ArticleDetail
 *
 * Created by zhaopeng on 2014/7/29.
 */
public class ArticleDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsArticle article;
    private String userName;
    private String columnName;
    private String plainContent;
    private Boolean sendUp;

    public NewsArticle getArticle() {
        return article;
    }

    public void setArticle(NewsArticle article) {
        this.article = article;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getPlainContent() {
        return plainContent;
    }

    public void setPlainContent(String plainContent) {
        this.plainContent = plainContent;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Boolean getSendUp() {
        return sendUp;
    }

    public void setSendUp(Boolean sendUp) {
        this.sendUp = sendUp;
    }
}
