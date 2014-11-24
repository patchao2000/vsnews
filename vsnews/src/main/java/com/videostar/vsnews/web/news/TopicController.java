package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.*;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.*;
import com.videostar.vsnews.util.*;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
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
import java.util.*;


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

    @Autowired
    protected StoryboardManager storyboardManager;

    @Autowired
    protected ArticleManager articleManager;

    @Autowired
    protected LogManager logManager;

    @SuppressWarnings("unchecked")
    private List<User> getDispatchersList() {
        List<User> result = new ArrayList<User>();
        HashSet<String> hs = new HashSet<String>();
        for (User user : userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TOPIC_WRITE))) {
            hs.add(user.getId());
        }
        for (User user : userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TOPIC_AUDIT))) {
            hs.add(user.getId());
        }
        for (String userId : hs) {
            result.add(userManager.getUserById(userId));
        }

        ComparatorUser cu = new ComparatorUser();
        Collections.sort(result, cu);

        return result;
    }
    private void addSelectOptions(Model model) {
        model.addAttribute("others", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_USER)));
        model.addAttribute("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TECHNICIAN)));
        model.addAttribute("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));
        //  有选题撰写和审核权限者都可进行派遣
        model.addAttribute("dispatchers", getDispatchersList());
    }

    private void makeCreateTopicModel(Model model, NewsTopic topic) {
        addSelectOptions(model);

        model.addAttribute("topic", topic);
        model.addAttribute("title", "创建选题");
        model.addAttribute("createMode", true);
    }

    @RequestMapping(value = {"apply", ""})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);

        if(!userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_WRITE) &&
           !userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT)) {
            redirectAttributes.addFlashAttribute("error", "您没有撰写选题权限！");
            return "redirect:/main/welcome";
        }

        NewsTopic topic = new NewsTopic();
        topic.setDispatcher(user.getId());
        makeCreateTopicModel(model, topic);
        if (!userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT)) {
            model.addAttribute("dispatcherReadonly", true);
        }

        return "/news/topic/view";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startTopicNewWorkflow(@ModelAttribute("topic") @Valid NewsTopic topic, BindingResult bindingResult,
                                          Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);

            if (bindingResult.hasErrors()) {
                logger.debug("has bindingResult errors!");

                makeCreateTopicModel(model, topic);
                return "/news/topic/view";
            }

            topic.setUserId(user.getId());
            topic.setStatus(NewsTopic.STATUS_BEGIN_AUDIT);

            //  check user is in leader(topicAudit) group
            Boolean isLeader = userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT);

            Map<String, Object> variables = new HashMap<String, Object>();
            logger.debug("startWorkflow: title {} content {} devices {}", topic.getTitle(), topic.getContent(), topic.getDevices());
            variables.put("needDevices", !topic.getDevices().isEmpty());
            variables.put("leaderStart", isLeader);
            if (isLeader) {
                variables.put("dispatcher", topic.getDispatcher());
            }

            ProcessInstance processInstance = workflowService.startTopicNewWorkflow(topic, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());

            logManager.addLog(user.getId(), "发起选题流程", "ID: " + topic.getId() + "  标题: " + topic.getTitle());

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

    private String startFileInfoWorkflow(NewsFileInfo entity, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);

            entity.setUserId(user.getId());
            entity.setStatus(NewsFileInfo.STATUS_BEGIN_AUDIT);

            Map<String, Object> variables = new HashMap<String, Object>();

            logger.debug("start fileinfo Workflow: {}", entity.getId());

            ProcessInstance processInstance = workflowService.startFileInfoWorkflow(entity, variables);
            redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID：" + processInstance.getId());

            logManager.addLog(user.getId(), "发起文件流程", "ID: " + entity.getId() + "  文件: " + entity.getFilePath());

            return "success";
        } catch (ActivitiException e) {
            if (e.getMessage().contains("no processes deployed with key")) {
                logger.warn("没有部署流程!", e);
            } else {
                logger.error("启动串联单流程失败：", e);
                redirectAttributes.addFlashAttribute("error", "系统内部错误！");
            }
        } catch (Exception e) {
            logger.error("启动串联单流程失败：", e);
            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
        }

        return "error";
    }

    @RequestMapping(value = "start-fileinfo-id/{id}")
    @ResponseBody
    public String startFileInfoWorkflowFromId(@PathVariable("id") Long id, RedirectAttributes redirectAttributes, HttpSession session) {

        NewsFileInfo entity = topicManager.getFileInfo(id);
        return startFileInfoWorkflow(entity, redirectAttributes, session);
    }

    @RequestMapping(value = "start-fileinfo-args/{id}/{type}/{title}/{status}/{filepath}/{length}")
    @ResponseBody
    public String startFileInfoWorkflowFromArgs(@PathVariable("id") Long id, @PathVariable("type") int type,
            @PathVariable("title") String title, @PathVariable("status") int status,
            @PathVariable("filepath") String filepath, @PathVariable("length") String length,
            RedirectAttributes redirectAttributes, HttpSession session) {

        NewsTopic topic = topicManager.getTopic(id);
        NewsFileInfo info = new NewsFileInfo();
        info.setFilePath(filepath);
        info.setType(type);
        info.setTitle(title);
        info.setStatus(status);
//        String userId = UserUtil.getUserFromSession(session).getId();
//        info.setUserId(userId);
        info.setAddedTime(new Date());
        info.setLengthTC(length);
        topicManager.addFileToTopic(topic, info);

        return startFileInfoWorkflow(info, redirectAttributes, session);
    }

    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/topic/taskList");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<TopicTaskDetail> list = new ArrayList<TopicTaskDetail>();

        for (NewsTopic topic : workflowService.findTopicTodoTasks(userId)) {
            TopicTaskDetail detail = new TopicTaskDetail();
            detail.setIsFileInfoTask(false);
            detail.setUserName(userManager.getUserById(topic.getUserId()).getFirstName());
            detail.setTopic(topic);
            String dispatcher = topic.getDispatcher();
            if (dispatcher != null) {
                detail.setDispatcherName(userManager.getUserById(dispatcher).getFirstName());
            }
            detail.setTask(topic.getTask());
            detail.setProcessInstance(topic.getProcessInstance());
            list.add(detail);
        }

        for (NewsFileInfo info : workflowService.findFileInfoTodoTasks(userId)) {
            TopicTaskDetail detail = new TopicTaskDetail();
            detail.setIsFileInfoTask(true);
            detail.setUserName(userManager.getUserById(info.getUserId()).getFirstName());
            detail.setFileInfo(info);
            detail.setTask(info.getTask());
            detail.setProcessInstance(info.getProcessInstance());
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
            int count = workflowService.getTodoTasksCount(userId);
            logger.debug("todo task count: {}", count);
            return String.valueOf(count);
        } catch (Exception e) {
            logger.error("error on get todo task count!");
            return "error";
        }
    }

    @RequestMapping(value = "list/all")
    public ModelAndView allList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/topic/alltopics");
        List<TopicTaskDetail> list = new ArrayList<TopicTaskDetail>();
        for (NewsTopic topic : workflowService.getAllTopics()) {
            TopicTaskDetail detail = new TopicTaskDetail();
            detail.setIsFileInfoTask(false);
            detail.setUserName(userManager.getUserById(topic.getUserId()).getFirstName());
            detail.setTopic(topic);
            String dispatcher = topic.getDispatcher();
            if (dispatcher != null) {
                detail.setDispatcherName(userManager.getUserById(dispatcher).getFirstName());
            }
            list.add(detail);
        }

        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "count/need-job", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String needJobCount(HttpSession session) {
        try {
            String userId = UserUtil.getUserFromSession(session).getId();
            Integer count = storyboardManager.getTopicsNeedJob(userId).size();
            logger.debug("need job count: {}", count);
            return count.toString();
        } catch (Exception e) {
            logger.error("error on get need job count!");
            return "error";
        }
    }

    @RequestMapping(value = "list/need-job")
    public ModelAndView needJobList(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);

        ModelAndView mav = new ModelAndView("/news/topic/need-job");
        List<TopicTaskDetail> list = new ArrayList<TopicTaskDetail>();
        for (NewsTopic topic : storyboardManager.getTopicsNeedJob(user.getId())) {

            workflowService.fillRunningTask(topic);

            TopicTaskDetail detail = new TopicTaskDetail();
            detail.setIsFileInfoTask(false);
            detail.setUserName(userManager.getUserById(topic.getUserId()).getFirstName());
            detail.setTopic(topic);
            String dispatcher = topic.getDispatcher();
            if (dispatcher != null) {
                detail.setDispatcherName(userManager.getUserById(dispatcher).getFirstName());
            }
            detail.setAvFileReady(topicManager.haveVideoFiles(topic) || topicManager.haveAudioFiles(topic));
            NewsArticle article = articleManager.findByTopicUuid(topic.getUuid());
            detail.setArticleReady(article != null);
            if (article != null) {
                detail.setArticleId(article.getId());
            }

            list.add(detail);
        }

        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "audit/{id}/{taskId}/{taskKey}", method = {RequestMethod.POST, RequestMethod.GET})
    public String auditTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId, @PathVariable("taskKey") String taskKey,
                             Model model, HttpSession session) {
        addSelectOptions(model);

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
                             Model model) {
        addSelectOptions(model);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "审核选题设备");
        model.addAttribute("readonly", true);
        model.addAttribute("dispatcherReadonly", true);
        model.addAttribute("auditMode", false);
        model.addAttribute("auditDeviceMode", true);
        model.addAttribute("taskId", taskId);
        model.addAttribute("taskKey", taskKey);

        return "/news/topic/view";
    }

    @RequestMapping(value = "reapply/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);

        addSelectOptions(model);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "修改选题内容");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("modifyDeviceOnly", false);
        model.addAttribute("taskId", taskId);
        if (!userManager.isUserHaveRights(user, UserManager.RIGHTS_TOPIC_AUDIT)) {
            model.addAttribute("dispatcherReadonly", true);
        }

        return "/news/topic/view";
    }

    @RequestMapping(value = "reapply-device/{id}/{taskId}", method = {RequestMethod.POST, RequestMethod.GET})
    public String reapplyDeviceTopic(@PathVariable("id") Long id, @PathVariable("taskId") String taskId,
                               Model model) {
        addSelectOptions(model);

        NewsTopic topic = topicManager.getTopic(id);
        model.addAttribute("topic", topic);
        model.addAttribute("title", "修改选题设备");
        model.addAttribute("reapplyMode", true);
        model.addAttribute("modifyDeviceOnly", true);
        model.addAttribute("taskId", taskId);
        model.addAttribute("readonly", true);
        model.addAttribute("dispatcherReadonly", true);

        return "/news/topic/view";
    }

    @RequestMapping(value = "view/{id}")
    public ModelAndView viewTopic(@PathVariable("id") Long id, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);

        ModelAndView mav = new ModelAndView("/news/topic/view");
        NewsTopic topic = topicManager.getTopic(id);
        mav.addObject("topic", topic);

        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        mav.addObject("cameramen", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_TECHNICIAN)));
        mav.addObject("reporters", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_REPORTER)));
        //  有选题撰写和审核权限者都可进行派遣
        mav.addObject("dispatchers", getDispatchersList());

        mav.addObject("title", "查看选题");
        mav.addObject("readonly", true);
        mav.addObject("dispatcherReadonly", true);

        NewsArticle article = articleManager.findByTopicUuid(topic.getUuid());
        if (article != null) {
            mav.addObject("viewArticle", true);
            mav.addObject("articleId", article.getId());
        }
        else {
            if (userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_WRITE)) {
                if (workflowService.isFinished(topic)) {
                    mav.addObject("createArticle", true);
                }
            }
        }

        return mav;
    }

    @RequestMapping(value = "task/claim/{id}")
    @ResponseBody
    public String claim(@PathVariable("id") String taskId, HttpSession session) {
        try {
            String userId = UserUtil.getUserFromSession(session).getId();
            taskService.claim(taskId, userId);
            logger.debug("claim task {}", taskId);

            Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
            logManager.addLog(session, "认领任务", "ID: " + taskId + "  描述: " + task.getName());

            return "success";
//        redirectAttributes.addFlashAttribute("message", "任务已签收");
//        return "redirect:/news/topic/list/task";
        } catch (Exception e) {
            logger.error("error on claim task {}, {}", taskId, e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "detail/{id}")
    @ResponseBody
    public NewsTopic getTopic(@PathVariable("id") Long id) {
        return topicManager.getTopic(id);
    }

    @RequestMapping(value = "detail/fileinfo/{id}")
    @ResponseBody
    public NewsFileInfo getFileInfo(@PathVariable("id") Long id) {
        return topicManager.getFileInfo(id);
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

    @RequestMapping(value = "complete/{id}", method = {RequestMethod.POST, RequestMethod.GET}, consumes="application/json")
    @ResponseBody
    public String complete(@PathVariable("id") String taskId, @RequestBody Map<String, Object> topicMap,
                           HttpSession session) {
        try {
            Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
            logManager.addLog(session, "完成任务", "ID: " + taskId + "  描述: " + task.getName());

            taskService.complete(taskId, topicMap);
            logger.debug("complete: task {}, variables={}", new Object[]{taskId, topicMap});
            return "success";
        } catch (Exception e) {
            logger.error("error on complete task {}, variables={}", taskId, topicMap);
            return "error";
        }
    }

    @RequestMapping(value = "add-file/{id}/{type}/{title}/{status}/{filepath}/{length}")
    @ResponseBody
    public String addFile(@PathVariable("id") Long id, @PathVariable("type") int type,
                          @PathVariable("title") String title, @PathVariable("status") int status,
                          @PathVariable("filepath") String filepath, @PathVariable("length") String length,
                          HttpSession session) {
        try {
            NewsTopic topic = topicManager.getTopic(id);
            NewsFileInfo info = new NewsFileInfo();
            info.setFilePath(filepath);
            info.setType(type);
            info.setTitle(title);
            info.setStatus(status);
            String userId = UserUtil.getUserFromSession(session).getId();
            info.setUserId(userId);
            info.setAddedTime(new Date());
            info.setLengthTC(length);
            topicManager.addFileToTopic(topic, info);

            logger.debug("file added to topic {}", filepath);
            logManager.addLog(session, "添加选题文件", "ID: " + topic.getId() + "  描述: " + filepath);
            return "success";
        } catch (Exception e) {
            logger.debug("error on file added to topic {}", filepath);
            return "error";
        }
    }

    @RequestMapping(value = "edit-file/{id}/{fileId}/{title}/{status}/{filepath}/{length}")
    @ResponseBody
    public String editFile(@PathVariable("id") Long id, @PathVariable("fileId") Long fileId,
                          @PathVariable("title") String title, @PathVariable("status") int status,
                          @PathVariable("filepath") String filepath, @PathVariable("length") String length,
                          HttpSession session) {
        try {
            NewsTopic topic = topicManager.getTopic(id);
            topicManager.editTopicFile(topic, fileId, title, filepath, status, length);

            logger.debug("topic file edited {}", fileId);
            logManager.addLog(session, "编辑选题文件", "ID: " + topic.getId() + "  描述: " + filepath);
            return "success";
        } catch (Exception e) {
            logger.debug("error on edit topic file{}", fileId);
            return "error";
        }
    }

    @RequestMapping(value = "remove-file/{id}/{fileId}")
    @ResponseBody
    public String removeFile(@PathVariable("id") Long id, @PathVariable("fileId") Long fileId,
                             HttpSession session) {
        try {
            NewsTopic topic = topicManager.getTopic(id);
            topicManager.removeFileFromTopic(topic, fileId);

            logger.debug("file removed from topic {}", fileId);
            logManager.addLog(session, "删除选题文件", "ID: " + topic.getId() + "  文件ID: " + fileId);
            return "success";
        } catch (Exception e) {
            logger.debug("error on file remove from topic {}", fileId);
            return "error";
        }
    }
    @RequestMapping(value = "view/files/{id}")
    public ModelAndView viewFiles(@PathVariable("id") Long id, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);

        ModelAndView mav = new ModelAndView("/news/topic/fileList");
        NewsTopic topic = topicManager.getTopic(id);
        mav.addObject("topic", topic);

        List<String> materialFiles = SambaUtil.getFiles();
        mav.addObject("materialFiles", materialFiles);

        List<FileInfoDetail> list = new ArrayList<FileInfoDetail>();
        int videoCount = 0, audioCount = 0;
        for (NewsFileInfo info : topicManager.getTopicFiles(topic)) {
            FileInfoDetail detail = new FileInfoDetail();
            detail.setNewsFileInfo(info);
            detail.setUserName(userManager.getUserById(info.getUserId()).getFirstName());
            if (info.getType() == 0) {
                detail.setFileTypeName("视频素材");
                videoCount++;
            }
            else if (info.getType() == 1) {
                detail.setFileTypeName("音频素材");
                audioCount++;
            }
            list.add(detail);
        }
        mav.addObject("list", list);
        if(userManager.isUserHaveRights(user, UserManager.RIGHTS_ADMIN)) {
            mav.addObject("isAdmin", true);
        }

        mav.addObject("videoCount", videoCount);
        mav.addObject("audioCount", audioCount);

        return mav;
    }

}
