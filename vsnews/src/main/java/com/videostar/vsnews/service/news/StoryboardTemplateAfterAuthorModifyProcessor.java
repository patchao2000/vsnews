package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsStoryboardTemplate;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * StoryboardTemplateAfterAuthorModifyProcessor
 *
 * Created by patchao2000 on 14/11/7.
 */
@Component
@Transactional
public class StoryboardTemplateAfterAuthorModifyProcessor implements TaskListener {
    private static final long serialVersionUID = 1L;

    private static Logger logger = LoggerFactory.getLogger(StoryboardTemplateAfterAuthorModifyProcessor.class);

    @Autowired
    StoryboardManager storyboardManager;

    @Autowired
    RuntimeService runtimeService;

    @SuppressWarnings("unchecked")
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(new Long(processInstance.getBusinessKey()));

        entity.setTitle((String) delegateTask.getVariable("title"));
        entity.setStartTC((String) delegateTask.getVariable("startTC"));
        entity.setEndTC((String) delegateTask.getVariable("endTC"));
        entity.setEditors((List<String>) delegateTask.getVariable("editors"));
        entity.setNotes((String) delegateTask.getVariable("notes"));
        entity.setStudio((String) delegateTask.getVariable("studio"));
        entity.setEditorsInCharge((List<String>) delegateTask.getVariable("editorsInCharge"));
        entity.setInstructors((List<String>) delegateTask.getVariable("instructors"));
        entity.setProducers((List<String>) delegateTask.getVariable("producers"));
        entity.setDirectors((List<String>) delegateTask.getVariable("directors"));
        entity.setAnnouncers((List<String>) delegateTask.getVariable("announcers"));
        entity.setVoiceActors((List<String>) delegateTask.getVariable("voiceActors"));
        entity.setSubtitlers((List<String>) delegateTask.getVariable("subtitlers"));
        entity.setCameramen((List<String>) delegateTask.getVariable("cameramen"));
        entity.setLightingEngineers((List<String>) delegateTask.getVariable("lightingEngineers"));
        entity.setTechnicians((List<String>) delegateTask.getVariable("technicians"));

        logger.debug("StoryboardAfterAuthorModifyProcessor: {} {}", entity.getId(), entity.getTitle());

        storyboardManager.saveStoryboardTemplate(entity);
    }
}
