package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * NewsLog
 *
 * Created by patchao2000 on 14/11/21.
 */
@Entity
@Table(name = "NEWS_LOG")
public class NewsLog extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date accessTime;

    private String userId;
    private String operation;
    private String notes;

    @Column(nullable = false)
    public Date getAccessTime() {
        return accessTime;
    }

    public void setAccessTime(Date accessTime) {
        this.accessTime = accessTime;
    }

    @Column(nullable = false)
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column(nullable = false)
    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    @Column
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
