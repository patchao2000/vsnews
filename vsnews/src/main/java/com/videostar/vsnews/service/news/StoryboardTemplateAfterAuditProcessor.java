package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsStoryboardTemplate;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * StoryboardTemplateAfterAuditProcessor
 *
 * Created by patchao2000 on 14/11/7.
 */
public class StoryboardTemplateAfterAuditProcessor {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(StoryboardTemplateAfterAuditProcessor.class);

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
        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(new Long(processInstance.getBusinessKey()));

        entity.setAuditOpinion((String) delegateTask.getVariable("leaderbackreason"));

        logger.debug("StoryboardTemplateAfterAuditProcessor: {} {}", entity.getId(), entity.getTitle());

        storyboardManager.saveStoryboardTemplate(entity);
    }
}
