package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.StoryboardDao;
import com.videostar.vsnews.entity.news.NewsStoryboard;
import com.videostar.vsnews.entity.news.NewsTopicInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * StoryboardManager
 * 
 * Created by patchao2000 on 14-9-23.
 */

@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("StoryboardManager")
@Transactional(readOnly = true)
public class StoryboardManager {
    
    private StoryboardDao storyboardDao;

    public NewsStoryboard getStoryboard(Long id) {
        return storyboardDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveStoryboard(NewsStoryboard entity) {
        storyboardDao.save(entity);
    }

    public Iterable<NewsStoryboard> getAllStoryboards() {
        return storyboardDao.findAll();
    }

    @Transactional(readOnly = false)
    public void deleteStoryboard(NewsStoryboard entity) {
        storyboardDao.delete(entity);
    }

    @Transactional(readOnly = false)
    public Boolean lockStoryboard(NewsStoryboard entity, String userId) {
        if (entity.getLockerUserId() == null) {
            entity.setLockerUserId(userId);
            storyboardDao.save(entity);
            return true;
        }
        return false;
    }

    @Transactional(readOnly = false)
    public Boolean unlockStoryboard(NewsStoryboard entity) {
        if (entity.getLockerUserId() != null) {
            entity.setLockerUserId(null);
            storyboardDao.save(entity);
            return true;
        }
        return false;
    }

    @Transactional(readOnly = false)
    public void addTopic(NewsStoryboard entity, String uuid) {
        List<NewsTopicInfo> list = entity.getTopics();
        NewsTopicInfo info = new NewsTopicInfo();
        info.setOrderValue(list.size());
        info.setTopicUuid(uuid);
        list.add(info);
        storyboardDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void topicUp(NewsStoryboard entity, int topicIndex) {
        if (topicIndex == 0)
            return;

        List<NewsTopicInfo> list = entity.getTopics();
        List<NewsTopicInfo> newList = new ArrayList<NewsTopicInfo>();
        int i = 0;
        NewsTopicInfo backup = null;
        for (NewsTopicInfo info : list) {
            if (i < topicIndex - 1 || i > topicIndex) {
                newList.add(info);
            }
            else if (i == topicIndex - 1) {
                info.setOrderValue(topicIndex);
                backup = info;
            }
            else if (i == topicIndex) {
                info.setOrderValue(topicIndex - 1);
                newList.add(info);
                newList.add(backup);
            }

            i++;
        }
        entity.setTopics(newList);
        storyboardDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void topicDown(NewsStoryboard entity, int topicIndex) {
        List<NewsTopicInfo> list = entity.getTopics();
        if (topicIndex >= list.size() - 1)
            return;

        List<NewsTopicInfo> newList = new ArrayList<NewsTopicInfo>();
        int i = 0;
        NewsTopicInfo backup = null;
        for (NewsTopicInfo info : list) {
            if (i < topicIndex || i > topicIndex + 1) {
                newList.add(info);
            }
            else if (i == topicIndex) {
                info.setOrderValue(topicIndex + 1);
                backup = info;
            }
            else if (i == topicIndex + 1) {
                info.setOrderValue(topicIndex);
                newList.add(info);
                newList.add(backup);
            }

            i++;
        }
        entity.setTopics(newList);
        storyboardDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void topicRemove(NewsStoryboard entity, int topicIndex) {
        List<NewsTopicInfo> list = entity.getTopics();
        List<NewsTopicInfo> newList = new ArrayList<NewsTopicInfo>();
        int i = 0;
        for (NewsTopicInfo info : list) {
            if (i < topicIndex) {
                newList.add(info);
            }
            else if (i >= topicIndex + 1) {
                info.setOrderValue(i - 1);
                newList.add(info);
            }

            i++;
        }
        entity.setTopics(newList);
        storyboardDao.save(entity);
    }

    @Autowired
    public void setStoryboardDao(StoryboardDao dao) {
        this.storyboardDao = dao;
    }
}
