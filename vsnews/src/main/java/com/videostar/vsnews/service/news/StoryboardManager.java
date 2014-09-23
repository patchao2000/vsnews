package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.StoryboardDao;
import com.videostar.vsnews.entity.news.NewsStoryboard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * StoryboardManager
 * 
 * Created by patchao2000 on 14-9-23.
 */

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

    @Autowired
    public void setStoryboardDao(StoryboardDao dao) {
        this.storyboardDao = dao;
    }
}
