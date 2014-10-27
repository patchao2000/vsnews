package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsTopic;

/**
 * TopicInfoDetail
 *
 * Created by patchao2000 on 14-9-24.
 */
public class TopicInfoDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private int orderValue;
    private String topicUuid;
//    private String adjustTC;
    private NewsTopic Topic;
    private Boolean videoFileReady;
    private Boolean audioFileReady;
    private Boolean articleReady;

    private String videoLength;
    private String articleLength;
    private String totalLength;

    public int getOrderValue() {
        return orderValue;
    }

    public void setOrderValue(int orderValue) {
        this.orderValue = orderValue;
    }

    public String getTopicUuid() {
        return topicUuid;
    }

    public void setTopicUuid(String topicUuid) {
        this.topicUuid = topicUuid;
    }

    public NewsTopic getTopic() {
        return Topic;
    }

    public void setTopic(NewsTopic topic) {
        Topic = topic;
    }

//    public String getAdjustTC() {
//        return adjustTC;
//    }
//
//    public void setAdjustTC(String adjustTC) {
//        this.adjustTC = adjustTC;
//    }

    public Boolean getVideoFileReady() {
        return videoFileReady;
    }

    public void setVideoFileReady(Boolean videoFileReady) {
        this.videoFileReady = videoFileReady;
    }

    public Boolean getAudioFileReady() {
        return audioFileReady;
    }

    public void setAudioFileReady(Boolean audioFileReady) {
        this.audioFileReady = audioFileReady;
    }

    public Boolean getArticleReady() {
        return articleReady;
    }

    public void setArticleReady(Boolean articleReady) {
        this.articleReady = articleReady;
    }

    public String getVideoLength() {
        return videoLength;
    }

    public void setVideoLength(String videoLength) {
        this.videoLength = videoLength;
    }

    public String getArticleLength() {
        return articleLength;
    }

    public void setArticleLength(String articleLength) {
        this.articleLength = articleLength;
    }

    public String getTotalLength() {
        return totalLength;
    }

    public void setTotalLength(String totalLength) {
        this.totalLength = totalLength;
    }
}
