package com.videostar.vsnews.entity.news;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * NewsStoryboard
 *
 * Created by patchao2000 on 14-9-22.
 */
@Entity
@Table(name = "NEWS_STORYBOARD")
public class NewsStoryboard extends NewsProcessEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    //    模板ID
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private Long templateId;

    //    播出日期
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date airDate;

    //    锁定用户ID
    private String lockerUserId;

    //    审核意见
    private String auditOpinion;

    //    新闻
    private List<NewsTopicInfo> topics;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getAirDate() {
        return airDate;
    }

    public void setAirDate(Date airDate) {
        this.airDate = airDate;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_TOPICS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<NewsTopicInfo> getTopics() {
        return topics;
    }

    public void setTopics(List<NewsTopicInfo> topics) {
        this.topics = topics;
    }

    @Column
    public String getLockerUserId() {
        return lockerUserId;
    }

    public void setLockerUserId(String lockerUserId) {
        this.lockerUserId = lockerUserId;
    }

    @Column
    public String getAuditOpinion() {
        return auditOpinion;
    }

    public void setAuditOpinion(String auditOpinion) {
        this.auditOpinion = auditOpinion;
    }

    @Column
    public Long getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Long templateId) {
        this.templateId = templateId;
    }
}
