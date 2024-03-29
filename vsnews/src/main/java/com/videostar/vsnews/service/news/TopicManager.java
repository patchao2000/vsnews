package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.FileInfoDao;
import com.videostar.vsnews.dao.TopicDao;
import com.videostar.vsnews.entity.news.NewsFileInfo;
import com.videostar.vsnews.entity.news.NewsTopic;
import com.videostar.vsnews.util.TimeCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    private Logger logger = LoggerFactory.getLogger(getClass());

    private TopicDao topicDao;

    private FileInfoDao fileInfoDao;

    public NewsTopic getTopic(Long id) {
        return topicDao.findOne(id);
    }

    public NewsFileInfo getFileInfo(Long id) {
        return fileInfoDao.findOne(id);
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
    public void setArchived(NewsTopic entity, Boolean archived) {
        entity.setArchived(archived);
        saveTopic(entity);
    }

    @Transactional(readOnly = false)
    public void saveFileInfo(NewsFileInfo entity) {
        Date now = new Date();
        if (entity.getId() == null)
            entity.setApplyTime(now);
        entity.setModifyTime(now);

        fileInfoDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void addFileToTopic(NewsTopic entity, NewsFileInfo fileInfo) {
//        entity.getFiles().add(fileInfo);
//        topicDao.save(entity);
        fileInfo.setTopicUuid(entity.getUuid());
        saveFileInfo(fileInfo);
    }

    @Transactional(readOnly = false)
    public void removeFileFromTopic(NewsTopic entity, Long fileInfoId) {
//        List<NewsFileInfo> list = entity.getFiles();
//        for (NewsFileInfo info : list) {
//            if (info.getId().equals(fileInfoId)) {
//                list.remove(info);
//                break;
//            }
//        }
//        topicDao.save(entity);
        NewsFileInfo info = fileInfoDao.findOne(fileInfoId);
        info.setOldTopicUuid(info.getTopicUuid());
        info.setTopicUuid(null);
        saveFileInfo(info);
    }

    @Transactional(readOnly = false)
    public void editTopicFile(NewsTopic entity, Long fileInfoId,
                              String title, String filePath, int status, String lengthTC) {
//        List<NewsFileInfo> list = entity.getFiles();
        List<NewsFileInfo> list = fileInfoDao.findByTopicUuid(entity.getUuid());
        for (NewsFileInfo info : list) {
            if (info.getId().equals(fileInfoId)) {
                info.setTitle(title);
                info.setFilePath(filePath);
                info.setStatus(status);
                info.setLengthTC(lengthTC);
                saveFileInfo(info);
                break;
            }
        }
//        topicDao.save(entity);
    }

    @Transactional(readOnly = true)
    public List<NewsFileInfo> getTopicFiles(NewsTopic topic) {
        return fileInfoDao.findByTopicUuid(topic.getUuid());
    }

    @Transactional(readOnly = true)
    public Boolean haveVideoFiles(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            logger.debug("found: {}", info.getType());
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
                return true;
        }

        return false;
    }

    @Transactional(readOnly = true)
    public String getVideoFileStatusString(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
                return info.getStatusString();
        }

        return "";
    }

    @Transactional(readOnly = true)
    public int getVideoFileStatus(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
                return info.getStatus();
        }

        return -1;
    }

    @Transactional(readOnly = true)
    public String getVideoFilePath(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL &&
                info.getStatus() != NewsFileInfo.STATUS_BEGIN_EDIT)
                return info.getFilePath();
        }

        return "";
    }

    @Transactional(readOnly = true)
    public TimeCode getVideoFileLength(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
                return new TimeCode(info.getLengthTC());
        }

        return new TimeCode(0);
    }

    @Transactional(readOnly = true)
    public Boolean haveAudioFiles(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_AUDIO_MATERIAL)
                return true;
        }

        return false;
    }

    @Transactional(readOnly = true)
    public String getAudioFileStatus(NewsTopic entity) {
//        for (NewsFileInfo info : entity.getFiles()) {
        for (NewsFileInfo info : fileInfoDao.findByTopicUuid(entity.getUuid())) {
            if (info.getType() == NewsFileInfo.TYPE_AUDIO_MATERIAL)
                return info.getStatusString();
        }

        return "";
    }

//    public Boolean haveArticles(NewsTopic entity) {
////        for (NewsFileInfo info : entity.getFiles()) {
////            if (info.getType() == NewsFileInfo.TYPE_VIDEO_MATERIAL)
////                return true;
////        }
//
//        return false;
//    }

    @Transactional(readOnly = true)
    public Iterable<NewsTopic> getAllTopics() {
//        return topicDao.findAll();
        return topicDao.findByArchived(false);
    }

    @Transactional(readOnly = true)
    public Iterable<NewsTopic> getArchivedTopics() {
        return topicDao.findByArchived(true);
    }

    @Autowired
    public void setTopicDao(TopicDao dao) {
        this.topicDao = dao;
    }

    @Autowired
    public void setFileInfoDao(FileInfoDao dao) {
        this.fileInfoDao = dao;
    }
}
