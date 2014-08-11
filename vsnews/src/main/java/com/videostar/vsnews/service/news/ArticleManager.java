package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ArticleDao;
import com.videostar.vsnews.dao.ArticleHistoryDao;
import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsArticleHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * ArticleManager
 *
 * Created by patchao2000 on 14-7-25.
 */
@Component("ArticleManager")
@Transactional(readOnly = true)
public class ArticleManager {

    @Autowired
    private ArticleDao articleDao;

    @Autowired
    private ArticleHistoryDao articleHistoryDao;

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

    @Transactional(readOnly = false)
    public void applyArticleHistory(String userId, Long articleId, String item, String content) {
        NewsArticleHistory history = new NewsArticleHistory();
        Date now = new Date();
        history.setTime(now);
        history.setUserId(userId);
        history.setArticleId(articleId);
        history.setItem(item);
        history.setContent(content);

        articleHistoryDao.save(history);
    }

    public List<NewsArticleHistory> getArticleContentHistories(Long articleId) {
        return articleHistoryDao.findByArticleIdAndItemOrderByTimeDesc(articleId, "content");
    }

    public NewsArticleHistory getArticleHistory(Long historyId) {
        return articleHistoryDao.findOne(historyId);
    }

//    @Autowired
//    public void setArticleDao(ArticleDao dao) {
//        this.articleDao = dao;
//    }
//
//    @Autowired
//    public void setArticleHistoryDao(ArticleHistoryDao dao) {
//        this.articleHistoryDao = dao;
//    }
}
