package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsStoryboard;
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
 * StoryboardAfterAuditProcessor
 *
 * Created by patchao2000 on 14/10/27.
 */
@Component
@Transactional
public class StoryboardAfterAuditProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(StoryboardAfterAuditProcessor.class);

    @Autowired
    StoryboardManager storyboardManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    @SuppressWarnings("unchecked")
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsStoryboard entity = storyboardManager.getStoryboard(new Long(processInstance.getBusinessKey()));

        entity.setAuditOpinion((String) delegateTask.getVariable("leaderbackreason"));

        logger.debug("StoryboardAfterAuditProcessor: {} {}", entity.getId(), entity.getTitle());

        storyboardManager.saveStoryboard(entity);
    }
}
