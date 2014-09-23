package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.*;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.*;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.WebUtil;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ArticleController
 *
 * Created by patchao2000 on 14-6-27.
 */
@Controller
@RequestMapping(value = "/news/article")
public class ArticleController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected ArticleManager articleManager;

    @Autowired
    protected UserManager userManager;

    @Autowired
    protected ArticleWorkflowService workflowService;

    @Autowired
    protected ColumnService columnService;

    @Autowired
    protected TopicManager topicManager;

    @Autowired
    protected VideoManager videoManager;

    @Autowired
    protected RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected IdentityService identityService;

    private void addSelectOptions(Model model, User user) {
        model.addAttribute("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        model.addAttribute("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_CAMERAMAN)));
        model.addAttribute("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        model.addAttribute("columns", userColumns);

        List<NewsVideo> videoList = new ArrayList<NewsVideo>();
        for (NewsColumn column : userColumns) {
            for(NewsVideo video : videoManager.findByColumnId(column.getId())) {
                videoList.add(video);
            }
        }
        model.addAttribute("videos", videoList);
    }

    private void makeCreateArticleModel(Model model, User user, NewsArticle article) {
        addSelectOptions(model, user);

        model.addAttribute("article", article);
        model.addAttribute("title", "创建文稿");
        model.addAttribute("createMode", true);
    }

    @RequestMapping(value = {"apply"})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        if (!userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_WRITE) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_1) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_2) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_3)) {
            redirectAttributes.addFlashAttribute("error", "您没有撰写文稿权限！");
            return "redirect:/main/welcome";
        }
        if (columnService.getUserColumns(user).size() == 0) {
            redirectAttributes.addFlashAttribute("error", "您没有任何栏目权限！");
            return "redirect:/main/welcome";
        }

        NewsArticle article = new NewsArticle();
        makeCreateArticleModel(model, user, article);
        return "/news/article/view";
    }

    @RequestMapping(value = {"apply-topic/{topicId}"}, method = {RequestMethod.POST, RequestMethod.GET})
    public String createFromTopic(@PathVariable("topicId") Long topicId,
                                  Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        if (!userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_WRITE) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_1) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_2) &&
                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_3)) {
            redirectAttributes.addFlashAttribute("error", "您没有撰写文稿权限！");
            return "redirect:/main/welcome";
        }
        if (columnService.getUserColumns(user).size() == 0) {
            redirectAttributes.addFlashAttribute("error", "您没有任何栏目权限！");
            return "redirect:/main/welcome";
        }

        NewsTopic topic = topicManager.getTopic(topicId);
        NewsArticle article = new NewsArticle();
        makeCreateArticleModel(model, user, article);
        article.setMainTitle(topic.getTitle());
        article.setContent("<p>" + topic.getContent() + "</p>");
        article.setCameramen(topic.getCameramen());
        article.setReporters(topic.getReporters());

        return "/news/article/view";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startArticleWorkflow(@ModelAttribute("article") @Valid NewsArticle article, BindingResult bindingResult,
                                       Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);
            if (user == null)
                return UserUtil.redirectTimeoutString;

            if (bindingResult.hasErrors()) {
                logger.debug("has bindingResult errors!");

                makeCreateArticleModel(model, user, article);
                return "/news/article/view";
            }

            article.setUserId(user.getId());

            Map<String, Object> variables = new HashMap<String, Object>();
            logger.debug("startWorkflow: title {} content {} column {}", article.getMainTitle(), article.getContent(), article.getColumnId());

            //  set audit level for each column
            NewsColumn column = columnService.getColumn(article.getColumnId());
            variables.put("needAudit1", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_1) != 0));
            variables.put("needAudit2", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_2) != 0));
            variables.put("needAudit3", ((column.getAuditLevel() & NewsColumn.AUDIT_LEVEL_3) != 0));

            ProcessInstance processInstance = workflowService.startArticleWorkflow(article, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
            } else {
                logger.error("启动选题流程失败：", e);
                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
            }
        } catch (Exception e) {
            logger.error("启动选题流程失败：", e);
            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
        }
        return "redirect:/news/article/apply";
    }

    @RequestMapping(value = "detail/{id}")
    @ResponseBody
    public NewsArticle getArticle(@PathVariable("id") Long id) {
        return articleManager.getArticle(id);
    }

    @RequestMapping(value = "detail-with-vars/{id}/{taskId}")
    @ResponseBody
    public NewsArticle getArticleWithVars(@PathVariable("id") Long id, @PathVariable("taskId") String taskId) {
        NewsArticle article = articleManager.getArticle(id);
        Map<String, Object> variables = taskService.getVariables(taskId);
        article.setVariables(variables);
        return article;
    }


    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/article/taskList");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<ArticleDetail> list = new ArrayList<ArticleDetail>();
        for (NewsArticle article : workflowService.findTodoTasks(userId)) {
            ArticleDetail detail = new ArticleDetail();
            detail.setUserName(userManager.getUserById(article.getUserId()).getFirstName());
            detail.setArticle(article);
            detail.setColumnName(columnService.getColumn(article.getColumnId()).getName());
            detail.setPlainContent(WebUtil.stringMaxLength(WebUtil.htmlRemoveTag(article.getContent()), 20));
            list.add(detail);
        }
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "count/task", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String complete(HttpSession session) {
        try {
            String userId = UserUtil.getUserFromSession(session).getId();
            Integer count = workflowService.getTodoTasksCount(userId);
            logger.debug("todo task count: {}", count);
            return count.toString();
        } catch (Exception e) {
            logger.error("error on get todo task count!");
            return "error";
        }
    }

