package com.videostar.vsnews.service.news;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * UserSessionManager
 *
 * Created by patchao2000 on 14/11/21.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("UserSessionManager")
@Transactional(readOnly = true)
public class UserSessionManager {

    private static Logger logger = LoggerFactory.getLogger(UserSessionManager.class);

    private Map<String, HttpSession> onlineSessions = new HashMap<String, HttpSession>();

    public void removeSession(HttpSession session) {
        onlineSessions.values().remove(session);
    }

    public void addOnlineUser(String userId, HttpSession session) {

        try {
            //  kick off exist logged in user
            if (onlineSessions.containsKey(userId)) {
                HttpSession exist = onlineSessions.get(userId);
                onlineSessions.remove(userId);
                exist.invalidate();
            }
        }
        catch (IllegalStateException e) {
            logger.debug("exception: {}", e.getMessage());
        }

        onlineSessions.put(userId, session);

        logger.debug("online users: {}", onlineSessions.size());
    }
}
