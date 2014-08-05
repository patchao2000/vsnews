package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.TopicManager;
import com.videostar.vsnews.service.news.TopicWorkflowService;
import com.videostar.vsnews.util.*;
import org.activiti.engine.ActivitiException;
//import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
//import org.activiti.engine.identity.Group;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
//import java.util.List;
import java.util.List;
import java.util.Map;

/**
 * NewsTopic manager
 *
 * Created by patchao2000 on 14-6-4.
 */
@Controller
@RequestMapping(value = "/news/topic")
public class TopicController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected TopicManager topicManager;

    @Autowired
    protected TopicWorkflowService workflowService;

    @Autowired
    protected RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected UserManager userManager;

    private static final String redirectTimeoutString = "redirect:/login?timeout=true";

    private User getCurrentUser(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null || StringUtils.isBlank(user.getId()))
            return null;
        return user;
    }

    private void addSelectOptions(Model model, User user) {
        model.addAttribute("others", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_USER)));
        model.addAttribute("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_CAMERAMAN)));
        model.addAttribute("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));
    }

    private void makeCreateTopicModel(Model model, User user, NewsTopic topic) {
        addSelectOptions(model, user);

        model.addAttribute("topic", topic);
        model.addAttribute("title", "创建选题");
        model.addAttribute("createMode", true);
    }

    @RequestMapping(value = {"apply", ""})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        if(!userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_WRITE) &&
           !userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT)) {
            redirectAttributes.addFlashAttribute("error", "您没有撰写选题权限！");
            return "redirect:/main/welcome";
        }

        NewsTopic topic = new NewsTopic();
        makeCreateTopicModel(model, user, topic);

        return "/news/topic/view";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startTopicWriteWorkflow(@ModelAttribute("topic") @Valid NewsTopic topic, BindingResult bindingResult,
                                          Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = getCurrentUser(session);
            if (user == null)
                return redirectTimeoutString;

            if (bindingResult.hasErrors()) {
                logger.debug("has bindingResult errors!");

                makeCreateTopicModel(model, user, topic);
                return "/news/topic/view";
            }

            topic.setUserId(user.getId());

            //  check user is in leader(topicAudit) group
            Boolean isLeader = userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT);

            Map<String, Object> variables = new HashMap<String, Object>();
            logger.debug("startWorkflow: title {} content {} devices {}", topic.getTitle(), topic.getContent(), topic.getDevices());
            variables.put("needDevices", !topic.getDevices().isEmpty());
            variables.put("leaderStart", isLeader);

            ProcessInstance processInstance = workflowService.startTopicWriteWorkflow(topic, variables);
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
        return "redirect:/news/topic/apply";
    }

    @RequestMapping(value = "dispatch/{topicid}/{userid}")
    @ResponseBody
    public String startTopicDispatchWorkflow(@PathVariable("topicid") Long topicId, @PathVariable("userid") String userId,
                                             HttpSession session) {
        try {
            NewsTopic topic = topicManager.getTopic(topicId);
            logger.debug("before start dispatch workflow topic id {}", topic.getId());

            User user = getCurrentUser(session);
            if (user == null)
                return "error";

            if (topic.getStatus() != NewsTopic.STATUS_WRITTEN) {
                logger.error("NewsTopic status wrong: {}", topic.getStatus());
//                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
                return "error";
            }

            topic.setStatus(NewsTopic.STATUS_DISPATCHING);
            topic.setUserId(user.getId());

            Map<String, Object> variables = new HashMap<String, Object>();
            variables.put("dispatcher", userId);
            logger.debug("startTopicDispatchWorkflow: title {} content {} devices {}", topic.getTitle(), topic.getContent(), topic.getDevices());

            ProcessInstance processInstance = workflowService.startTopicDispatchWorkflow(topic, variables);
//            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
            } else {
                logger.error("启动选题流程失败：", e);
//                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
                return "error";
            }
        } catch (Exception e) {
            logger.error("启动选题流程失败：", e);
//            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
            return "error";
        }
