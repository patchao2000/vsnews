package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsArticle;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * ArticleAfterModifyProcessor
 * 
 * Created by patchao2000 on 14-7-28.
 */
@Component
@Transactional
public class ArticleAfterModifyProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(ArticleAfterModifyProcessor.class);

    @Autowired
    ArticleManager articleManager;

    @Autowired
    RuntimeService runtimeService;

    @SuppressWarnings("unchecked")
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsArticle article = articleManager.getArticle(new Long(processInstance.getBusinessKey()));
        logger.debug("task assignee {}", delegateTask.getAssignee());

        Object mainTitle = delegateTask.getVariable("mainTitle");
        if (mainTitle != null) {
            String orgMainTitle = (String)mainTitle;
            if (!article.getMainTitle().equals(orgMainTitle)) {
                logger.debug("mainTitle changed.");
                article.setMainTitle((String) mainTitle);
            }
        }

        Object content = delegateTask.getVariable("content");
        if (content != null) {
            if (!article.getContent().equals(content)) {
                logger.debug("content changed.");
                article.setContent((String) content);

                articleManager.applyArticleHistory(delegateTask.getAssignee(), article.getId(), "content", (String)content);
            }
        }

        article.setSubTitle((String) delegateTask.getVariable("subTitle"));
        article.setReporters((List<String>) delegateTask.getVariable("reporters"));
        article.setCameramen((List<String>) delegateTask.getVariable("cameramen"));
        article.setEditors((List<String>) delegateTask.getVariable("editors"));
        article.setLocation((String) delegateTask.getVariable("location"));
        article.setNotes((String) delegateTask.getVariable("notes"));
        article.setSourcers((String) delegateTask.getVariable("sourcers"));
        article.setSourcersTel((String) delegateTask.getVariable("sourcersTel"));

        Object interviewTime = delegateTask.getVariable("interviewTime");
        if (interviewTime != null) {
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            try {
                article.setInterviewTime(format.parse((String)interviewTime));
            } catch (ParseException e) {
                logger.error("interviewTime wrong!");
            }
        }

        logger.debug("AfterModifyArticleProcessor: {} {}", article.getMainTitle(), article.getContent());

        articleManager.saveArticle(article);
    }
}
