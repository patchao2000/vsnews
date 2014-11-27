package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsArticle;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * ArticleDao
 *
 * Created by patchao2000 on 14-7-25.
 */
@Component
public interface ArticleDao extends PagingAndSortingRepository<NewsArticle, Long> {
    NewsArticle findByTopicUuid(String uuid);
}
