package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.Topic;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.TopicManager;
import com.videostar.vsnews.service.news.TopicWorkflowService;
import com.videostar.vsnews.util.Page;
import com.videostar.vsnews.util.PageUtil;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.Variable;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.Group;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Topic manager
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
//    protected IdentityService identityService;

    @RequestMapping(value = {"apply", ""})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null || StringUtils.isBlank(user.getId())) {
            return "redirect:/login?timeout=true";
        }

        if(!userManager.isUserInGroup(user.getId(), "topicWrite")) {
            redirectAttributes.addFlashAttribute("error", "您没有撰写选题权限！");
            return "redirect:/main/welcome";
        }
        model.addAttribute("topic", new Topic());
        return "/news/topic/topicApply";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startTopicWriteWorkflow(Topic topic, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            //  user must logged on first
            User user = UserUtil.getUserFromSession(session);
            if (user == null || StringUtils.isBlank(user.getId())) {
                return "redirect:/login?timeout=true";
            }
            topic.setUserId(user.getId());

            //  check user is in leader(topicAudit) group
            Boolean isLeader = userManager.isUserInGroup(user.getId(), "topicAudit");

            Map<String, Object> variables = new HashMap<String, Object>();
            logger.debug("startWorkflow: title {} content {} devices {}", topic.getTitle(), topic.getContent(), topic.getDevices());
            variables.put("needDevices", !topic.getDevices().isEmpty());
            variables.put("leaderStart", isLeader);

            ProcessInstance processInstance = workflowService.startTopicWriteWorkflow(topic, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
//                redirectAttributes.addFlashAttribute("error", "没有部署流程，请在[工作流]->[流程管理]页面点击<重新部署流程>");
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

    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/topic/taskList");
        Page<Topic> page = new Page<Topic>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);

        String userId = UserUtil.getUserFromSession(session).getId();
        workflowService.findTodoTasks(userId, page, pageParams);
        mav.addObject("page", page);
        return mav;
    }

    @RequestMapping(value = "list/running")
    public ModelAndView runningList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/topic/running");
        Page<Topic> page = new Page<Topic>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        workflowService.findRunningProcessInstaces(page, pageParams);
        mav.addObject("page", page);
        return mav;
    }

    @RequestMapping(value = "list/finished")
    public ModelAndView finishedList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/topic/finished");
        Page<Topic> page = new Page<Topic>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        workflowService.findFinishedProcessInstaces(page, pageParams);
        mav.addObject("page", page);
        return mav;
    }

    @RequestMapping(value = "list/all")
    public ModelAndView allList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/topic/alltopics");
        Page<Topic> page = new Page<Topic>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        workflowService.getAllTopics(page, pageParams);
        mav.addObject("page", page);
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
    public Topic getTopic(@PathVariable("id") Long id) {
        Topic topic = topicManager.getTopic(id);
        return topic;
    }

    @RequestMapping(value = "detail-with-vars/{id}/{taskId}")
    @ResponseBody
    public Topic getTopicWithVars(@PathVariable("id") Long id, @PathVariable("taskId") String taskId) {
        Topic topic = topicManager.getTopic(id);
        Map<String, Object> variables = taskService.getVariables(taskId);
        topic.setVariables(variables);
        return topic;
    }

    @RequestMapping(value = "oldcomplete/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String oldcomplete(@PathVariable("id") String taskId, Variable var) {
        try {
            Map<String, Object> variables = var.getVariableMap();
            taskService.complete(taskId, variables);
            logger.debug("complete: task {}, variables={}", new Object[]{taskId, var.getVariableMap()});
            return "success";
        } catch (Exception e) {
            logger.error("error on complete task {}, variables={}", new Object[]{taskId, var.getVariableMap(), e});
            return "error";
        }
    }

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
