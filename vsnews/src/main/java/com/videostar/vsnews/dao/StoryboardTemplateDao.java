package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsStoryboardTemplate;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * StoryboardTemplateDao
 *
 * Created by patchao2000 on 14/11/7.
 */
@Component
public interface StoryboardTemplateDao extends PagingAndSortingRepository<NewsStoryboardTemplate, Long> {
}
