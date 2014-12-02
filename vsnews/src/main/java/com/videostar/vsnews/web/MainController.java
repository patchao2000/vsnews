package com.videostar.vsnews.web;

import com.videostar.vsnews.entity.news.NewsMessage;
import com.videostar.vsnews.service.news.MessageManager;
import com.videostar.vsnews.util.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 首页控制器
 */

@Controller
@RequestMapping("/main")
public class MainController {

    @Autowired
    protected MessageManager messageManager;

    @RequestMapping(value = "/index")
    public String index() {
        return "/main/index";
    }

    @RequestMapping(value = "/welcome")
    public ModelAndView welcome(HttpSession session) {
        ModelAndView mav = new ModelAndView("/main/welcome");
        String userId = UserUtil.getUserFromSession(session).getId();

        List<NewsMessage> list = messageManager.getUnreadMessagesByReceiverId(userId);
        mav.addObject("list", list);
        if (list.size() == 0)
            mav.addObject("nomessages", true);
        return mav;
    }

    @RequestMapping(value = "/test")
    public String test() {
        return "/main/test";
    }

}
