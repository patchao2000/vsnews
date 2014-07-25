package com.videostar.vsnews.web.news;

import com.videostar.vsnews.service.news.ArticleManager;
import com.videostar.vsnews.service.news.TopicManager;
import com.videostar.vsnews.service.news.TopicWorkflowService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * ArticleController
 *
 * Created by patchao2000 on 14-6-27.
 */
@Controller
@RequestMapping(value = "/news/article")
public class ArticleController {

//    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected ArticleManager articleManager;

    @Autowired
    protected TopicWorkflowService workflowService;

    @Autowired
    protected RuntimeService runtimeService;

    @Autowired
    protected TaskService taskService;

    @Autowired
    protected IdentityService identityService;

    @RequestMapping(value = {"articleEdit", ""})
    public String createForm(Model model) {
//        model.addAttribute("topic", new Topic());
        return "/news/article/articleEdit";
    }
}