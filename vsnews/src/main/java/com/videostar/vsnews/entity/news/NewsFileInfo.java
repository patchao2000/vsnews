package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * NewsFileInfo
 *
 * Created by patchao2000 on 14-9-19.
 */
@Entity
@Table(name = "NEWS_TOPIC_FILES")
public class NewsFileInfo extends IdEntity implements Serializable {
    public static final int TYPE_VIDEO_MATERIAL = 0;
    public static final int TYPE_AUDIO_MATERIAL = 1;
    public static final int TYPE_DOCUMENT = 2;
    public static final int TYPE_OTHER = 3;

    int type;

    Date addedTime;

    String filePath;

    String userId;

    String lengthTC;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getAddedTime() {
        return addedTime;
    }

    public void setAddedTime(Date addedTime) {
        this.addedTime = addedTime;
    }

    @Column
    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    @Column
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Column
    public String getLengthTC() {
        return lengthTC;
    }

    public void setLengthTC(String lengthTC) {
        this.lengthTC = lengthTC;
    }
}
