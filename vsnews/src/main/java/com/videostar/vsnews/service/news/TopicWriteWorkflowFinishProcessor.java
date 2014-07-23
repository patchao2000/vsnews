package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsTopic;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * TopicWriteWorkflowFinishProcessor
 *
 * Created by patchao2000 on 14-7-18.
 */
@Component
@Transactional
public class TopicWriteWorkflowFinishProcessor implements ExecutionListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(TopicWriteWorkflowFinishProcessor.class);

    @Autowired
    TopicManager topicManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    public void notify(DelegateExecution execution) throws Exception {
        String processInstanceId = execution.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsTopic topic = topicManager.getTopic(new Long(processInstance.getBusinessKey()));

        topic.setStatus(NewsTopic.STATUS_WRITTEN);

        logger.debug("TopicWriteWorkflowFinishProcessor: {}", topic.getId());

        topicManager.saveTopic(topic);
    }
}
