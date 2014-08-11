package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsColumn;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * ColumnDao
 *
 * Created by patchao2000 on 14-7-23.
 */
@Component
public interface ColumnDao extends PagingAndSortingRepository<NewsColumn, Long> {
    NewsColumn findByName(String name);
}