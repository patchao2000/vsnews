package com.videostar.vsnews.service.news;

import com.videostar.vsnews.constants.WorkflowNames;
import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsColumn;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
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
 * ArticleWorkflowService
 *
 * Created by patchao2000 on 14-7-27.
 */
@Component
@Transactional
public class ArticleWorkflowService {

    private static Logger logger = LoggerFactory.getLogger(ArticleWorkflowService.class);

    @Autowired
    private ArticleManager articleManager;

    @Autowired
    private ColumnManager columnManager;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected RepositoryService repositoryService;

    @Autowired
    private IdentityService identityService;

    public ProcessInstance startArticleWorkflow(NewsArticle entity, Map<String, Object> variables) {
        articleManager.saveArticle(entity);
        logger.debug("save entity: {}", entity);
        String businessKey = entity.getId().toString();

        //  set audit level for each column
        NewsColumn column = columnManager.getColumn(entity.getColumnId());
        variables.put("needAudit1", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_1) != 0));
        variables.put("needAudit2", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_2) != 0));
        variables.put("needAudit3", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_3) != 0));

        ProcessInstance processInstance = null;
        try {
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(entity.getUserId());

            processInstance = runtimeService.startProcessInstanceByKey(WorkflowNames.article123, businessKey, variables);
            String processInstanceId = processInstance.getId();
            entity.setProcessInstanceId(processInstanceId);
            logger.debug("start process of {key={}, bkey={}, pid={}, variables={}}", WorkflowNames.article123, businessKey, processInstanceId, variables);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return processInstance;
    }

    @Transactional(readOnly = true)
    public List<NewsArticle> findTodoTasks(String userId) {
        List<NewsArticle> results = new ArrayList<NewsArticle>();
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.article123).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoList = todoQuery.list();

        // 根据当前人未签收的任务
        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.article123).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> unsignedTasks = claimQuery.list();

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
            NewsArticle article = articleManager.getArticle(new Long(businessKey));
            article.setTask(task);
            article.setProcessInstance(processInstance);
            article.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
            results.add(article);
        }

        return results;
    }

    @Transactional(readOnly = true)
    public List<NewsArticle> getAllArticles() {
        ArrayList<NewsArticle> result = new ArrayList<NewsArticle>();
        for (NewsArticle article : articleManager.getAllArticles()) {
            result.add(article);
        }
        return result;
    }

    protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
        return repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
    }
    
//    @Autowired
//    public void setArticleManager(ArticleManager articleManager) {
//        this.articleManager = articleManager;
//    }
//
//    @Autowired
//    public void setRuntimeService(RuntimeService runtimeService) {
//        this.runtimeService = runtimeService;
//    }
//
//    @Autowired
//    public void setTaskService(TaskService taskService) {
//        this.taskService = taskService;
//    }
//
//    @Autowired
//    public void setRepositoryService(RepositoryService repositoryService) {
//        this.repositoryService = repositoryService;
//    }
}
