package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsStoryboard;
import com.videostar.vsnews.entity.news.NewsStoryboardTemplate;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

/**
 * StoryboardTaskDetail
 *
 * Created by patchao2000 on 14-9-23.
 */
public class StoryboardTaskDetail implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    private NewsStoryboardTemplate template;
    private NewsStoryboard storyboard;

    private Task task;
    private ProcessInstance processInstance;
    private String title;
    private Long entityId;
    private Boolean isTemplateTask;

    private String userName;
    private String columnName;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public NewsStoryboardTemplate getTemplate() {
        return template;
    }

    public void setTemplate(NewsStoryboardTemplate template) {
        this.template = template;
    }

    public NewsStoryboard getStoryboard() {
        return storyboard;
    }

    public void setStoryboard(NewsStoryboard storyboard) {
        this.storyboard = storyboard;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public Boolean getIsTemplateTask() {
        return isTemplateTask;
    }

    public void setIsTemplateTask(Boolean isTemplateTask) {
        this.isTemplateTask = isTemplateTask;
    }

    public Long getEntityId() {
        return entityId;
    }

    public void setEntityId(Long entityId) {
        this.entityId = entityId;
    }
}
