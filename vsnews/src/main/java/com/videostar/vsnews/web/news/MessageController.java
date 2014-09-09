package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.entity.news.NewsMessage;
import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.MessageManager;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.WebUtil;
import com.videostar.vsnews.web.identify.UserDetail;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
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
 * MessageController
 *
 * Created by patchao2000 on 14-9-8.
 */

@Controller
@RequestMapping(value = "/news/message")
public class MessageController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected MessageManager messageManager;

    @Autowired
    protected UserManager userManager;

    private static final String redirectTimeoutString = "redirect:/login?timeout=true";

    private User getCurrentUser(HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null || StringUtils.isBlank(user.getId()))
            return null;
        return user;
    }
    private void makeMessageModel(Model model, NewsMessage message) {
        model.addAttribute("msg", message);

        UserQuery query = userManager.createUserQuery();
        List<UserDetail> detailList = new ArrayList<UserDetail>();
        for (User user : query.list()) {
            UserDetail detail = new UserDetail(user.getId(), user.getFirstName(), user.getLastName(),
                    user.getEmail(), user.getPassword());
            detailList.add(detail);
        }
        model.addAttribute("userList", detailList);
    }

    @RequestMapping(value = {"apply"})
    public String createForm(Model model) {

        NewsMessage message = new NewsMessage();
        makeMessageModel(model, message);

        return "/news/message/view";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String startArticleWorkflow(@ModelAttribute("msg") @Valid NewsMessage message, BindingResult bindingResult,
                                       Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        if (bindingResult.hasErrors()) {
            logger.debug("has bindingResult errors!");
            makeMessageModel(model, message);

            return "/news/message/view";
        }

        User user = getCurrentUser(session);
        if (user == null)
            return redirectTimeoutString;

        message.setSenderId(user.getId());
        messageManager.saveMessage(message);

        redirectAttributes.addFlashAttribute("message", "留言已成功发送!");
        return "redirect:/news/message/apply";
    }

    @RequestMapping(value = "list/sent")
    public ModelAndView sentList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/message/list");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<NewsMessage> list = messageManager.getMessagesBySenderId(userId);
        mav.addObject("list", list);
        mav.addObject("title", "我发送的留言");
        return mav;
    }

    @RequestMapping(value = "list/inbox")
    public ModelAndView inboxList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/message/list");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<NewsMessage> list = messageManager.getMessagesByReceiverId(userId);
        mav.addObject("list", list);
        mav.addObject("title", "我接收的留言");
        return mav;
    }
}
