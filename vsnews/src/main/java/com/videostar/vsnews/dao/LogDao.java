package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsLog;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * LogDao
 *
 * Created by patchao2000 on 14/11/21.
 */
@Component
public interface LogDao extends PagingAndSortingRepository<NewsLog, Long> {
//    List<NewsLog> findAllByOrderByAccessTimeDesc();
}
