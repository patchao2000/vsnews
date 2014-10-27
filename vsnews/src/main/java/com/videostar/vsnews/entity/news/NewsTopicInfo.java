package com.videostar.vsnews.entity.news;

import javax.persistence.Embeddable;

/**
 * NewsTopicInfo
 *
 * Created by patchao2000 on 14-9-22.
 */
@Embeddable
public class NewsTopicInfo {

    //  序号
    int orderValue;

    //  新闻选题uuid
    String topicUuid;

    //  调节长度时码
//    String adjustTC;

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

//    public String getAdjustTC() {
//        return adjustTC;
//    }
//
//    public void setAdjustTC(String adjustTC) {
//        this.adjustTC = adjustTC;
//    }
}
