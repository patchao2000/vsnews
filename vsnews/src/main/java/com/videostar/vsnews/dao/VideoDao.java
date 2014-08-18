package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsVideo;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * VideoDao
 *
 * Created by patchao2000 on 14-8-18.
 */
@Component
public interface VideoDao extends PagingAndSortingRepository<NewsVideo, Long> {
    NewsVideo findByFileName(String fileName);
    NewsVideo findByTitle(String title);
}