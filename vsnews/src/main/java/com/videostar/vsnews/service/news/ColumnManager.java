package com.videostar.vsnews.service.news;

import com.videostar.vsnews.dao.ColumnDao;
import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.service.identify.UserManager;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * ColumnManager
 *
 * Created by patchao2000 on 14-7-23.
 */
@Component("ColumnManager")
@Transactional(readOnly = true)
public class ColumnManager {

    public final String GROUP_ID_PREFIX = "grp_col_";
    public final String GROUP_NAME_PREFIX = "栏目: ";
    private Logger logger = LoggerFactory.getLogger(getClass());

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

    public Boolean exists(String name) {
        for (NewsColumn column : columnDao.findAll()) {
            if (column.getName().equals(name))
                return true;
        }

        return false;
    }

    public NewsColumn find(String name) {
        for (NewsColumn column : columnDao.findAll()) {
            if (column.getName().equals(name))
                return column;
        }

        return null;
    }

    public List<NewsColumn> getAllColumns() {
        ArrayList<NewsColumn> result = new ArrayList<NewsColumn>();
        for (NewsColumn column : columnDao.findAll()) {
            result.add(column);
        }

        return result;
    }

    public String getGroupId(NewsColumn column) {
        return GROUP_ID_PREFIX + column.getId().toString();
    }

    public String getGroupName(NewsColumn column) {
        return GROUP_NAME_PREFIX + column.getName();
    }

    @Transactional(readOnly = false)
    public NewsColumn newColumn(String columnName, int auditLevel) throws ActivitiException {
        if (exists(columnName)) {
            throw new ActivitiException("column name already exist");
        }

        NewsColumn column = new NewsColumn();
        column.setAuditLevel(auditLevel);
        column.setParentId(null);
        column.setName(columnName);
        saveColumn(column);

        //  add a group per column
        userManager.newGroup(getGroupId(column), getGroupName(column));

        return column;
    }

    @Transactional(readOnly = false)
    public NewsColumn modifyColumn(Long id, String columnName, int auditLevel) throws ActivitiException {
        if (exists(columnName)) {
            throw new ActivitiException("column name already exist");
        }

        NewsColumn column = columnDao.findOne(id);
        column.setAuditLevel(auditLevel);
        column.setParentId(null);
        column.setName(columnName);
        saveColumn(column);

        //  modify group
        userManager.modifyGroup(getGroupId(column), getGroupName(column));

        return column;
    }

    @Transactional(readOnly = false)
    public void deleteColumn(Long id) throws ActivitiException {
        NewsColumn column = columnDao.findOne(id);
        if (column == null) {
            throw new ActivitiException("column dosn't exist");
        }

        //  delete group
        Group group = userManager.getGroupById(getGroupId(column));
        if (userManager.getGroupMembers(group.getId()).size() != 0) {
            throw new ActivitiException("group not empty");
        }
        userManager.deleteGroup(group.getId());
        columnDao.delete(column);
    }
}
