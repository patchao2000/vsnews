package com.videostar.vsnews.web.system;

import com.google.common.collect.Lists;
import com.videostar.vsnews.entity.news.NewsLog;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * LogController
 *
 * Created by patchao2000 on 14/11/24.
 */
@Controller
@RequestMapping("/news/system/log")
public class LogController {

    @Autowired
    LogManager logManager;

    @Autowired
    UserManager userManager;

    @RequestMapping(value = "/list")
    public ModelAndView logList(HttpSession session) {
        ModelAndView mav = new ModelAndView("/news/system/allLogs");

        List<LogDetail> list = new ArrayList<LogDetail>();
        for (NewsLog log : logManager.getAllLogs()) {
            LogDetail detail = new LogDetail();
            detail.setUserName(userManager.getUserById(log.getUserId()).getFirstName());
            detail.setLog(log);
            list.add(detail);
        }

        mav.addObject("list", list);

        return mav;
    }
}
