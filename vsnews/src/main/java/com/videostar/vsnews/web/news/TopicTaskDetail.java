package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsFileInfo;
import com.videostar.vsnews.entity.news.NewsTopic;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

/**
 * TopicTaskDetail
 * 
 * Created by patchao2000 on 14-8-5.
 */
public class TopicTaskDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsTopic Topic;
    private String userName;
    private String dispatcherName;
    private Boolean avFileReady;
    private Boolean articleReady;

    private NewsFileInfo fileInfo;
    private Boolean isFileInfoTask;

    private Task task;
    private ProcessInstance processInstance;

    public NewsTopic getTopic() {
        return Topic;
    }

    public void setTopic(NewsTopic Topic) {
        this.Topic = Topic;
    }

    public NewsFileInfo getFileInfo() {
        return fileInfo;
    }

    public void setFileInfo(NewsFileInfo fileInfo) {
        this.fileInfo = fileInfo;
    }

    public Boolean getIsFileInfoTask() {
        return isFileInfoTask;
    }

    public void setIsFileInfoTask(Boolean isFileInfoTask) {
        this.isFileInfoTask = isFileInfoTask;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public ProcessInstance getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(ProcessInstance processInstance) {
        this.processInstance = processInstance;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDispatcherName() {
        return dispatcherName;
    }

    public void setDispatcherName(String dispatcherName) {
        this.dispatcherName = dispatcherName;
    }

    public Boolean getAvFileReady() {
        return avFileReady;
    }

    public void setAvFileReady(Boolean avFileReady) {
        this.avFileReady = avFileReady;
    }

    public Boolean getArticleReady() {
        return articleReady;
    }

    public void setArticleReady(Boolean articleReady) {
        this.articleReady = articleReady;
    }
}

