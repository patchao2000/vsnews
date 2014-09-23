package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsStoryboard;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * StoryboardDao
 *
 * Created by patchao2000 on 14-9-23.
 */
@Component
public interface StoryboardDao extends PagingAndSortingRepository<NewsStoryboard, Long> {
}
