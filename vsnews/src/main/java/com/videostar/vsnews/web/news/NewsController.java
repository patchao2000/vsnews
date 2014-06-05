package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsEntity;
import com.videostar.vsnews.entity.oa.Leave;
import com.videostar.vsnews.service.news.NewsWorkflowService;
import com.videostar.vsnews.util.Page;
import com.videostar.vsnews.util.PageUtil;
import com.videostar.vsnews.util.UserUtil;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * NewsController
 *
 * Created by patchao2000 on 14-6-5.
 */
@Controller
@RequestMapping(value = "/news")
public class NewsController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected NewsWorkflowService workflowService;

    @Autowired
    protected RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    /**
     * 任务列表
     */
    @RequestMapping(value = "list/task")
    public ModelAndView taskList(HttpSession session, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/taskList");
        Page<NewsEntity> page = new Page<NewsEntity>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);

        String userId = UserUtil.getUserFromSession(session).getId();
        workflowService.findTodoTasks(userId, page, pageParams);
        mav.addObject("page", page);
        return mav;
    }

    /**
     * 读取运行中的流程实例
     */
    @RequestMapping(value = "list/running")
    public ModelAndView runningList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/news/running");
        Page<NewsEntity> page = new Page<NewsEntity>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        workflowService.findRunningProcessInstaces(page, pageParams);
        mav.addObject("page", page);
        return mav;
    }
}
