package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ColumnDao;
import com.videostar.vsnews.entity.news.NewsColumn;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.activiti.engine.identity.Group;
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
@SuppressWarnings("SpringJavaAutowiringInspection")

@Component("ColumnManager")
@Transactional(readOnly = true)
public class ColumnManager {

//    private Logger logger = LoggerFactory.getLogger(getClass());

    public static final String GROUP_ID_PREFIX = "grp_col_";
    public static final String GROUP_NAME_PREFIX = "栏目: ";

    private ColumnDao columnDao;

    public NewsColumn getColumn(Long id) {
//        logger.debug("getColumn {}", id);
        return columnDao.findOne(id);
    }

    public String getGroupId(NewsColumn column) {
        return GROUP_ID_PREFIX + column.getId().toString();
    }

    public String getGroupName(NewsColumn column) {
        return GROUP_NAME_PREFIX + column.getName();
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
