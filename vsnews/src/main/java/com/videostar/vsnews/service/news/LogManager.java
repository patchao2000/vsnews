package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.LogDao;
import com.videostar.vsnews.entity.news.NewsLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * LogManager
 *
 * Created by patchao2000 on 14/11/21.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("LogManager")
@Transactional(readOnly = true)
public class LogManager {

    @Autowired
    private LogDao logDao;

    @Transactional(readOnly = false)
    public void addLog(String userId, String operation, String notes) {
        NewsLog log = new NewsLog();
        log.setAccessTime(new Date());
        log.setUserId(userId);
        log.setOperation(operation);
        log.setNotes(notes);
        logDao.save(log);
    }

}