//        return "redirect:/news/topic/list/all";
        return "success";
    }

    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/topic/taskList");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<TopicDetail> list = new ArrayList<TopicDetail>();
        for (NewsTopic topic : workflowService.findTodoTasks(userId)) {
            TopicDetail detail = new TopicDetail();
            detail.setUserName(userManager.getUserById(topic.getUserId()).getFirstName());
            detail.setTopic(topic);
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
//    public ModelAndView runningList(HttpServletRequest request) {
//        ModelAndView mav = new ModelAndView("/news/topic/running");
//        Page<NewsTopic> page = new Page<NewsTopic>(PageUtil.PAGE_SIZE);
//        int[] pageParams = PageUtil.init(page, request);
//        workflowService.findRunningProcessInstaces(page, pageParams);
//        mav.addObject("page", page);
//        return mav;
//    }
//
//    @RequestMapping(value = "list/finished")
//    public ModelAndView finishedList(HttpServletRequest request) {
//        ModelAndView mav = new ModelAndView("/news/topic/finished");
//        Page<NewsTopic> page = new Page<NewsTopic>(PageUtil.PAGE_SIZE);
//        int[] pageParams = PageUtil.init(page, request);
//        workflowService.findFinishedProcessInstaces(page, pageParams);
//        mav.addObject("page", page);
//        return mav;
//    }

    @RequestMapping(value = "list/all")
    public ModelAndView allList(HttpSession session) {
        User user = getCurrentUser(session);
        if (user == null)
            return new ModelAndView(redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/topic/alltopics");
        List<TopicDetail> list = new ArrayList<TopicDetail>();
        for (NewsTopic topic : workflowService.getAllTopics()) {
            TopicDetail detail = new TopicDetail();
            detail.setUserName(userManager.getUserById(topic.getUserId()).getFirstName());
            detail.setTopic(topic);
            list.add(detail);
        }

        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "audit/{id}/{taskId}/{taskKey}", method = {RequestMethod.POST, RequestMethod.GET})
    public String auditTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId, @PathVariable("taskKey") String taskKey,
                             Model model, HttpSession session) {

        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        addSelectOptions(model, user);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "审核选题");
        model.addAttribute("readonly", true);
        model.addAttribute("auditMode", true);
        model.addAttribute("auditDeviceMode", false);
        model.addAttribute("taskId", taskId);
        model.addAttribute("taskKey", taskKey);

        return "/news/topic/view";
    }

    @RequestMapping(value = "audit-device/{id}/{taskId}/{taskKey}", method = {RequestMethod.POST, RequestMethod.GET})
    public String auditDeviceTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId, @PathVariable("taskKey") String taskKey,
                             Model model, HttpSession session) {

        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        addSelectOptions(model, user);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "审核选题设备");
        model.addAttribute("readonly", true);
        model.addAttribute("auditMode", false);
        model.addAttribute("auditDeviceMode", true);
        model.addAttribute("taskId", taskId);
        model.addAttribute("taskKey", taskKey);

        return "/news/topic/view";
    }

    @RequestMapping(value = "reapply/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model, HttpSession session) {

        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        addSelectOptions(model, user);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "修改选题内容");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("modifyDeviceOnly", false);
        model.addAttribute("taskId", taskId);

        return "/news/topic/view";
    }

    @RequestMapping(value = "reapply-device/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyDeviceTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model, HttpSession session) {

        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        addSelectOptions(model, user);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "修改选题设备");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("modifyDeviceOnly", true);
        model.addAttribute("taskId", taskId);
        model.addAttribute("readonly", true);

        return "/news/topic/view";
    }

    @RequestMapping(value = "view/{id}")
    public ModelAndView viewTopic(@PathVariable("id") Long id, HttpSession session) {
        User user = getCurrentUser(session);
        if (user == null)
            return new ModelAndView(redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/topic/view");
        NewsTopic topic = topicManager.getTopic(id);
        mav.addObject("topic", topic);

        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        mav.addObject("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_CAMERAMAN)));
        mav.addObject("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));

        mav.addObject("title", "查看选题");
        mav.addObject("readonly", true);
        if (userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_DISPATCH) &&
            topic.getStatus() == NewsTopic.STATUS_WRITTEN) {
            mav.addObject("dispatch", true);
            mav.addObject("dispatchers", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TOPIC_WRITE)));
        }
        if (userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_WRITE) &&
            topic.getStatus() == NewsTopic.STATUS_DISPATCHED) {
            mav.addObject("createArticle", true);
        }

        return mav;
    }

    @RequestMapping(value = "task/claim/{id}")
    public String claim(@PathVariable("id") String taskId, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = UserUtil.getUserFromSession(session).getId();
        taskService.claim(taskId, userId);
        redirectAttributes.addFlashAttribute("message", "任务已签收");
        return "redirect:/news/topic/list/task";
    }
    
    @RequestMapping(value = "detail/{id}")
    @ResponseBody
    public NewsTopic getTopic(@PathVariable("id") Long id) {
        return topicManager.getTopic(id);
    }

    @RequestMapping(value = "detail-with-vars/{id}/{taskId}")
    @ResponseBody
    public NewsTopic getTopicWithVars(@PathVariable("id") Long id, @PathVariable("taskId") String taskId) {
        NewsTopic topic = topicManager.getTopic(id);
        Map<String, Object> variables = taskService.getVariables(taskId);
        topic.setVariables(variables);
        logger.debug("detail-with-vars variables={}", variables);
        return topic;
    }

//    @RequestMapping(value = "oldcomplete/{id}", method = {RequestMethod.POST, RequestMethod.GET})
//    @ResponseBody
//    public String oldcomplete(@PathVariable("id") String taskId, Variable var) {
//        try {
//            Map<String, Object> variables = var.getVariableMap();
//            taskService.complete(taskId, variables);
//            logger.debug("complete: task {}, variables={}", new Object[]{taskId, var.getVariableMap()});
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on complete task {}, variables={}", new Object[]{taskId, var.getVariableMap(), e});
//            return "error";
//        }
//    }

    @RequestMapping(value = "complete/{id}", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String complete(@PathVariable("id") String taskId, @RequestBody Map<String, Object> topicMap) {
        try {
            taskService.complete(taskId, topicMap);
            logger.debug("complete: task {}, variables={}", new Object[]{taskId, topicMap});
            return "success";
        } catch (Exception e) {
            logger.error("error on complete task {}, variables={}", new Object[]{taskId, topicMap, e});
            return "error";
        }
    }
}
