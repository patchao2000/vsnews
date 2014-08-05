package com.videostar.vsnews.entity.news;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Entity: Topic - 新闻选题
 *
 * Created by patchao2000 on 14-6-3.
 */
@Entity
@Table(name = "NEWS_TOPIC")
public class NewsTopic extends NewsProcessEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    //   选题状态: 0 -> 选题撰写中, 1 -> 选题撰写完毕, 2 -> 选题派遣中, 3 -> 选题派遣完毕
    public static final int STATUS_WRITING = 0;
    public static final int STATUS_WRITTEN = 1;
    public static final int STATUS_DISPATCHING = 2;
    public static final int STATUS_DISPATCHED = 3;

    private int status;

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
        this.status = STATUS_WRITING;
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

    @Transient
    public final String getStatusString() {
        switch(status) {
            case STATUS_WRITING:
                return "撰写中";
            case STATUS_WRITTEN:
                return "撰写完毕";
            case STATUS_DISPATCHING:
                return "派遣中";
            case STATUS_DISPATCHED:
                return "派遣完毕";
        }
        return "ERROR";
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
}
