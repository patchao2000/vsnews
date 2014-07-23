package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ColumnDao;
import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.service.identify.UserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * ColumnManager
 *
 * Created by patchao2000 on 14-7-23.
 */
@Component("ColumnManager")
@Transactional(readOnly = true)
public class ColumnManager {
    @Autowired
    private UserManager userManager;

    private ColumnDao columnDao;

    public NewsColumn getColumn(Long id) {
        return columnDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveColumn(NewsColumn entity) {
        columnDao.save(entity);
    }

    @Autowired
    public void setColumnDao(ColumnDao dao) {
        this.columnDao = dao;
    }
}
