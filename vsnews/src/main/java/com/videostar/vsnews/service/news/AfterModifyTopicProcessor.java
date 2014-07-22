package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.Topic;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
//import java.util.Date;
import java.util.List;

/**
 * Created by patchao2000 on 14-6-21.
 *
 */
@Component
@Transactional
public class AfterModifyTopicProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(AfterModifyTopicProcessor.class);

    @Autowired
    TopicManager topicManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    @SuppressWarnings("unchecked")
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        Topic topic = topicManager.getTopic(new Long(processInstance.getBusinessKey()));

        topic.setTitle((String) delegateTask.getVariable("title"));
        topic.setContent((String) delegateTask.getVariable("content"));
        topic.setDevices((String) delegateTask.getVariable("devices"));
        topic.setReporters((List<String>) delegateTask.getVariable("reporters"));
        topic.setCameramen((List<String>) delegateTask.getVariable("cameramen"));
        topic.setOthers((List<String>) delegateTask.getVariable("others"));
        topic.setLocation((String) delegateTask.getVariable("location"));

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            topic.setInterviewTime(format.parse((String) delegateTask.getVariable("interviewTime")));
        } catch (ParseException e) {
            logger.error("interviewTime wrong!");
        }
        try {
            topic.setStartTime(format.parse((String) delegateTask.getVariable("startTime")));
        } catch (ParseException e) {
            logger.error("startTime wrong!");
        }
        try {
            topic.setEndTime(format.parse((String) delegateTask.getVariable("endTime")));
        } catch (ParseException e) {
            logger.error("endTime wrong!");
        }

        logger.debug("AfterModifyTopicProcessor: {} {} {}", topic.getTitle(), topic.getContent(), topic.getDevices());

        topicManager.saveTopic(topic);
    }
}
