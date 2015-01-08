package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsFileInfo;
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

import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.constants.WorkflowNames;

/**
 * TopicWorkflowService
 * 
 * Created by patchao2000 on 14-6-4.
 */
@Component
@Transactional
public class TopicWorkflowService {

    private static Logger logger = LoggerFactory.getLogger(TopicWorkflowService.class);

    private TopicManager topicManager;

    private RuntimeService runtimeService;

    protected TaskService taskService;

    protected HistoryService historyService;

    protected RepositoryService repositoryService;

    @Autowired
    private IdentityService identityService;

    /**
     * 启动流程
     *
     */
    public ProcessInstance startTopicNewWorkflow(NewsTopic entity, Map<String, Object> variables) {
        topicManager.saveTopic(entity);
//        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.topicNew, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.topicNew, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    public ProcessInstance startFileInfoWorkflow(NewsFileInfo entity, Map<String, Object> variables) {
        topicManager.saveFileInfo(entity);
//        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.fileInfo, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.fileInfo, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    @Transactional(readOnly = true)
    private List<Task> getTodoTasks(String userId, String workflowName) {
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(workflowName).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoList = todoQuery.list();

        // 根据当前人未签收的任务
        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(workflowName).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasks = claimQuery.list();

        // 合并
        tasks.addAll(todoList);
        tasks.addAll(unsignedTasks);

        return tasks;
    }

    @Transactional(readOnly = true)
    public List<NewsTopic> findTopicTodoTasks(String userId) {
        List<NewsTopic> results = new ArrayList<NewsTopic>();

        // 根据流程的业务ID查询实体并关联
        for (Task task : getTodoTasks(userId, WorkflowNames.topicNew)) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsTopic topic = topicManager.getTopic(new Long(businessKey));
            topic.setTask(task);
            topic.setProcessInstance(processInstance);
            topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(topic);
        }

        return results;
    }

    @Transactional(readOnly = true)
    public List<NewsFileInfo> findFileInfoTodoTasks(String userId) {
        List<NewsFileInfo> results = new ArrayList<NewsFileInfo>();

        // 根据流程的业务ID查询实体并关联
        for (Task task : getTodoTasks(userId, WorkflowNames.fileInfo)) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsFileInfo info = topicManager.getFileInfo(new Long(businessKey));
            info.setTask(task);
            info.setProcessInstance(processInstance);
            info.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(info);
        }

        return results;
    }

    @Transactional(readOnly = true)
    public void fillRunningTask(NewsTopic topic) {
        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
        listRunning.addAll(runtimeService.createProcessInstanceQuery().
            processDefinitionKey(WorkflowNames.topicNew).active().orderByProcessInstanceId().desc().list());
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            if (topic.getId().equals(new Long(businessKey))) {
                List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().
                        orderByTaskCreateTime().desc().list();
                topic.setTask(tasks.get(0));
                topic.setProcessInstance(processInstance);
                topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                break;
            }
        }
    }

    @Transactional(readOnly = true)
    public int getTodoTasksCount(String userId) {
        return getTodoTasks(userId, WorkflowNames.topicNew).size() +
                getTodoTasks(userId, WorkflowNames.fileInfo).size();
    }

    private void FillRunningTask(List<NewsTopic> result) {
        //  填充running task
        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
        listRunning.addAll(runtimeService.createProcessInstanceQuery().
                processDefinitionKey(WorkflowNames.topicNew).active().orderByProcessInstanceId().desc().list());
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            for (NewsTopic topic : result) {
                if (topic.getId().equals(new Long(businessKey))) {
                    List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().
                            orderByTaskCreateTime().desc().list();
                    topic.setTask(tasks.get(0));
                    topic.setProcessInstance(processInstance);
                    topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                    break;
                }
            }
        }
    }

    @Transactional(readOnly = true)
    public List<NewsTopic> getAllTopics() {
        ArrayList<NewsTopic> result = new ArrayList<NewsTopic>();
        for (NewsTopic topic : topicManager.getAllTopics()) {
            result.add(topic);
        }

        FillRunningTask(result);

        return result;
    }

    @Transactional(readOnly = true)
    public List<NewsTopic> getArchivedTopics() {
        ArrayList<NewsTopic> result = new ArrayList<NewsTopic>();
        for (NewsTopic topic : topicManager.getArchivedTopics()) {
            result.add(topic);
        }

        FillRunningTask(result);

        return result;
    }

    @Transactional(readOnly = true)
    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
        return repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
    }

    @Transactional(readOnly = true)
    public Boolean isFinished(NewsTopic topic) {
        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
        listRunning.addAll(runtimeService.createProcessInstanceQuery().
                processDefinitionKey(WorkflowNames.topicNew).active().orderByProcessInstanceId().desc().list());
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            if (topic.getId().equals(new Long(businessKey)))
                return false;
        }

        return true;
    }

    @Autowired
    public void setTopicManager(TopicManager topicManager) {
        this.topicManager = topicManager;
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
    public void setHistoryService(HistoryService historyService) {
        this.historyService = historyService;
    }

    @Autowired
    public void setRepositoryService(RepositoryService repositoryService) {
        this.repositoryService = repositoryService;
    }
}
