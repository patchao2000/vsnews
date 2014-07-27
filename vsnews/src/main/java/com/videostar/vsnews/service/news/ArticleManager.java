package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ArticleDao;
import com.videostar.vsnews.entity.news.NewsArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * ArticleManager
 *
 * Created by patchao2000 on 14-7-25.
 */
@Component("ArticleManager")
@Transactional(readOnly = true)
public class ArticleManager {

    private ArticleDao articleDao;

    public NewsArticle getArticle(Long id) {
        return articleDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveArticle(NewsArticle entity) {
        Date now = new Date();
        if (entity.getId() == null)
            entity.setApplyTime(now);
        entity.setModifyTime(now);

        articleDao.save(entity);
    }

    public Iterable<NewsArticle> getAllArticles() {
        return articleDao.findAll();
    }

    @Autowired
    public void setArticleDao(ArticleDao dao) {
        this.articleDao = dao;
    }
}
