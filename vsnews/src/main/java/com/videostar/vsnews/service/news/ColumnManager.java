package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ColumnDao;
import com.videostar.vsnews.entity.news.NewsColumn;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * ColumnManager
 *
 * Created by patchao2000 on 14-7-23.
 */
@Component("ColumnManager")
@Transactional(readOnly = true)
public class ColumnManager {

//    private Logger logger = LoggerFactory.getLogger(getClass());
    private ColumnDao columnDao;

    public NewsColumn getColumn(Long id) {
        return columnDao.findOne(id);
    }

    @Transactional(readOnly = false)
    public void saveColumn(NewsColumn entity) {
        columnDao.save(entity);
    }

    @Transactional(readOnly = false)
    public void deleteColumn(NewsColumn entity) {
        columnDao.delete(entity);
    }

    @Autowired
    public void setColumnDao(ColumnDao dao) {
        this.columnDao = dao;
    }

    public NewsColumn findColumn(String name) {
        return columnDao.findByName(name);
    }

    public List<NewsColumn> getAllColumns() {
        ArrayList<NewsColumn> result = new ArrayList<NewsColumn>();
        for (NewsColumn column : columnDao.findAll()) {
            result.add(column);
        }

        return result;
    }

}
