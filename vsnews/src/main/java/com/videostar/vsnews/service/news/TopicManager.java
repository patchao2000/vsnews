package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.TopicDao;
import com.videostar.vsnews.entity.news.NewsTopic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * NewsTopic Manager
 *
 * Created by patchao2000 on 14-6-4.
 */
@Component("TopicManager")
@Transactional(readOnly = true)
public class TopicManager {

    private TopicDao topicDao;

    public NewsTopic getTopic(Long id) {
        return topicDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveTopic(NewsTopic entity) {
        if (entity.getId() == null) {
            entity.setApplyTime(new Date());
        }
        topicDao.save(entity);
    }

    public List<NewsTopic> getAllTopics() {
        ArrayList<NewsTopic> result = new ArrayList<NewsTopic>();
        for (NewsTopic topic : topicDao.findAll()) {
            result.add(topic);
        }

        return result;
    }

    @Autowired
    public void setTopicDao(TopicDao dao) {
        this.topicDao = dao;
    }
}
