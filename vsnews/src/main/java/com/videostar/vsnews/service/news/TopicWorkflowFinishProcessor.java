package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.Topic;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * TopicWorkflowFinishProcessor
 *
 * Created by patchao2000 on 14-6-25.
 */
@Component
@Transactional
public class TopicWorkflowFinishProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(TopicWorkflowFinishProcessor.class);

    @Autowired
    TopicManager topicManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        Topic topic = topicManager.getTopic(new Long(processInstance.getBusinessKey()));

        topic.setStatus(1);

        logger.debug("TopicWorkflowFinishProcessor: {}", topic.getId());

        topicManager.saveTopic(topic);
    }
}
