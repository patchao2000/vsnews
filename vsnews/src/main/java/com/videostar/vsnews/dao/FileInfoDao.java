package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsFileInfo;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * FileInfoDao
 *
 * Created by patchao2000 on 14/11/12.
 */
@Component
public interface FileInfoDao extends PagingAndSortingRepository<NewsFileInfo, Long> {
    List<NewsFileInfo> findByTopicUuid(String topicUuid);
}
