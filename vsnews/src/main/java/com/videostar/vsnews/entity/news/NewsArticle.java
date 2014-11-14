package com.videostar.vsnews.entity.news;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

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

    public static final int STATUS_EDITING = 0;
    public static final int STATUS_BEGIN_AUDIT = 1;
    public static final int STATUS_END_AUDIT = 2;

    private int status;

    //    栏目
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private Long columnId;

    //    主标题
    @NotBlank(message = "主标题不能为空")
    private String mainTitle;
    //    副标题
    private String subTitle;
    //    内容
    @NotBlank(message = "内容不能为空")
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
    //    视频
    private String video;

    //    拟报省台
    private Boolean prepareSendProvTV;
    //    拟报央台
    private Boolean prepareSendCCTV;
    //    报送省台
    private Boolean sentToProvTV;
    //    报送央台
    private Boolean sentToCCTV;
    //    省台采用
    private Boolean adoptedByProvTV;
    //    央台采用
    private Boolean adoptedByCCTV;

    //    选题UUID
    private String topicUuid;

    public NewsArticle() {
        this.status = STATUS_EDITING;
    }

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

    @Column(columnDefinition = "TEXT")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_ARTICLE_REPORTERS", joinColumns = @JoinColumn(name = "ARTICLE_ID"))
    public List<String> getReporters() {
        return reporters;
    }

    public void setReporters(List<String> reporters) {
        this.reporters = reporters;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_ARTICLE_CAMERMEN", joinColumns = @JoinColumn(name = "ARTICLE_ID"))
    public List<String> getCameramen() {
        return cameramen;
    }

    public void setCameramen(List<String> cameramen) {
        this.cameramen = cameramen;
    }

    @Column
    @ElementCollection
    @CollectionTable (name = "NEWS_ARTICLE_EDITORS", joinColumns = @JoinColumn(name = "ARTICLE_ID"))
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

    @Column
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Column
    public Boolean getPrepareSendProvTV() {
        return prepareSendProvTV;
    }

    public void setPrepareSendProvTV(Boolean prepareSendProvTV) {
        this.prepareSendProvTV = prepareSendProvTV;
    }

    @Column
    public Boolean getPrepareSendCCTV() {
        return prepareSendCCTV;
    }

    public void setPrepareSendCCTV(Boolean prepareSendCCTV) {
        this.prepareSendCCTV = prepareSendCCTV;
    }

    @Column
    public Boolean getSentToProvTV() {
        return sentToProvTV;
    }

    public void setSentToProvTV(Boolean sentToProvTV) {
        this.sentToProvTV = sentToProvTV;
    }

    @Column
    public Boolean getSentToCCTV() {
        return sentToCCTV;
    }

    public void setSentToCCTV(Boolean sentToCCTV) {
        this.sentToCCTV = sentToCCTV;
    }

    @Column
    public Boolean getAdoptedByProvTV() {
        return adoptedByProvTV;
    }

    public void setAdoptedByProvTV(Boolean adoptedByProvTV) {
        this.adoptedByProvTV = adoptedByProvTV;
    }

    @Column
    public Boolean getAdoptedByCCTV() {
        return adoptedByCCTV;
    }

    public void setAdoptedByCCTV(Boolean adoptedByCCTV) {
        this.adoptedByCCTV = adoptedByCCTV;
    }

//    @Transient
//    public final String getStatusString() {
//        switch(status) {
//            case STATUS_WRITING:
//                return "撰写中";
//            case STATUS_WRITTEN:
//                return "撰写完毕";
//        }
//        return "ERROR";
//    }

    @Column
    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    @Column(unique = true)
    public String getTopicUuid() {
        return topicUuid;
    }

    public void setTopicUuid(String topicUuid) {
        this.topicUuid = topicUuid;
    }
}
