package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.entity.news.NewsStoryboard;
import com.videostar.vsnews.entity.news.NewsVideo;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.ColumnService;
import com.videostar.vsnews.service.news.StoryboardManager;
import com.videostar.vsnews.service.news.TopicManager;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.WebUtil;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    protected StoryboardManager storyboardManager;

    @Autowired
    protected TopicManager topicManager;

    private void addSelectOptions(Model model, User user) {
        model.addAttribute("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        model.addAttribute("columns", userColumns);
    }

    private void makeCreateStoryboardModel(Model model, User user, NewsStoryboard entity) {
        addSelectOptions(model, user);

        model.addAttribute("storyboard", entity);
        model.addAttribute("title", "创建串联单");
        model.addAttribute("createMode", true);
    }

    @RequestMapping(value = {"apply"})
    public String createForm(Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return UserUtil.redirectTimeoutString;

//        if (!userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_WRITE) &&
//                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_1) &&
//                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_2) &&
//                !userManager.isUserHaveRights(user, UserManager.RIGHTS_ARTICLE_AUDIT_3)) {
//            redirectAttributes.addFlashAttribute("error", "您没有撰写文稿权限！");
//            return "redirect:/main/welcome";
//        }
        if (columnService.getUserColumns(user).size() == 0) {
            redirectAttributes.addFlashAttribute("error", "您没有任何栏目权限！");
            return "redirect:/main/welcome";
        }

        NewsStoryboard entity = new NewsStoryboard();
        makeCreateStoryboardModel(model, user, entity);
        return "/news/storyboard/view";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String saveStoryboard(@ModelAttribute("storyboard") @Valid NewsStoryboard entity, BindingResult bindingResult,
                                   Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User user = UserUtil.getUserFromSession(session);
            if (user == null)
                return UserUtil.redirectTimeoutString;

            if (bindingResult.hasErrors()) {
                logger.debug("has bindingResult errors!");

                makeCreateStoryboardModel(model, user, entity);
                return "/news/storyboard/view";
            }

            entity.setAuthorUserId(user.getId());
            storyboardManager.saveStoryboard(entity);
            redirectAttributes.addFlashAttribute("message", "串联单已保存");
        } catch (Exception e) {
            logger.error("保存串联单失败：", e);
            redirectAttributes.addFlashAttribute("error", "系统内部错误！");
        }
        return "redirect:/news/storyboard/apply";
    }

    @RequestMapping(value = "list/all")
    public ModelAndView allList(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/storyboard/allstoryboards");
        List<StoryboardDetail> list = new ArrayList<StoryboardDetail>();
        for (NewsStoryboard entity : storyboardManager.getAllStoryboards()) {
            StoryboardDetail detail = new StoryboardDetail();
            detail.setUserName(userManager.getUserById(entity.getAuthorUserId()).getFirstName());
            detail.setStoryboard(entity);
            detail.setColumnName(columnService.getColumn(entity.getColumnId()).getName());
            list.add(detail);
        }
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "view/{id}")
    public ModelAndView viewStoryboard(@PathVariable("id") Long id, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/storyboard/view");
        NewsStoryboard entity = storyboardManager.getStoryboard(id);
        mav.addObject("storyboard", entity);

        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        mav.addObject("columns", userColumns);

        mav.addObject("title", "查看串联单");
        mav.addObject("readonly", true);

        return mav;
    }

    @RequestMapping(value = "edit/{id}")
    public ModelAndView editStoryboard(@PathVariable("id") Long id, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null)
            return new ModelAndView(UserUtil.redirectTimeoutString);

        ModelAndView mav = new ModelAndView("/news/storyboard/edit");
        NewsStoryboard entity = storyboardManager.getStoryboard(id);
        mav.addObject("storyboard", entity);
        mav.addObject("editors", userManager.getGroupMembers(userManager.getUserRightsName(UserManager.RIGHTS_EDITOR)));
        List<NewsColumn> userColumns = columnService.getUserColumns(user);
        mav.addObject("columns", userColumns);
        mav.addObject("title", "编辑串联单");
        mav.addObject("topics", topicManager.getAllTopics());

        return mav;
    }

}
