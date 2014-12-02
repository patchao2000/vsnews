package com.videostar.vsnews.dao;

import com.videostar.vsnews.entity.news.NewsMessage;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * MessageDao
 *
 * Created by patchao2000 on 14-9-5.
 */
@Component
public interface MessageDao extends PagingAndSortingRepository<NewsMessage, Long> {
    List<NewsMessage> findByReceiverIdOrderBySentDateDesc(String receiverId);
    List<NewsMessage> findBySenderIdOrderBySentDateDesc(String senderId);
    List<NewsMessage> findByReceiverIdAndMarkRead(String receiverId, Boolean markRead);
}
