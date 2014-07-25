package com.videostar.vsnews.entity.news;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 * NewsArticle
 *
 * Created by patchao2000 on 14-7-25.
 */
@Entity
@Table(name = "NEWS_ARTICLE")
public class NewsArticle extends NewsProcessEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    //    栏目
    private Long columnId;

    //    主标题
    private String mainTitle;
    //    副标题
    private String subTitle;
    //    内容
    private String content;

    //    记者
    private List<String> reporters;
    //    摄像员
    private List<String> cameramen;
    //    编辑
    private List<String> editors;

    //    采访时间
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date interviewTime;
    //    采访地点
    private String location;

    //    报料人
    private String sourcers;
    //    报料人电话
    private String sourcersTel;

    //    备注
    private String notes;

    @Column
    public Long getColumnId() {
        return columnId;
    }

    public void setColumnId(Long columnId) {
        this.columnId = columnId;
    }

    @Column
    public String getMainTitle() {
        return mainTitle;
    }

    public void setMainTitle(String mainTitle) {
        this.mainTitle = mainTitle;
    }

    @Column
    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    @Column
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column
    public List<String> getReporters() {
        return reporters;
    }

    public void setReporters(List<String> reporters) {
        this.reporters = reporters;
    }

    @Column
    public List<String> getCameramen() {
        return cameramen;
    }

    public void setCameramen(List<String> cameramen) {
        this.cameramen = cameramen;
    }

    @Column
    public List<String> getEditors() {
        return editors;
    }

    public void setEditors(List<String> editors) {
        this.editors = editors;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "INTERVIEW_TIME")
    public Date getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(Date interviewTime) {
        this.interviewTime = interviewTime;
    }

    @Column
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Column
    public String getSourcers() {
        return sourcers;
    }

    public void setSourcers(String sourcers) {
        this.sourcers = sourcers;
    }

    @Column
    public String getSourcersTel() {
        return sourcersTel;
    }

    public void setSourcersTel(String sourcersTel) {
        this.sourcersTel = sourcersTel;
    }

    @Column
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
