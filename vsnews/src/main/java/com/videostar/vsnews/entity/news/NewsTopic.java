package com.videostar.vsnews.entity.news;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Entity: Topic - 新闻选题
 *
 * Created by patchao2000 on 14-6-3.
 */

@Entity
@Table(name = "NEWS_TOPIC")
public class NewsTopic extends NewsProcessEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String uuid;

    private List<NewsFileInfo> videoFiles;
    private List<NewsFileInfo> audioFiles;
    private List<NewsFileInfo> otherFiles;

    //    标题
    @NotBlank(message = "标题不能为空")
    private String title;
    //    内容
    @NotBlank(message = "内容不能为空")
    private String content;

    //    记者
    private List<String> reporters;
    //    摄像员
    private List<String> cameramen;
    //    其他人员
    private List<String> others;
    //    派遣对象
    private String dispatcher;

    //    采访时间
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date interviewTime;
    //    采访地点
    private String location;
    //    所需设备/车辆
    private String devices;
    //    出发时间
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date startTime;
    //    返回时间
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date endTime;

    public NewsTopic() {
        uuid = UUID.randomUUID().toString();
    }

    @Column(unique = true, nullable = false)
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_VIDEOFILES", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<NewsFileInfo> getVideoFiles() {
        return videoFiles;
    }

    public void setVideoFiles(List<NewsFileInfo> videoFiles) {
        this.videoFiles = videoFiles;
    }

    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_AUDIOFILES", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<NewsFileInfo> getAudioFiles() {
        return audioFiles;
    }

    public void setAudioFiles(List<NewsFileInfo> audioFiles) {
        this.audioFiles = audioFiles;
    }

    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_OTHERFILES", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<NewsFileInfo> getOtherFiles() {
        return otherFiles;
    }

    public void setOtherFiles(List<NewsFileInfo> otherFiles) {
        this.otherFiles = otherFiles;
    }

    @Column(nullable = false)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(columnDefinition="TEXT")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column(columnDefinition="TEXT")
    public String getDevices() {
        return devices;
    }

    public void setDevices(String devices) {
        this.devices = devices;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_REPORTERS", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<String> getReporters() {
        return reporters;
    }

    public void setReporters(List<String> reporters) {
        this.reporters = reporters;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_CAMERAMEN", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<String> getCameramen() {
        return cameramen;
    }

    public void setCameramen(List<String> cameramen) {
        this.cameramen = cameramen;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_TOPIC_OTHERS", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<String> getOthers() {
        return others;
    }

    public void setOthers(List<String> others) {
        this.others = others;
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

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "START_TIME")
    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "END_TIME")
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @Column
    public String getDispatcher() {
        return dispatcher;
    }

    public void setDispatcher(String dispatcher) {
        this.dispatcher = dispatcher;
    }
}
