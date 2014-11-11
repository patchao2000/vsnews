package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsStoryboard;
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
 * StoryboardWorkflowFinishProcessor
 *
 * Created by patchao2000 on 14-10-13.
 */
@Component
@Transactional
public class StoryboardWorkflowFinishProcessor implements ExecutionListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(StoryboardWorkflowFinishProcessor.class);

    @Autowired
    StoryboardManager storyboardManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    public void notify(DelegateExecution execution) throws Exception {
        String processInstanceId = execution.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsStoryboard entity = storyboardManager.getStoryboard(new Long(processInstance.getBusinessKey()));

        entity.setStatus(NewsStoryboard.STATUS_END_AUDIT);

        logger.debug("StoryboardWorkflowFinishProcessor: {}", entity.getId());

        storyboardManager.saveStoryboard(entity);
    }
}
