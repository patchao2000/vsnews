package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.TopicDao;
import com.videostar.vsnews.entity.news.NewsFileInfo;
import com.videostar.vsnews.entity.news.NewsTopic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * NewsTopic Manager
 *
 * Created by patchao2000 on 14-6-4.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("TopicManager")
@Transactional(readOnly = true)
public class TopicManager {

    private TopicDao topicDao;

    public NewsTopic getTopic(Long id) {
        return topicDao.findOne(id);
    }

    public NewsTopic getTopic(String uuid) {
        return topicDao.findByUuid(uuid);
    }

    @Transactional(readOnly = false)
    public void saveTopic(NewsTopic entity) {
        Date now = new Date();
        if (entity.getId() == null)
            entity.setApplyTime(now);
        entity.setModifyTime(now);

        topicDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void addFileToTopic(NewsTopic entity, NewsFileInfo fileInfo) {
        entity.getFiles().add(fileInfo);
        topicDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void removeFileFromTopic(NewsTopic entity, Long fileInfoId) {
        List<NewsFileInfo> list = entity.getFiles();
        for (NewsFileInfo info : list) {
            if (info.getId().equals(fileInfoId)) {
                list.remove(info);
                break;
            }
        }
        topicDao.save(entity);
    }

    public Boolean haveVideoFiles(NewsTopic entity) {
        for (NewsFileInfo info : entity.getFiles()) {
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
                return true;
        }

        return false;
    }

    public Boolean haveAudioFiles(NewsTopic entity) {
        for (NewsFileInfo info : entity.getFiles()) {
            if (info.getType() == NewsFileInfo.TYPE_AUDIO_MATERIAL)
                return true;
        }

        return false;
    }

    public Boolean haveArticles(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
//            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
//                return true;
//        }

        return false;
    }

    public Iterable<NewsTopic> getAllTopics() {
        return topicDao.findAll();
    }

    @Autowired
    public void setTopicDao(TopicDao dao) {
        this.topicDao = dao;
    }
}
