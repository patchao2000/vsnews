package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.MessageDao;
import com.videostar.vsnews.entity.news.NewsMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * MessageManager
 *
 * Created by patchao2000 on 14-9-5.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("MessageManager")
@Transactional(readOnly = true)
public class MessageManager {

    @Autowired
    private MessageDao messageDao;

    public NewsMessage getMessage(Long id) {
        return messageDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveMessage(NewsMessage entity) {
        entity.setSentDate(new Date());
        messageDao.save(entity);
    }

    public void sendMessage(String senderId, String receiverId, String content) {
        NewsMessage message = new NewsMessage();
        message.setContent(content);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);

        saveMessage(message);
    }

    public List<NewsMessage> getMessages(String receiverId) {
        return messageDao.findByReceiverIdOrderBySentDateDesc(receiverId);
    }
}
