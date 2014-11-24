package com.videostar.vsnews.service.news;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * UserSessionListener
 *
 * Created by patchao2000 on 14/11/21.
 */
public class UserSessionListener implements HttpSessionListener {

    private static Logger logger = LoggerFactory.getLogger(UserSessionListener.class);

//    @Autowired
//    UserSessionManager userSessionManager;

    public void sessionCreated(HttpSessionEvent event) {
        logger.debug("session created.");
    }

    public void sessionDestroyed(HttpSessionEvent event) {

        HttpSession session = event.getSession();

        //  replacement for "@Autowired"
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
        UserSessionManager userSessionManager = (UserSessionManager)ctx.getBean("userSessionManager");
        userSessionManager.removeSession(session);

//        HttpSession session = event.getSession();
//        ServletContext application = session.getServletContext();
//
//        // 取得登录的用户名
//        String username = (String) session.getAttribute("username");
//
//        // 从在线列表中删除用户名
//        List onlineUserList = (List) application.getAttribute("onlineUserList");
//        onlineUserList.remove(username);
//
//        System.out.println(username + "超时退出。");
        
        logger.debug("session destroyed.");
    }
}
