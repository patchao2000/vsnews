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
    public static final int TYPE_VIDEO_MATERIAL = 0;
    public static final int TYPE_AUDIO_MATERIAL = 1;
    public static final int TYPE_DOCUMENT = 2;
    public static final int TYPE_OTHER = 3;

    int type;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    Date addedTime;

    String filePath;

    String userId;

    String lengthTC;

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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getLengthTC() {
        return lengthTC;
    }

    public void setLengthTC(String lengthTC) {
        this.lengthTC = lengthTC;
    }
}
