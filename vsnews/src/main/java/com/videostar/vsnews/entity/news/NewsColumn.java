package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Entity: Column - 新闻栏目
 *
 * Created by patchao2000 on 14-7-23.
 */
@Entity
@Table(name = "NEWS_COLUMN")
public class NewsColumn extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    //   栏目审核方式
    public static final int AUDIT_LEVEL_NONE    = 0;
    public static final int AUDIT_LEVEL_1       = 1;
    public static final int AUDIT_LEVEL_2       = 2;
    public static final int AUDIT_LEVEL_3       = 4;

    private Long parentId;
    private String name;
    private int auditLevel;
    private String notes;

    @Column(name = "PARENT_ID", nullable = true)
    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    @Column(name = "COLUMN_NAME", unique = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column
    public int getAuditLevel() {
        return auditLevel;
    }

    public void setAuditLevel(int auditLevel) {
        this.auditLevel = auditLevel;
    }

    @Column
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
