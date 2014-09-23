package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsStoryboard;

/**
 * StoryboardDetail
 *
 * Created by patchao2000 on 14-9-23.
 */
public class StoryboardDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsStoryboard storyboard;
    private String userName;
    private String columnName;

    public NewsStoryboard getStoryboard() {
        return storyboard;
    }

    public void setStoryboard(NewsStoryboard storyboard) {
        this.storyboard = storyboard;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }
}
