package com.videostar.vsnews.entity.news;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

/**
 * NewsFileInfo
 *
 * Created by patchao2000 on 14-9-19.
 */
@Embeddable
public class NewsFileInfo {
    @Temporal(TemporalType.TIMESTAMP)
    @Column
    Date addedTime;

    String filePath;

    String userId;

    public Date getAddedTime() {
        return addedTime;
    }

    public void setAddedTime(Date addedTime) {
        this.addedTime = addedTime;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
