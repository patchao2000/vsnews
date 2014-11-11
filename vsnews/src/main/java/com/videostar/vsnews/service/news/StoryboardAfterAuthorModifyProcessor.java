package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsStoryboard;
import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.entity.news.NewsTopicInfo;
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
 * StoryboardAfterAuthorModifyProcessor
 *
 * Created by patchao2000 on 14-10-13.
 */
@Component
@Transactional
public class StoryboardAfterAuthorModifyProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(StoryboardAfterAuthorModifyProcessor.class);

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

//        entity.setTopics((List<NewsTopicInfo>) delegateTask.getVariable("topics"));

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            entity.setAirDate(format.parse((String) delegateTask.getVariable("airDate")));
        } catch (ParseException e) {
            logger.error("airDate wrong!");
        }

        logger.debug("StoryboardAfterAuthorModifyProcessor: {}", entity.getId());

        storyboardManager.saveStoryboard(entity);
    }
}
