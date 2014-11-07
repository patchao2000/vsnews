package com.videostar.vsnews.service.news;

import com.videostar.vsnews.constants.WorkflowNames;
import com.videostar.vsnews.entity.news.NewsStoryboard;
import com.videostar.vsnews.entity.news.NewsStoryboardTemplate;
import org.activiti.engine.*;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * StoryboardWorkflowService
 * 
 * Created by patchao2000 on 14-10-13.
 */
@Component
@Transactional
public class StoryboardWorkflowService {
    
    private static Logger logger = LoggerFactory.getLogger(StoryboardWorkflowService.class);

    private RuntimeService runtimeService;

    protected TaskService taskService;

    protected RepositoryService repositoryService;

    private StoryboardManager storyboardManager;

    @Autowired
    private IdentityService identityService;

    public ProcessInstance startStoryboardTemplateWorkflow(NewsStoryboardTemplate entity, Map<String, Object> variables) {
        storyboardManager.saveStoryboardTemplate(entity);
//        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.storyboardTemplate, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.storyboardTemplate, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

//    public ProcessInstance startStoryboardWorkflow(NewsStoryboard entity, Map<String, Object> variables) {
//        storyboardManager.saveStoryboard(entity);
//        logger.debug("save entity: {}", entity);
//        String businessKey = entity.getId().toString();
//
//        ProcessInstance processInstance = null;
//        try {
//            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
//            identityService.setAuthenticatedUserId(entity.getUserId());
//
//            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.storyboard, businessKey, variables);
//            String processInstanceId = processInstance.getId();
//            entity.setProcessInstanceId(processInstanceId);
//            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.storyboard, businessKey, processInstanceId, variables);
//        } finally {
//            identityService.setAuthenticatedUserId(null);
//        }
//        return processInstance;
//    }

//    private List<Task> getTodoTasks(String userId) {
//        List<Task> tasks = new ArrayList<Task>();
//
//        // 根据当前人的ID查询
//        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.storyboard).taskAssignee(userId).active().orderByTaskId().desc()
//                .orderByTaskCreateTime().desc();
//        List<Task> todoList = todoQuery.list();
//
//        // 根据当前人未签收的任务
//        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.storyboard).taskCandidateUser(userId).active().orderByTaskId().desc()
//                .orderByTaskCreateTime().desc();
//        List<Task> unsignedTasks = claimQuery.list();
//
//        // 合并
//        tasks.addAll(todoList);
//        tasks.addAll(unsignedTasks);
//
//        return tasks;
//    }
//
//    @Transactional(readOnly = true)
//    public List<NewsStoryboard> findTodoTasks(String userId) {
//        List<NewsStoryboard> results = new ArrayList<NewsStoryboard>();
//
//        // 根据流程的业务ID查询实体并关联
//        for (Task task : getTodoTasks(userId)) {
//            String processInstanceId = task.getProcessInstanceId();
//            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
//            String businessKey = processInstance.getBusinessKey();
//            if (businessKey == null) {
//                continue;
//            }
//            NewsStoryboard entity = storyboardManager.getStoryboard(new Long(businessKey));
//            entity.setTask(task);
//            entity.setProcessInstance(processInstance);
//            entity.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
//            results.add(entity);
//        }
//
//        return results;
//    }
//
//    @Transactional(readOnly = true)
//    public int getTodoTasksCount(String userId) {
//        return getTodoTasks(userId).size();
//    }
//
//    //    @SuppressWarnings("unchecked")
//    @Transactional(readOnly = true)
//    public List<NewsStoryboard> getAllTopics() {
//        ArrayList<NewsStoryboard> result = new ArrayList<NewsStoryboard>();
//        for (NewsStoryboard entity : storyboardManager.getAllStoryboards()) {
//            result.add(entity);
//        }
//
//        //  填充running task
//        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
//        listRunning.addAll(runtimeService.createProcessInstanceQuery().
//                processDefinitionKey(WorkflowNames.storyboard).active().orderByProcessInstanceId().desc().list());
//        for (ProcessInstance processInstance : listRunning) {
//            String businessKey = processInstance.getBusinessKey();
//            if (businessKey == null) {
//                continue;
//            }
//            for (NewsStoryboard topic : result) {
//                if (topic.getId().equals(new Long(businessKey))) {
//                    List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().
//                            orderByTaskCreateTime().desc().list();
//                    topic.setTask(tasks.get(0));
//                    topic.setProcessInstance(processInstance);
//                    topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
//                    break;
//                }
//            }
//        }
//        return result;
//    }
//
//    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
//        return repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
//    }
//
//    public Boolean isFinished(NewsStoryboard entity) {
//        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
//        listRunning.addAll(runtimeService.createProcessInstanceQuery().
//                processDefinitionKey(WorkflowNames.storyboard).active().orderByProcessInstanceId().desc().list());
//        for (ProcessInstance processInstance : listRunning) {
//            String businessKey = processInstance.getBusinessKey();
//            if (businessKey == null) {
//                continue;
//            }
//            if (entity.getId().equals(new Long(businessKey)))
//                return false;
//        }
//
//        return true;
//    }

    @Autowired
    public void setStoryboardManager(StoryboardManager storyboardManager) {
        this.storyboardManager = storyboardManager;
    }

    @Autowired
    public void setRuntimeService(RuntimeService runtimeService) {
        this.runtimeService = runtimeService;
    }

    @Autowired
    public void setTaskService(TaskService taskService) {
        this.taskService = taskService;
    }

    @Autowired
    public void setRepositoryService(RepositoryService repositoryService) {
        this.repositoryService = repositoryService;
    }
}
