package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.service.identify.UserManager;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * ColumnService
 *
 * Created by patchao2000 on 14-7-25.
 */
@Component
@Transactional
public class ColumnService {

    @Autowired
    private ColumnManager columnManager;

    @Autowired
    private UserManager userManager;


    public NewsColumn getColumn(Long id) {
        return columnManager.getColumn(id);
    }

    public List<NewsColumn> getAllColumns() {
        return columnManager.getAllColumns();
    }

    public List<NewsColumn> getUserColumns(User user) {
        ArrayList<NewsColumn> result = new ArrayList<NewsColumn>();
        for (NewsColumn column : columnManager.getAllColumns()) {
            if (userManager.isUserInGroup(user.getId(), columnManager.getGroupId(column)) ||
                    userManager.isUserHaveRights(user, UserManager.RIGHTS_ADMIN)) {
                result.add(column);
            }
        }
        return result;
    }

    @Transactional(readOnly = true)
    public Boolean userHaveColumnRights(User user, Long columnId) {
        for (NewsColumn column : columnManager.getAllColumns()) {
            if (userManager.isUserInGroup(user.getId(), columnManager.getGroupId(column))) {
                if (column.getId().equals(columnId)) {
                    return true;
                }
            }
        }
        return false;
    }

    public Boolean isColumnGroup(Group group) {
        return group.getId().startsWith(columnManager.GROUP_ID_PREFIX);
    }

    @Transactional(readOnly = false)
    public NewsColumn newColumn(String columnName, int auditLevel) throws Exception {
        if (columnManager.findColumn(columnName) != null) {
            throw new Exception("column name already exist");
        }

        NewsColumn column = new NewsColumn();
        column.setAuditLevel(auditLevel);
        column.setParentId(null);
        column.setName(columnName);
        columnManager.saveColumn(column);

        //  add a group per column
        userManager.newGroup(columnManager.getGroupId(column), columnManager.getGroupName(column));

        return column;
    }

    @Transactional(readOnly = false)
    public NewsColumn modifyColumn(Long id, String columnName, int auditLevel) throws Exception {
        NewsColumn exist = columnManager.findColumn(columnName);
        if (exist != null && !exist.getId().equals(id)) {
            throw new Exception("column name already exist");
        }

        NewsColumn column = columnManager.getColumn(id);
        column.setAuditLevel(auditLevel);
        column.setParentId(null);
        column.setName(columnName);
        columnManager.saveColumn(column);

        //  modify group
        userManager.modifyGroup(columnManager.getGroupId(column), columnManager.getGroupName(column));

        return column;
    }

    @Transactional(readOnly = false)
    public void deleteColumn(Long id) throws Exception {
        NewsColumn column = columnManager.getColumn(id);
        if (column == null) {
            throw new Exception("column doesn't exist");
        }

        //  delete group
        Group group = userManager.getGroupById(columnManager.getGroupId(column));
        if (userManager.getGroupMembers(group.getId()).size() != 0) {
            throw new Exception("group not empty");
        }
        userManager.deleteGroup(group.getId());
        columnManager.deleteColumn(column);
    }
}
