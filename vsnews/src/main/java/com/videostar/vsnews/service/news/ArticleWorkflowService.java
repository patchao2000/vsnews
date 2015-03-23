package com.videostar.vsnews.service.news;

import com.videostar.vsnews.constants.WorkflowNames;
import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.service.identify.UserManager;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
//import org.activiti.engine.runtime.ProcessInstanceQuery;
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
    private UserManager userManager;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected RepositoryService repositoryService;

    @Autowired
    private IdentityService identityService;

    private Boolean isUserHaveColumnRights(String userId, NewsColumn column) {
        return userManager.isUserInGroup(userId, columnManager.getGroupId(column));
    }

    public ProcessInstance startArticleWorkflow(NewsArticle entity, Map<String, Object> variables) {
        articleManager.saveArticle(entity);
        logger.debug("save entity: {}", entity);

        //  apply initial content history
        articleManager.applyArticleHistory(entity.getUserId(), entity.getId(), "content", entity.getContent());

        String businessKey = entity.getId().toString();

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

    private List<Task> getTodoTasks(String userId) {
        List<Task> tasks = new ArrayList<Task>();

        // 根据当前人的ID查询
        TaskQuery todoQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.article123).taskAssignee(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        List<Task> todoList = todoQuery.list();

        // 根据当前人未签收的任务
        TaskQuery claimQuery = taskService.createTaskQuery().processDefinitionKey(WorkflowNames.article123).taskCandidateUser(userId).active().orderByTaskId().desc()
                .orderByTaskCreateTime().desc();
        //  过滤当前人无权访问的栏目
        List<Task> unsignedTasks = new ArrayList<Task>();
        for (Task task : claimQuery.list()) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsArticle article = articleManager.getArticle(new Long(businessKey));
            NewsColumn column = columnManager.getColumn(article.getColumnId());
            if (isUserHaveColumnRights(userId, column)) {
                unsignedTasks.add(task);
            }
        }

        // 合并
        tasks.addAll(todoList);
        tasks.addAll(unsignedTasks);

        return tasks;
    }

    @Transactional(readOnly = true)
    public List<NewsArticle> findTodoTasks(String userId) {
        List<NewsArticle> results = new ArrayList<NewsArticle>();

        // 根据流程的业务ID查询实体并关联
        for (Task task : getTodoTasks(userId)) {
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
    public int getTodoTasksCount(String userId) {
        return getTodoTasks(userId).size();
    }

//    @Transactional(readOnly = true)
//    public List<NewsArticle> findRunningProcessInstances() {
//        List<NewsArticle> results = new ArrayList<NewsArticle>();
//        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().processDefinitionKey(WorkflowNames.article123).active().orderByProcessInstanceId().desc();
//        List<ProcessInstance> list = query.list();
//
//        // 关联业务实体
//        for (ProcessInstance processInstance : list) {
//            String businessKey = processInstance.getBusinessKey();
//            if (businessKey == null) {
//                continue;
//            }
//            NewsArticle article = articleManager.getArticle(new Long(businessKey));
//            article.setProcessInstance(processInstance);
//            article.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
//            results.add(article);
//
//            // 设置当前任务信息
//            List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().orderByTaskCreateTime().desc().listPage(0, 1);
//            article.setTask(tasks.get(0));
//        }
//
//        return results;
//    }
    
    @Transactional(readOnly = true)
    public List<NewsArticle> getAllArticles() {
        ArrayList<NewsArticle> result = new ArrayList<NewsArticle>();

        for (NewsArticle article : articleManager.getAllArticles()) {
            result.add(article);
        }

        //  填充running task
        List<ProcessInstance> listRunning = runtimeService.createProcessInstanceQuery().
                processDefinitionKey(WorkflowNames.article123).active().orderByProcessInstanceId().desc().list();
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            for (NewsArticle article : result) {
                if (article.getId().equals(new Long(businessKey))) {
                    List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().
                            orderByTaskCreateTime().desc().list();
                    article.setTask(tasks.get(0));
                    article.setProcessInstance(processInstance);
                    article.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                    break;
                }
            }
        }

        return result;
    }

    //  填充running task
    public void fillRunningTask(NewsArticle article) {
        List<ProcessInstance> listRunning = runtimeService.createProcessInstanceQuery().
                processDefinitionKey(WorkflowNames.article123).active().orderByProcessInstanceId().desc().list();
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            if (article.getId().equals(new Long(businessKey))) {
                List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getId()).active().
                        orderByTaskCreateTime().desc().list();
                article.setTask(tasks.get(0));
                article.setProcessInstance(processInstance);
                article.setProcessDefinition(getProcessDefinition(processInstance.getProcessDefinitionId()));
                break;
            }
        }
    }

    @Transactional(readOnly = true)
    public Boolean isRunningUser(String userId) {
        List<ProcessInstance> listRunning = new ArrayList<ProcessInstance>();
        listRunning.addAll(runtimeService.createProcessInstanceQuery().
                processDefinitionKey(WorkflowNames.article123).active().orderByProcessInstanceId().desc().list());
        for (ProcessInstance processInstance : listRunning) {
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }
            NewsArticle article = articleManager.getArticle(new Long(businessKey));
            if (article.getUserId().equals(userId)) {
                return true;
            }
        }

        return false;
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
