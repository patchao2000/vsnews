package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
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

    private int status;

    //    标题
    @NotBlank(message = "标题不能为空")
    private String title;

    //    栏目
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private Long columnId;

    //    播出日期
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date airDate;

    //    时段开始
    private String startTC;

    //    时段结束
    private String endTC;

//    //    作者用户ID
//    private String authorUserId;

    //    锁定用户ID
    private String lockerUserId;

    //    编辑
    private List<String> editors;

    //    新闻
    private List<NewsTopicInfo> topics;

    @Column
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Column(nullable = false)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column
    public Long getColumnId() {
        return columnId;
    }

    public void setColumnId(Long columnId) {
        this.columnId = columnId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getAirDate() {
        return airDate;
    }

    public void setAirDate(Date airDate) {
        this.airDate = airDate;
    }

    @Column
    public String getStartTC() {
        return startTC;
    }

    public void setStartTC(String startTC) {
        this.startTC = startTC;
    }

    @Column
    public String getEndTC() {
        return endTC;
    }

    public void setEndTC(String endTC) {
        this.endTC = endTC;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_EDITORS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getEditors() {
        return editors;
    }

    public void setEditors(List<String> editors) {
        this.editors = editors;
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

//    @Column
//    public String getAuthorUserId() {
//        return authorUserId;
//    }
//
//    public void setAuthorUserId(String authorUserId) {
//        this.authorUserId = authorUserId;
//    }

    @Column
    public String getLockerUserId() {
        return lockerUserId;
    }

    public void setLockerUserId(String lockerUserId) {
        this.lockerUserId = lockerUserId;
    }
}
