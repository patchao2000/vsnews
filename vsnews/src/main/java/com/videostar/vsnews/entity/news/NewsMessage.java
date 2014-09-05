package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
//import java.util.List;

/**
 * NewsMessage
 *
 * Created by patchao2000 on 14-9-5.
 */
@Entity
@Table(name = "NEWS_MESSAGE")
public class NewsMessage extends IdEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final int MESSAGE_TYPE_NORMAL     = 0;
    public static final int MESSAGE_TYPE_BROADCAST  = 1;

    private Long returnMessageId;
    private String senderId;
    private String receiverId;
    private String title;
    private int type;

    @NotBlank(message = "内容不能为空")
    private String content;

    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
    private Date sentDate;

    @Column
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Column
    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    @Column
    public String getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(String receiverId) {
        this.receiverId = receiverId;
    }

    @Column
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    public Date getSentDate() {
        return sentDate;
    }

    public void setSentDate(Date sentDate) {
        this.sentDate = sentDate;
    }

    @Column
    public Long getReturnMessageId() {
        return returnMessageId;
    }

    public void setReturnMessageId(Long returnMessageId) {
        this.returnMessageId = returnMessageId;
    }
}
