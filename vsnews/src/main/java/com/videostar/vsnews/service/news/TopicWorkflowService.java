package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.Topic;
import org.activiti.engine.*;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

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

//
//    /**
//     * 读取运行中的流程
//     *
//     * @return
//     */
//    @Transactional(readOnly = true)
//    public List<Topic> findRunningProcessInstaces(Page<Topic> page, int[] pageParams) {
//        List<Topic> results = new ArrayList<Topic>();
//        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().processDefinitionKey("topic").active().orderByProcessInstanceId().desc();
//        List<ProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);
//
//        // 关联业务实体
//        for (ProcessInstance processInstance : list) {
//            String businessKey = processInstance.getBusinessKey();
//            if (businessKey == null) {
//                continue;
//            }
//            Topic topic = topicManager.getTopic(new Long(businessKey));
//            topic.setProcessInstance(processInstance);
//            topic.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
//            results.add(topic);
//
//            // 设置当前任务信息
//            List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().orderByTaskCreateTime().desc().listPage(0, 1);
//            topic.setTask(tasks.get(0));
//        }
//
//        page.setTotalCount(query.count());
//        page.setResult(results);
//        return results;
//    }
//
//    /**
//     * 读取已结束中的流程
//     *
//     * @return
//     */
//    @Transactional(readOnly = true)
//    public List<Topic> findFinishedProcessInstaces(Page<Topic> page, int[] pageParams) {
//        List<Topic> results = new ArrayList<Topic>();
//        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().processDefinitionKey("topic").finished().orderByProcessInstanceEndTime().desc();
//        List<HistoricProcessInstance> list = query.listPage(pageParams[0], pageParams[1]);
//
//        // 关联业务实体
//        for (HistoricProcessInstance historicProcessInstance : list) {
//            String businessKey = historicProcessInstance.getBusinessKey();
//            Topic topic = topicManager.getTopic(new Long(businessKey));
//            topic.setProcessDefinition(getProcessDefinition(historicProcessInstance.getProcessDefinitionId()));
//            topic.setHistoricProcessInstance(historicProcessInstance);
//            results.add(topic);
//        }
//        page.setTotalCount(query.count());
//        page.setResult(results);
//        return results;
//    }
//

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
