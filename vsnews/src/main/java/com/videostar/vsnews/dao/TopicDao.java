package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsTopic;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

/**
 * TopicDao
 *
 * Created by patchao2000 on 14-6-4.
 */
@Component
public interface TopicDao extends PagingAndSortingRepository<NewsTopic, Long> {
    NewsTopic findByUuid(String uuid);
}
