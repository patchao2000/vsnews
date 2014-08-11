package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * NewsArticleHistory
 *
 * Created by patchao2000 on 14-8-11.
 */
@Entity
@Table(name = "NEWS_ARTICLE_HISTORY")
public class NewsArticleHistory extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date time;

    private String userId;
    private Long articleId;
    private String item;
    private String content;

    private String displayTitle;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Column
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Column
    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    @Column(columnDefinition = "TEXT")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column
    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    @Transient
    public String getDisplayTitle() {
        return displayTitle;
    }

    public void setDisplayTitle(String displayTitle) {
        this.displayTitle = displayTitle;
    }
}
