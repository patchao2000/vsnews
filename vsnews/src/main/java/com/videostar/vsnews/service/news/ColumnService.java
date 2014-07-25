package com.videostar.vsnews.service.news;

import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.service.identify.UserManager;
import org.activiti.engine.identity.Group;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * ColumnService
 *
 * Created by patchao2000 on 14-7-25.
 */
@Component
@Transactional
public class ColumnService {

    public static final String GROUP_ID_PREFIX = "grp_col_";
    public static final String GROUP_NAME_PREFIX = "栏目: ";

    @Autowired
    private ColumnManager columnManager;

    @Autowired
    private UserManager userManager;


    public String getGroupId(NewsColumn column) {
        return GROUP_ID_PREFIX + column.getId().toString();
    }

    public String getGroupName(NewsColumn column) {
        return GROUP_NAME_PREFIX + column.getName();
    }

    public Boolean isColumnGroup(Group group) {
        return group.getId().startsWith(GROUP_ID_PREFIX);
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
        userManager.newGroup(getGroupId(column), getGroupName(column));

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
        userManager.modifyGroup(getGroupId(column), getGroupName(column));

        return column;
    }

    @Transactional(readOnly = false)
    public void deleteColumn(Long id) throws Exception {
        NewsColumn column = columnManager.getColumn(id);
        if (column == null) {
            throw new Exception("column doesn't exist");
        }

        //  delete group
        Group group = userManager.getGroupById(getGroupId(column));
        if (userManager.getGroupMembers(group.getId()).size() != 0) {
            throw new Exception("group not empty");
        }
        userManager.deleteGroup(group.getId());
        columnManager.deleteColumn(column);
    }
}
