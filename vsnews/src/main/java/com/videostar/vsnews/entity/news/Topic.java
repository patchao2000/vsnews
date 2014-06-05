package com.videostar.vsnews.entity.news;

import com.videostar.vsnews.entity.IdEntity;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Map;

/**
 * Entity: Topic
 *
 * Created by patchao2000 on 14-6-3.
 */
@Entity
@Table(name = "NEWS_TOPIC")
public class Topic extends NewsEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String title;
    private String content;
    private String devices;
    private int status;

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

}