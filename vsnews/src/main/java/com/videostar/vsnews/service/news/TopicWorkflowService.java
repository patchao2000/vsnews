package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.Topic;
import com.videostar.vsnews.util.Page;
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

/**
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
     * @param entity
     */
    public ProcessInstance startWorkflow(Topic entity, Map<String, Object> variables) {
        topicManager.saveTopic(entity);
        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey("topic", businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", new Object[]{"topic", businessKey, processInstanceId, variables});
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    @Transactional(readOnly = true)
    public List<Topic> findTodoTasks(String userId, Page<Topic> page, int[] pageParams) {
        List<Topic> results = new ArrayList<Topic>();
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey("topic").taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoList = todoQuery.listPage(pageParams[0], pageParams[1]);

        // 根据当前人未签收的任务
        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey("topic").taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasks = claimQuery.listPage(pageParams[0], pageParams[1]);

        // 合并
        tasks.addAll(todoList);
        tasks.addAll(unsignedTasks);

        // 根据流程的业务ID查询实体并关联
        for (Task task : tasks) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            Topic leave = topicManager.getTopic(new Long(businessKey));
            leave.setTask(task);
            leave.setProcessInstance(processInstance);
            leave.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(leave);
        }

        page.setTotalCount(todoQuery.count() + claimQuery.count());
        page.setResult(results);
        return results;
    }

    @Transactional(readOnly = true)
    public List<Topic> findRunningProcessInstaces(Page<Topic> page, int[] pageParams) {
        List<Topic> results = new ArrayList<Topic>();
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().processDefinitionKey("topic").active().orderByProcessInstanceId().desc();
        List<ProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);

        // 关联业务实体
        for (ProcessInstance processInstance : list) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            Topic topic = topicManager.getTopic(new Long(businessKey));
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
    public List<Topic> findFinishedProcessInstaces(Page<Topic> page, int[] pageParams) {
        List<Topic> results = new ArrayList<Topic>();
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().processDefinitionKey("leave").finished().orderByProcessInstanceEndTime().desc();
        List<HistoricProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);

        // 关联业务实体
        for (HistoricProcessInstance historicProcessInstance : list) {
            String businessKey = historicProcessInstance.getBusinessKey();
            Topic leave = topicManager.getTopic(new Long(businessKey));
            leave.setProcessDefinition(getProcessDefinition(historicProcessInstance.getProcessDefinitionId()));
            leave.setHistoricProcessInstance(historicProcessInstance);
            results.add(leave);
        }
        page.setTotalCount(query.count());
        page.setResult(results);
        return results;
    }

    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
        return processDefinition;
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
