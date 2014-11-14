package com.videostar.vsnews.util;

import org.activiti.engine.identity.User;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpSession;

/**
 * 用户工具类
 * 
 * @author patchao2000
 *
 */
public class UserUtil {

    public static final String USER = "user";

    public static void saveUserToSession(HttpSession session, User user) {
        session.setAttribute(USER, user);
    }

//    public static User getUserFromSession(HttpSession session) {
//        Object attribute = session.getAttribute(USER);
//        return attribute == null ? null : (User) attribute;
//    }

//    public static final String redirectTimeoutString = "redirect:/login?timeout=true";

    public static User getUserFromSession(HttpSession session) {
        Object attribute = session.getAttribute(USER);
        User user = (attribute == null ? null : (User)attribute);
        if (user == null || StringUtils.isBlank(user.getId()))
            return null;
        return user;
    }
}
