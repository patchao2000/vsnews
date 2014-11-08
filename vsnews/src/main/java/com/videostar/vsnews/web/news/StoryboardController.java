package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.*;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.*;
import com.videostar.vsnews.util.ConfigXmlReader;
import com.videostar.vsnews.util.SambaUtil;
import com.videostar.vsnews.util.TimeCode;
import com.videostar.vsnews.util.UserUtil;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.TaskService;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * StoryboardController
 *
 * Created by patchao2000 on 14-9-23.
 */
@Controller
@RequestMapping(value = "/news/storyboard")
public class StoryboardController {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected UserManager userManager;

    @Autowired
    protected ColumnService columnService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected ArticleManager articleManager;

    @Autowired
    protected ArticleWorkflowService articleWorkflowService;

    @Autowired
    protected StoryboardManager storyboardManager;

    @Autowired
    protected StoryboardWorkflowService workflowService;

    @Autowired
    protected TopicManager topicManager;

    private void addSelectOptions(Model model, User user) {
        model.addAttribute("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        model.addAttribute("technicians", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TECHNICIAN)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        model.addAttribute("columns", userColumns);
    }

    private void makeCreateStoryboardTemplateModel(Model model, User user, NewsStoryboardTemplate entity) {
        addSelectOptions(model, user);

        model.addAttribute("storyboardTemplate", entity);
        model.addAttribute("title", "创建串联单模板");
        model.addAttribute("createMode", true);
    }

    @RequestMapping(value = {"apply-template"})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        if(!userManager.isUserHaveRights(user, UserManager.RIGHTS_STORYBOARD_WRITE) &&
            !userManager.isUserHaveRights(user, UserManager.RIGHTS_STORYBOARD_AUDIT)) {
            redirectAttributes.addFlashAttribute("error", "您没有创建串联单权限！");
            return "redirect:/main/welcome";
        }

        if (columnService.getUserColumns(user).size() == 0) {
            redirectAttributes.addFlashAttribute("error", "您没有任何栏目权限！");
            return "redirect:/main/welcome";
        }

        NewsStoryboardTemplate entity = new NewsStoryboardTemplate();
        makeCreateStoryboardTemplateModel(model, user, entity);
        return "/news/storyboard/view-template";
    }

    @RequestMapping(value = "start-template", method = RequestMethod.POST)
    public String startStoryboardTemplateWorkflow(@ModelAttribute("storyboardTemplate") @Valid NewsStoryboardTemplate entity,
                                          BindingResult bindingResult,
                                          Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);
            if (user == null)
                return UserUtil.redirectTimeoutString;

            if (bindingResult.hasErrors()) {
                logger.debug("has bindingResult errors!");

                makeCreateStoryboardTemplateModel(model, user, entity);
                return "/news/storyboard/view-template";
            }

            entity.setUserId(user.getId());

            Map<String, Object> variables = new HashMap<String, Object>();
            logger.debug("start storyboard Workflow: title {}", entity.getTitle());

