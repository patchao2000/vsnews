package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.VideoDao;
import com.videostar.vsnews.entity.news.NewsVideo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * VideoManager
 * 
 * Created by patchao2000 on 14-8-18.
 */
@Component("VideoManager")
@Transactional(readOnly = true)
public class VideoManager {

    private VideoDao videoDao;

    public NewsVideo getVideo(Long id) {
        return videoDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveVideo(NewsVideo entity) {
        videoDao.save(entity);
    }

    public Iterable<NewsVideo> getAllVideos() {
        return videoDao.findAll();
    }

    @Autowired
    public void setVideoDao(VideoDao dao) {
        this.videoDao = dao;
    }
}
