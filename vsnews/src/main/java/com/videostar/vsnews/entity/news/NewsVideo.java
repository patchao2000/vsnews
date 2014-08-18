package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * NewsVideo
 *
 * Created by patchao2000 on 14-8-18.
 */
@Entity
@Table(name = "NEWS_VIDEO")
public class NewsVideo extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String title;
    private String fileName;

    @Column(name = "VIDEO_FILENAME", unique = true)
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Column(name = "VIDEO_TITLE", unique = true)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
