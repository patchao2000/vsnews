package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsArticle;
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
 * ArticleWorkflowFinishProcessor
 * 
 * Created by patchao2000 on 14-7-29.
 */
@Component
@Transactional
public class ArticleWorkflowFinishProcessor implements ExecutionListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(ArticleWorkflowFinishProcessor.class);

    @Autowired
    ArticleManager articleManager;

    @Autowired
    RuntimeService runtimeService;

    /* (non-Javadoc)
     * @see org.activiti.engine.delegate.TaskListener#notify(org.activiti.engine.delegate.DelegateTask)
     */
    public void notify(DelegateExecution execution) throws Exception {
        String processInstanceId = execution.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsArticle article = articleManager.getArticle(new Long(processInstance.getBusinessKey()));

        article.setStatus(1);

        logger.debug("ArticleWorkflowFinishProcessor: {}", article.getId());

        articleManager.saveArticle(article);
    }
}
