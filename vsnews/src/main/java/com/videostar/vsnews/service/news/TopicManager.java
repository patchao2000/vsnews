package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.TopicDao;
import com.videostar.vsnews.entity.news.Topic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * Topic Manager
 *
 * Created by patchao2000 on 14-6-4.
 */
@Component("TopicManager")
@Transactional(readOnly = true)
public class TopicManager {

    private TopicDao topicDao;

    public Topic getTopic(Long id) {
        return topicDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveTopic(Topic entity) {
        if (entity.getId() == null) {
            entity.setApplyTime(new Date());
        }
        topicDao.save(entity);
    }

    @Autowired
    public void setTopicDao(TopicDao dao) {
        this.topicDao = dao;
    }
}