//    @RequestMapping(value = "list/running")
//    public ModelAndView runningList() {
//        ModelAndView mav = new ModelAndView("/news/article/running");
//        List<NewsArticle> list = workflowService.findRunningProcessInstances();
//        mav.addObject("list", list);
//        return mav;
//    }

    @RequestMapping(value = "list/all")
    public ModelAndView allList(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/article/allarticles");
        List<ArticleDetail> list = new ArrayList<ArticleDetail>();
        for (NewsArticle article : workflowService.getAllArticles()) {
            ArticleDetail detail = new ArticleDetail();
            detail.setUserName(userManager.getUserById(article.getUserId()).getFirstName());
            detail.setArticle(article);
            detail.setColumnName(columnService.getColumn(article.getColumnId()).getName());
            detail.setPlainContent(WebUtil.stringMaxLength(WebUtil.htmlRemoveTag(article.getContent()), 20));
            list.add(detail);
        }
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "audit/{id}/{taskId}/{taskKey}", method = {RequestMethod.POST, RequestMethod.GET})
    public String auditArticle(@PathVariable("id") Long id, @PathVariable("taskId") String taskId, @PathVariable("taskKey") String taskKey,
                               Model model, HttpSession session) {

        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        addSelectOptions(model, user);

        NewsArticle article = articleManager.getArticle(id);
        model.addAttribute("article", article);
        model.addAttribute("title", "审核文稿");
        model.addAttribute("readonly", true);
        model.addAttribute("auditMode", true);
        model.addAttribute("taskId", taskId);
        model.addAttribute("taskKey", taskKey);

        return "/news/article/view";
    }

    @RequestMapping(value = "reapply/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyArticle(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model, HttpSession session) {

        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        addSelectOptions(model, user);

        NewsArticle article = articleManager.getArticle(id);
        model.addAttribute("article", article);
        model.addAttribute("title", "修改文稿内容");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("taskId", taskId);

        return "/news/article/view";
    }

    @RequestMapping(value = "view/{id}")
    public ModelAndView viewArticle(@PathVariable("id") Long id, HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/article/view");
        NewsArticle article = articleManager.getArticle(id);
        mav.addObject("article", article);

        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        mav.addObject("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_CAMERAMAN)));
        mav.addObject("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));
//        mav.addObject("columns", columnService.getUserColumns(user));

        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        mav.addObject("columns", userColumns);

        List<NewsVideo> videoList = new ArrayList<NewsVideo>();
        for (NewsColumn column : userColumns) {
            for(NewsVideo video : videoManager.findByColumnId(column.getId())) {
                videoList.add(video);
            }
        }
        mav.addObject("videos", videoList);

        mav.addObject("title", "查看文稿");
        mav.addObject("readonly", true);
        mav.addObject("contentReadonly", true);

        return mav;
    }

    @RequestMapping(value = "task/claim/{id}")
    @ResponseBody
    public String claim(@PathVariable("id") String taskId, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String userId = UserUtil.getUserFromSession(session).getId();
            taskService.claim(taskId, userId);
            logger.debug("claim task {}", taskId);
            return "success";
//            redirectAttributes.addFlashAttribute("message", "任务已签收");
//            return "redirect:/news/article/list/task";
        } catch (Exception e) {
            logger.error("error on claim task {}, {}", taskId, e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "complete/{id}", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String complete(@PathVariable("id") String taskId, @RequestBody Map<String, Object> articleMap) {
        try {
            taskService.complete(taskId, articleMap);
            logger.debug("complete: task {}, variables={}", new Object[]{taskId, articleMap});
            return "success";
        } catch (Exception e) {
            logger.error("error on complete task {}, variables={}, error: {}", taskId, articleMap, e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "objlist/histories/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<NewsArticleHistory> getArticleHistories(@PathVariable("id") Long articleId) {
        List<NewsArticleHistory> list = articleManager.getArticleContentHistories(articleId);
        for (NewsArticleHistory history : list) {
            User user = userManager.getUserById(history.getUserId());
            String userName = (user == null ? "用户" + history.getUserId().toString() : user.getFirstName());
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            history.setDisplayTitle(format.format(history.getTime()) + " - 由" + userName + "修改");
        }
        return list;
    }

    @RequestMapping(value = "history/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public NewsArticleHistory getArticleHistory(@PathVariable("id") Long historyId) {
        return articleManager.getArticleHistory(historyId);
    }

}