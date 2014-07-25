package com.videostar.vsnews.service.news;

//import com.videostar.vsnews.dao.ActivitiDao;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
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
import com.videostar.vsnews.util.Page;
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
    public ProcessInstance startTopicWriteWorkflow(NewsTopic entity, Map<String, Object> variables) {
        topicManager.saveTopic(entity);
        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.topicWrite, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.topicWrite, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    public ProcessInstance startTopicDispatchWorkflow(NewsTopic entity, Map<String, Object> variables) {
        topicManager.saveTopic(entity);
        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.topicDispatch, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.topicDispatch, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    @Transactional(readOnly = true)
    public List<NewsTopic> findTodoTasks(String userId, Page<NewsTopic> page, int[] pageParams) {
        List<NewsTopic> results = new ArrayList<NewsTopic>();
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQueryWrite = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.topicWrite).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoListWrite = todoQueryWrite.listPage(pageParams[0], pageParams[1]);
        TaskQuery todoQueryDispatch = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.topicDispatch).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoListDispatch = todoQueryDispatch.listPage(pageParams[0], pageParams[1]);

        // 根据当前人未签收的任务
        TaskQuery claimQueryWrite = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.topicWrite).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasksWrite = claimQueryWrite.listPage(pageParams[0], pageParams[1]);
        TaskQuery claimQueryDispatch = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.topicDispatch).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasksDispatch = claimQueryDispatch.listPage(pageParams[0], pageParams[1]);

        // 合并
        tasks.addAll(todoListWrite);
        tasks.addAll(todoListDispatch);
        tasks.addAll(unsignedTasksWrite);
        tasks.addAll(unsignedTasksDispatch);

        // 根据流程的业务ID查询实体并关联
        for (Task task : tasks) {
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

        page.setTotalCount(todoQueryWrite.count() + claimQueryWrite.count() + todoQueryDispatch.count() + claimQueryDispatch.count());
        page.setResult(results);
        return results;
    }

    @Transactional(readOnly = true)
    public List<NewsTopic> findRunningProcessInstaces(Page<NewsTopic> page, int[] pageParams) {
        List<NewsTopic> results = new ArrayList<NewsTopic>();
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().processDefinitionKey(WorkflowNames.topicWrite).active().orderByProcessInstanceId().desc();
        List<ProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);

        // 关联业务实体
        for (ProcessInstance processInstance : list) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsTopic topic = topicManager.getTopic(new Long(businessKey));
            topic.setProcessInstance(processInstance);
            topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(topic);

            // 设置当前任务信息
            List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().orderByTaskCreateTime().desc().listPage(0, 1);
            topic.setTask(tasks.get(0));
        }

        page.setTotalCount(query.count());
        page.setResult(results);
        return results;
    }
    
    @Transactional(readOnly = true)
    public List<NewsTopic> findFinishedProcessInstaces(Page<NewsTopic> page, int[] pageParams) {
        List<NewsTopic> results = new ArrayList<NewsTopic>();
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().processDefinitionKey(WorkflowNames.topicWrite).finished().orderByProcessInstanceEndTime().desc();
        List<HistoricProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);

        // 关联业务实体
        for (HistoricProcessInstance historicProcessInstance : list) {
            String businessKey = historicProcessInstance.getBusinessKey();
            NewsTopic topic = topicManager.getTopic(new Long(businessKey));
            topic.setProcessDefinition(getProcessDefinition(historicProcessInstance.getProcessDefinitionId()));
            topic.setHistoricProcessInstance(historicProcessInstance);
            results.add(topic);
        }
        page.setTotalCount(query.count());
        page.setResult(results);
        return results;
    }

//    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true)
    public List<NewsTopic> getAllTopics() {
        ArrayList<NewsTopic> result = new ArrayList<NewsTopic>();
        for (NewsTopic topic : topicManager.getAllTopics()) {
            result.add(topic);
        }
        return result;
    }

    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
        return repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
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