            ProcessInstance processInstance = workflowService.startStoryboardTemplateWorkflow(entity, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
            } else {
                logger.error("启动串联单模板流程失败：", e);
                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
            }
        } catch (Exception e) {
            logger.error("启动串联单模板流程失败：", e);
            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
        }
        return "redirect:/news/storyboard/apply-template";
    }

    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/storyboard/taskList");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<StoryboardTaskDetail> list = new ArrayList<StoryboardTaskDetail>();
        for (NewsStoryboardTemplate entity : workflowService.findTemplateTodoTasks(userId)) {
            StoryboardTaskDetail detail = new StoryboardTaskDetail();
            detail.setUserName(userManager.getUserById(entity.getUserId()).getFirstName());
            detail.setTemplate(entity);
            detail.setColumnName(columnService.getColumn(entity.getColumnId()).getName());
            detail.setTask(entity.getTask());
            detail.setProcessInstance(entity.getProcessInstance());
            detail.setTitle(entity.getTitle());
            detail.setEntityId(entity.getId());
            detail.setIsTemplateTask(true);
            list.add(detail);
        }

        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "count/task", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String todoCount(HttpSession session) {
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

    @RequestMapping(value = "list/template/all")
    public ModelAndView allTemplatesList(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/storyboard/all-templates");
        List<StoryboardTaskDetail> list = new ArrayList<StoryboardTaskDetail>();
        for (NewsStoryboardTemplate entity : workflowService.getAllTemplates()) {
            StoryboardTaskDetail detail = new StoryboardTaskDetail();
            detail.setUserName(userManager.getUserById(entity.getUserId()).getFirstName());
            detail.setTemplate(entity);
            detail.setColumnName(columnService.getColumn(entity.getColumnId()).getName());
            detail.setTask(entity.getTask());
            detail.setProcessInstance(entity.getProcessInstance());
            detail.setTitle(entity.getTitle());
            detail.setEntityId(entity.getId());
            detail.setIsTemplateTask(true);
            list.add(detail);
        }
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "audit/template/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String auditStoryboardTemplate(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                             Model model, HttpSession session) {

        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        addSelectOptions(model, user);

        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(id);
        model.addAttribute("storyboardTemplate", entity);
        model.addAttribute("title", "审核串联单模板");
        model.addAttribute("readonly", true);
        model.addAttribute("auditMode", true);
        model.addAttribute("taskId", taskId);

        return "/news/storyboard/view-template";
    }

    @RequestMapping(value = "reapply/template/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyStoryboardTemplate(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model, HttpSession session) {

        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

        addSelectOptions(model, user);

        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(id);
        model.addAttribute("storyboardTemplate", entity);
        model.addAttribute("title", "修改串联单模板内容");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("taskId", taskId);

        return "/news/storyboard/view-template";
    }

    @RequestMapping(value = "complete/{id}", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String complete(@PathVariable("id") String taskId, @RequestBody Map<String, Object> topicMap) {
        try {
            taskService.complete(taskId, topicMap);
            logger.debug("complete: task {}, variables={}", new Object[]{taskId, topicMap});
            return "success";
        } catch (Exception e) {
            logger.error("error on complete task {}, variables={}", taskId, topicMap);
            return "error";
        }
    }

    @RequestMapping(value = "detail-with-vars/template/{id}/{taskId}")
    @ResponseBody
    public NewsStoryboardTemplate getStoryboardTemplateWithVars(@PathVariable("id") Long id, @PathVariable("taskId") String taskId) {
        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(id);
        Map<String, Object> variables = taskService.getVariables(taskId);
        entity.setVariables(variables);
        logger.debug("detail-with-vars variables={}", variables);
        return entity;
    }

    @RequestMapping(value = "task/claim/{id}")
    @ResponseBody
    public String claim(@PathVariable("id") String taskId, HttpSession session) {
        try {
            String userId = UserUtil.getUserFromSession(session).getId();
            taskService.claim(taskId, userId);
            logger.debug("claim task {}", taskId);
            return "success";
        } catch (Exception e) {
            logger.error("error on claim task {}, {}", taskId, e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "view/template/{id}")
    public ModelAndView viewStoryboardTemplate(@PathVariable("id") Long id, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/storyboard/view-template");
        NewsStoryboardTemplate entity = storyboardManager.getStoryboardTemplate(id);
        mav.addObject("storyboardTemplate", entity);
        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        mav.addObject("technicians", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TECHNICIAN)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        mav.addObject("columns", userColumns);
        mav.addObject("title", "查看串联单模板");
        mav.addObject("readonly", true);

        return mav;
    }

//
//    @RequestMapping(value = "edit/{id}")
//    public ModelAndView editStoryboard(@PathVariable("id") Long id, HttpSession session) {
//        User user = UserUtil.getUserFromSession(session);
//        if (user == null)
//            return new ModelAndView(UserUtil.redirectTimeoutString);
//
//        ModelAndView mav = new ModelAndView("/news/storyboard/edit");
//        NewsStoryboard entity = storyboardManager.getStoryboard(id);
//        mav.addObject("storyboard", entity);
//        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
//        mav.addObject("technicians", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TECHNICIAN)));
//        List<NewsColumn> userColumns = columnService.getUserColumns(user);
//        mav.addObject("columns", userColumns);
//        mav.addObject("title", "编辑串联单");
//        mav.addObject("alltopics", topicManager.getAllTopics());
//        mav.addObject("sambaPath", SambaUtil.getWindowsSambaPath());
//
//        List<TopicInfoDetail> topics = new ArrayList<TopicInfoDetail>();
//        TimeCode total = new TimeCode(0);
//        for (NewsTopicInfo info : entity.getTopics()) {
//            TopicInfoDetail detail = new TopicInfoDetail();
//            detail.setOrderValue(info.getOrderValue());
//            detail.setTopicUuid(info.getTopicUuid());
//            NewsTopic topic = topicManager.getTopic(info.getTopicUuid());
//            detail.setTopic(topic);
//
////            detail.setVideoFileReady(topicManager.haveVideoFiles(topic));
//            detail.setVideoStatus(topicManager.getVideoFileStatus(topic));
//            detail.setVideoFilePath(topicManager.getVideoFilePath(topic));
////            detail.setAudioFileReady(topicManager.haveAudioFiles(topic));
//            detail.setAudioStatus(topicManager.getAudioFileStatus(topic));
//            NewsArticle article = articleManager.findByTopicUuid(topic.getUuid());
//            detail.setArticle(article);
//            if (article != null) {
//                articleWorkflowService.fillRunningTask(article);
//            }
//
//            TimeCode videoLength = topicManager.getVideoFileLength(topic);
//            detail.setVideoLength(videoLength.toString());
//            total.add(videoLength);
//            detail.setTotalLength(total.toString());
//            detail.setArticleLength(articleManager.getArticleLength(article).toString());
//
//            topics.add(detail);
//        }
//        mav.addObject("topics", topics);
//
//        return mav;
//    }
//
//    @RequestMapping(value = "lock/{id}")
//    @ResponseBody
//    public String lock(@PathVariable("id") Long id, HttpSession session) {
//        try {
//            String userId = UserUtil.getUserFromSession(session).getId();
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() != null) {
//                logger.error("NewsStoryboard already locked by {}", entity.getLockerUserId());
//                return "error";
//            }
//            storyboardManager.lockStoryboard(entity, userId);
//            logger.debug("NewsStoryboard locked by {}", userId);
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on lock NewsStoryboard");
//            return "error";
//        }
//    }
//
//    @RequestMapping(value = "unlock/{id}")
//    @ResponseBody
//    public String unlock(@PathVariable("id") Long id) {
//        try {
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() == null) {
//                logger.error("NewsStoryboard is not locked");
//                return "error";
//            }
//            storyboardManager.unlockStoryboard(entity);
//            logger.debug("NewsStoryboard unlocked");
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on unlock NewsStoryboard");
//            return "error";
//        }
//    }
//
//    @RequestMapping(value = "addtopic/{id}/{uuid}")
//    @ResponseBody
//    public String addTopic(@PathVariable("id") Long id, @PathVariable("uuid") String uuid, HttpSession session) {
//        try {
//            String userId = UserUtil.getUserFromSession(session).getId();
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() == null) {
//                logger.error("NewsStoryboard is not locked");
//                return "error";
//            }
//            if (!entity.getLockerUserId().equals(userId)) {
//                logger.error("NewsStoryboard is not locked by {}", userId);
//                return "error";
//            }
//
//            storyboardManager.addTopic(entity, uuid);
//            logger.debug("topic added to NewsStoryboard");
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on add topic to NewsStoryboard");
//            return "error";
//        }
//    }
//
//    @RequestMapping(value = "topicup/{id}/{topicindex}")
//    @ResponseBody
//    public String topicUp(@PathVariable("id") Long id, @PathVariable("topicindex") int index, HttpSession session) {
//        try {
//            String userId = UserUtil.getUserFromSession(session).getId();
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() == null) {
//                logger.error("NewsStoryboard is not locked");
//                return "error";
//            }
//            if (!entity.getLockerUserId().equals(userId)) {
//                logger.error("NewsStoryboard is not locked by {}", userId);
//                return "error";
//            }
//
//            storyboardManager.topicUp(entity, index);
//            logger.debug("topic moved up");
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on topic move up");
//            return "error";
//        }
//    }
//
//    @RequestMapping(value = "topicdown/{id}/{topicindex}")
//    @ResponseBody
//    public String topicDown(@PathVariable("id") Long id, @PathVariable("topicindex") int index, HttpSession session) {
//        try {
//            String userId = UserUtil.getUserFromSession(session).getId();
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() == null) {
//                logger.error("NewsStoryboard is not locked");
//                return "error";
//            }
//            if (!entity.getLockerUserId().equals(userId)) {
//                logger.error("NewsStoryboard is not locked by {}", userId);
//                return "error";
//            }
//
//            storyboardManager.topicDown(entity, index);
//            logger.debug("topic moved down");
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on topic move down");
//            return "error";
//        }
//    }
//
//    @RequestMapping(value = "topicremove/{id}/{topicindex}")
//    @ResponseBody
//    public String topicRemove(@PathVariable("id") Long id, @PathVariable("topicindex") int index, HttpSession session) {
//        try {
//            String userId = UserUtil.getUserFromSession(session).getId();
//            NewsStoryboard entity = storyboardManager.getStoryboard(id);
//            if (entity.getLockerUserId() == null) {
//                logger.error("NewsStoryboard is not locked");
//                return "error";
//            }
//            if (!entity.getLockerUserId().equals(userId)) {
//                logger.error("NewsStoryboard is not locked by {}", userId);
//                return "error";
//            }
//
//            storyboardManager.topicRemove(entity, index);
//            logger.debug("topic removed");
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on topic remove");
//            return "error";
//        }
//    }

}
