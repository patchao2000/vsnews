package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ArticleDao;
import com.videostar.vsnews.dao.ArticleHistoryDao;
import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.entity.news.NewsArticleHistory;
import com.videostar.vsnews.util.TimeCode;
import com.videostar.vsnews.util.WebUtil;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
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
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("ArticleManager")
@Transactional(readOnly = true)
public class ArticleManager {
//    private Logger logger = LoggerFactory.getLogger(getClass());

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

    public NewsArticle findByTopicUuid(String uuid) {
        return articleDao.findByTopicUuid(uuid);
    }

    public TimeCode getArticleLength(NewsArticle entity) {
        int length = 0;
        if (entity != null) {
            length = (int)(WebUtil.htmlRemoveTag(entity.getContent()).length() * 25 * getArticleSecondsPerChar());
        }

        return new TimeCode(length);
    }

    public double getArticleSecondsPerChar() {
        return 0.3;
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
