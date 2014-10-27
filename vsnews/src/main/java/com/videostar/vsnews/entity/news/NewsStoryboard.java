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

    private int status;

    //    标题
    @NotBlank(message = "标题不能为空")
    private String title;

    //    栏目
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private Long columnId;

    //    演播室
    private String studio;

    //    播出日期
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date airDate;

    //    时段开始
    private String startTC;

    //    时段结束
    private String endTC;

    //    锁定用户ID
    private String lockerUserId;

    //    责任编辑
    private List<String> editorsInCharge;

    //    导播
    private List<String> instructors;

    //    编辑
    private List<String> editors;

    //    监制
    private List<String> producers;

    //    主任
    private List<String> directors;

    //    播音员
    private List<String> announcers;

    //    配音员
    private List<String> voiceActors;

    //    字幕员
    private List<String> subtitlers;

    //    摄影师
    private List<String> cameramen;

    //    灯光
    private List<String> lightingEngineers;

    //    技术
    private List<String> technicians;

    //    备注
    private String notes;

    //    审核意见
    private String auditOpinion;

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

    @Column
    public String getLockerUserId() {
        return lockerUserId;
    }

    public void setLockerUserId(String lockerUserId) {
        this.lockerUserId = lockerUserId;
    }

    @Column
    public String getStudio() {
        return studio;
    }

    public void setStudio(String studio) {
        this.studio = studio;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_EDITORSINCHARGE", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getEditorsInCharge() {
        return editorsInCharge;
    }

    public void setEditorsInCharge(List<String> editorsInCharge) {
        this.editorsInCharge = editorsInCharge;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_INSTRUCTORS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getInstructors() {
        return instructors;
    }

    public void setInstructors(List<String> instructors) {
        this.instructors = instructors;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_PRODUCERS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getProducers() {
        return producers;
    }

    public void setProducers(List<String> producers) {
        this.producers = producers;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_DIRECTORS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getDirectors() {
        return directors;
    }

    public void setDirectors(List<String> directors) {
        this.directors = directors;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_ANNOUNCERS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getAnnouncers() {
        return announcers;
    }

    public void setAnnouncers(List<String> announcers) {
        this.announcers = announcers;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_VOICEACTORS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getVoiceActors() {
        return voiceActors;
    }

    public void setVoiceActors(List<String> voiceActors) {
        this.voiceActors = voiceActors;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_SUBTITLERS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getSubtitlers() {
        return subtitlers;
    }

    public void setSubtitlers(List<String> subtitlers) {
        this.subtitlers = subtitlers;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_CAMERAMEN", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getCameramen() {
        return cameramen;
    }

    public void setCameramen(List<String> cameramen) {
        this.cameramen = cameramen;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_LIGHTINGENGINEERS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getLightingEngineers() {
        return lightingEngineers;
    }

    public void setLightingEngineers(List<String> lightingEngineers) {
        this.lightingEngineers = lightingEngineers;
    }

    @Column
    @ElementCollection
    @CollectionTable(name = "NEWS_STORYBOARD_TECHNICIANS", joinColumns = @JoinColumn(name = "STORYBOARD_ID"))
    public List<String> getTechnicians() {
        return technicians;
    }

    public void setTechnicians(List<String> technicians) {
        this.technicians = technicians;
    }

    @Column
    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Column
    public String getAuditOpinion() {
        return auditOpinion;
    }

    public void setAuditOpinion(String auditOpinion) {
        this.auditOpinion = auditOpinion;
    }
}
