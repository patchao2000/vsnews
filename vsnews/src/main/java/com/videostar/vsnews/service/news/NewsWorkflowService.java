package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsEntity;
import com.videostar.vsnews.entity.oa.Leave;
import com.videostar.vsnews.util.Page;
import org.activiti.engine.*;
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

/**
 * NewsWorkflowService
 *
 * Created by patchao2000 on 14-6-5.
 */
@Component
@Transactional
public class NewsWorkflowService {

    private static Logger logger = LoggerFactory.getLogger(NewsWorkflowService.class);

    private TopicManager topicManager;

    private RuntimeService runtimeService;

    protected TaskService taskService;

    protected HistoryService historyService;

    protected RepositoryService repositoryService;

    @Autowired
    protected IdentityService identityService;

    private List<Task> findTasks(String bpmn, String userId, int[] pageParams) {
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(bpmn).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoList = todoQuery.listPage(pageParams[0], pageParams[1]);

        // 根据当前人未签收的任务
        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(bpmn).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasks = claimQuery.listPage(pageParams[0], pageParams[1]);

        // 合并
        tasks.addAll(todoList);
        tasks.addAll(unsignedTasks);
        return tasks;
    }

    /**
     * 查询待办任务
     */
    @Transactional(readOnly = true)
    public List<NewsEntity> findTodoTasks(String userId, Page<NewsEntity> page, int[] pageParams) {
        List<NewsEntity> results = new ArrayList<NewsEntity>();
        List<Task> tasks = findTasks("topic", userId, pageParams);
//        logger.error("findTodoTasks: tasks {}", tasks.size());

        // 根据流程的业务ID查询实体并关联
        for (Task task : tasks) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsEntity topic = topicManager.getTopic(new Long(businessKey));
            topic.setTask(task);
            topic.setProcessInstance(processInstance);
            topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(topic);
        }

//        page.setTotalCount(todoQuery.count() + claimQuery.count());
        page.setTotalCount(tasks.size());
        page.setResult(results);
        return results;
    }

    /**
     * 读取运行中的流程
     *
     * @return
     */
    @Transactional(readOnly = true)
    public List<NewsEntity> findRunningProcessInstaces(Page<NewsEntity> page, int[] pageParams) {
        List<NewsEntity> results = new ArrayList<NewsEntity>();
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().processDefinitionKey("topic").active().orderByProcessInstanceId().desc();
        List<ProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);

        // 关联业务实体
        for (ProcessInstance processInstance : list) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsEntity leave = topicManager.getTopic(new Long(businessKey));
            leave.setProcessInstance(processInstance);
            leave.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(leave);

            // 设置当前任务信息
            List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().orderByTaskCreateTime().desc().listPage(0, 1);
            leave.setTask(tasks.get(0));
        }

        page.setTotalCount(query.count());
        page.setResult(results);
        return results;
    }

    /**
     * 查询流程定义对象
     */
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
