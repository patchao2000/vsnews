package com.videostar.vsnews.entity.news;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Entity: Topic
 *
 * Created by patchao2000 on 14-6-3.
 */
@Entity
@Table(name = "NEWS_TOPIC")
public class Topic extends NewsEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private int status;

    //    标题
    private String title;
    //    内容
    private String content;

    //    记者
    private List<String> reporters;
    //    摄像员
    private List<String> camermans;
    //    其他人员
    private List<String> others;

    //    采访时间
    private Date interviewTime;
    //    采访地点
    private Date interviewLocation;
    //    所需设备/车辆
    private String devices;
    //    出发时间
    private Date startTime;
    //    返回时间
    private Date endTime;

    //  status: 0 -> not finished, 1 -> finished
    public Topic() {
        this.status = 0;
    }

    @Column
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
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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
    @CollectionTable (name = "NEWS_TOPIC_CAMERAMANS", joinColumns = @JoinColumn(name = "TOPIC_ID"))
    public List<String> getCamermans() {
        return camermans;
    }

    public void setCamermans(List<String> camermans) {
        this.camermans = camermans;
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

    @Column
    public Date getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(Date interviewTime) {
        this.interviewTime = interviewTime;
    }

    @Column
    public Date getInterviewLocation() {
        return interviewLocation;
    }

    public void setInterviewLocation(Date interviewLocation) {
        this.interviewLocation = interviewLocation;
    }

    @Column
    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    @Column
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
