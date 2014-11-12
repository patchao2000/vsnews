package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsFileInfo;
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
 * FileInfoAfterAuditProcessor
 *
 * Created by patchao2000 on 14/11/12.
 */
@Component
@Transactional
public class FileInfoAfterAuditProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(FileInfoAfterAuditProcessor.class);

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
        NewsFileInfo entity = topicManager.getFileInfo(new Long(processInstance.getBusinessKey()));

//        entity.setAuditOpinion((String) delegateTask.getVariable("leaderbackreason"));

        logger.debug("FileInfoAfterAuditProcessor: {} {}", entity.getId(), entity.getTitle());

//        storyboardManager.saveFileInfo(entity);
    }
}
