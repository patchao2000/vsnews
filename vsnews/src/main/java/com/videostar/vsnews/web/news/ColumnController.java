package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsColumn;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.ColumnManager;
import com.videostar.vsnews.service.news.ColumnService;
import com.videostar.vsnews.service.news.LogManager;
import org.activiti.engine.identity.Group;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * ColumnController
 *
 * Created by patchao2000 on 14-7-24.
 */
@Controller
@RequestMapping(value = "/news/column")
public class ColumnController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private ColumnManager columnManager;

    @Autowired
    private UserManager userManager;

    @Autowired
    private ColumnService columnService;

    @Autowired
    private LogManager logManager;

    @RequestMapping(value = "add/{name}/{audit}", method = {RequestMethod.POST})
    @ResponseBody
    public String addUser(@PathVariable("name") String name, @PathVariable("audit") int auditLevel,
                          HttpSession session) {
        try {
            if (columnManager.findColumn(name) != null) {
                logger.error("column {} already exist", name);
                return "error";
            }

            NewsColumn column = columnService.newColumn(name, auditLevel);
            logger.debug("column created: {} {} {}", column.getId(), column.getName(), column.getAuditLevel());

            logManager.addLog(session, "创建栏目", "ID: " + column.getId() + "  名称: " + column.getName());

            return "success";
        } catch (Exception e) {
            logger.error("error on create column: {}", name);
            return "error";
        }
    }

    @RequestMapping(value = "modify/{id}/{name}/{audit}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyColumn(@PathVariable("id") Long id, @PathVariable("name") String name,
                               @PathVariable("audit") int auditLevel, HttpSession session) {
        try {
            NewsColumn exist = columnManager.findColumn(name);
            if (exist != null && !exist.getId().equals(id)) {
                logger.error("column {} already exist", name);
                return "error";
            }

            NewsColumn column = columnService.modifyColumn(id, name, auditLevel);
            logger.debug("column modified: {} {} {}", column.getId(), column.getName(), column.getAuditLevel());

            logManager.addLog(session, "修改栏目", "ID: " + column.getId() + "  名称: " + column.getName());

            return "success";
        } catch (Exception e) {
            logger.error("error on modify column: {}", name);
            return "error";
        }
    }

    @RequestMapping(value = "delete/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteColumn(@PathVariable("id") Long id, HttpSession session) {
        try {
            columnService.deleteColumn(id);
            logger.debug("column deleted: {}", id);

            logManager.addLog(session, "删除栏目", "ID: " + id);

            return "success";
        } catch (Exception e) {
            logger.error("error on delete column: {}", id);
            return "error";
        }
    }

    @RequestMapping(value = "detail/{id}")
    @ResponseBody
    public NewsColumn getColumn(@PathVariable("id") Long columnId) {
        return columnManager.getColumn(columnId);
    }

    @RequestMapping(value = "list")
    public ModelAndView columnList() {
        ModelAndView mav = new ModelAndView("/news/column/columnList");
        List<NewsColumn> list = columnManager.getAllColumns();
        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "objlist/usercolumns/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<NewsColumn> getUserColumns(@PathVariable("id") String userId) {
        return columnService.getUserColumns(userManager.getUserById(userId));
    }

    @RequestMapping(value = "objlist/allcolumns")
    @ResponseBody
    public List<NewsColumn> getAllColumns() {
        return columnService.getAllColumns();
    }

}
