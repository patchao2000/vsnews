package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * NewsVideo
 *
 * Created by patchao2000 on 14-8-18.
 */
@Entity
@Table(name = "NEWS_VIDEO")
public class NewsVideo extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long columnId;
    private String title;
    private String fileName;
    private String originalFileName;
    private Long fileSize;
    private String fileType;

    private String uploadUserId;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date uploadDate;

    @Column
    public Long getColumnId() {
        return columnId;
    }

    public void setColumnId(Long columnId) {
        this.columnId = columnId;
    }

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

    @Column
    public String getUploadUserId() {
        return uploadUserId;
    }

    public void setUploadUserId(String uploadUserId) {
        this.uploadUserId = uploadUserId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Column
    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    @Column
    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    @Column
    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
}
