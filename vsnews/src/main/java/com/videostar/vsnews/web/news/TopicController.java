package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.Topic;
import com.videostar.vsnews.service.news.TopicManager;
import com.videostar.vsnews.service.news.TopicWorkflowService;
import com.videostar.vsnews.util.UserUtil;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
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

    @RequestMapping(value = {"apply", ""})
    public String createForm(Model model) {
        model.addAttribute("topic", new Topic());
        return "/news/topic/topicApply";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startWorkflow(Topic topic, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);
            // 用户未登录不能操作
            if (user == null || StringUtils.isBlank(user.getId())) {
                return "redirect:/login?timeout=true";
            }
            topic.setUserId(user.getId());
            Map<String, Object> variables = new HashMap<String, Object>();
            ProcessInstance processInstance = workflowService.startWorkflow(topic, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
//                redirectAttributes.addFlashAttribute("error", "没有部署流程，请在[工作流]->[流程管理]页面点击<重新部署流程>");
            } else {
                logger.error("启动请假流程失败：", e);
                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
            }
        } catch (Exception e) {
            logger.error("启动请假流程失败：", e);
            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
        }
        return "redirect:/news/topic/apply";
    }
}
