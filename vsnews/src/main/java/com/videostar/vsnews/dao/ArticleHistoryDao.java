package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsArticleHistory;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * ArticleHistoryDao
 *
 * Created by patchao2000 on 14-8-11.
 */
@Component
public interface ArticleHistoryDao extends PagingAndSortingRepository<NewsArticleHistory, Long> {
    List<NewsArticleHistory> findByArticleIdAndItemOrderByTimeDesc(Long articleId, String item);
}
