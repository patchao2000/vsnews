package com.videostar.vsnews.web.identify;

import com.videostar.vsnews.entity.Role;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.*;
import com.videostar.vsnews.util.*;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 用户控制器
 * 
 * @author patchao2000
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private static Logger logger = LoggerFactory.getLogger(UserController.class);

    // Activiti Identify Service
//    private IdentityService identityService;

//    @Autowired
    private UserManager userManager;

    @Autowired
    private ColumnService columnService;

    @Autowired
    private LogManager logManager;

    @Autowired
    private UserSessionManager userSessionManager;

    @Autowired
    protected TopicWorkflowService topicService;

    @Autowired
    protected ArticleWorkflowService articleService;

    @Autowired
    protected StoryboardWorkflowService storyboardService;

    /**
     * 登录系统
     *
     */
    @RequestMapping(value = "/logon")
    public String logon(@RequestParam("username") String userName, @RequestParam("password") String password, HttpSession session) {

        logger.debug("Mac Address: {}", HardwareInfo.getMacAddr());
        logger.debug("MD5: {}", Md5Encrypt.md5(HardwareInfo.getMacAddr()));
        if (!Md5Encrypt.md5(HardwareInfo.getMacAddr()).equals(ConfigXmlReader.getMacMd5())) {
            logger.error("Mac address not valid!");
            return "redirect:/login?error=true";
        }

        logger.debug("logon request: {username={}}", userName);
        boolean checkPassword = userManager.checkPassword(userName, password);
        if (checkPassword) {

            // read user from database
            User user = userManager.getUserById(userName);
            UserUtil.saveUserToSession(session, user);
            userSessionManager.addOnlineUser(user.getId(), session);

//            List<Group> groupList = userManager.getGroupListByUserId(userName);
//            session.setAttribute("groups", groupList);
//
//            String[] groupNames = new String[groupList.size()];
//            for (int i = 0; i < groupNames.length; i++) {
////                logger.debug("in group: {}", groupList.get(i).getName());
//                groupNames[i] = groupList.get(i).getName();
//            }
//
//            session.setAttribute("groupNames", ArrayUtils.toString(groupNames));

            logManager.addLog(session, "用户登录", null);

            return "redirect:/main/welcome";
        } else {
            return "redirect:/login?error=true";
        }
    }

    /**
     * 登出系统
     * 
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        logManager.addLog(session, "用户注销", null);

        session.removeAttribute("user");
        userSessionManager.removeSession(session);
//        logger.debug("logout");
        return "/login";
    }

    @RequestMapping(value = "list/user")
    public ModelAndView userList() {
        ModelAndView mav = new ModelAndView("/user/userList");
        UserQuery query = userManager.createUserQuery();
        GroupQuery groupQuery = userManager.createGroupQuery();
        List<UserDetail> detailList = new ArrayList<UserDetail>();
        for (User user : query.list()) {
            UserDetail detail = new UserDetail(user.getId(), user.getFirstName(), user.getLastName(),
                    user.getEmail(), user.getPassword());
            String roleNames = "", columnNames = "";
            int i = 0, j = 0;
            for (Group group : groupQuery.groupMember(user.getId()).list()) {
                if (columnService.isColumnGroup(group)) {
                    if (j++ > 0)
                        columnNames += ", ";
                    columnNames += group.getName();
                }
            }
            for (Long roleId : userManager.getUserRoles(user.getId())) {
                if (i++ > 0)
                    roleNames += ", ";
                roleNames += userManager.getRoleNameById(roleId);
            }

            detail.setRoles(roleNames);
            detail.setColumns(columnNames);
            detailList.add(detail);
        }
        mav.addObject("list", detailList);

        return mav;
    }

    @RequestMapping(value = "list/group")
    public ModelAndView groupList() {
        ModelAndView mav = new ModelAndView("/user/groupList");
        GroupQuery query = userManager.createGroupQuery();
        ArrayList<Group> list = new ArrayList<Group>();
        //  skip column group
        for (Group group : query.list()) {
            if (!columnService.isColumnGroup(group)) {
                list.add(group);
            }
        }

        mav.addObject("list", list);
        return mav;
    }

    @RequestMapping(value = "list/role")
    public ModelAndView roleList() {
        ModelAndView mav = new ModelAndView("/user/roleList");
        mav.addObject("list", userManager.getAllRoles());
        return mav;
    }

    @RequestMapping(value = "add/user/{id}/{firstname}/{password}/{email}/{lastname}", method = {RequestMethod.POST})
    @ResponseBody
    public String addUser(@PathVariable("id") String userId,
                          @PathVariable("firstname") String firstName,
                          @PathVariable("password") String password,
                          @PathVariable("email") String email,
                          @PathVariable("lastname") String lastName, HttpSession session) {
        try {
            UserQuery query = userManager.createUserQuery();
            if (query.userId(userId).count() > 0) {
                logger.error("user id {} already exist", userId);
                return "error";
            }

            User user = userManager.newUser(userId, firstName, password, email, lastName);
            logger.debug("user created: {}", user.getId());

            logManager.addLog(session, "添加用户", "ID: " + userId);

            return "success";
        } catch (Exception e) {
            logger.error("error on create user: {}", userId);
            return "error";
        }
    }

    @RequestMapping(value = "modify/user/{id}/{firstname}/{password}/{email}/{lastname}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyUser(@PathVariable("id") String userId,
                             @PathVariable("firstname") String firstName,
                             @PathVariable("password") String password,
                             @PathVariable("email") String email,
                             @PathVariable("lastname") String lastName, HttpSession session) {
        try {
            User user = userManager.modifyUser(userId, firstName, password, email, lastName);
            logger.debug("user modified: {}", user.getId());

            logManager.addLog(session, "修改用户", "ID: " + userId);

            return "success";
        } catch (Exception e) {
            logger.error("error on modify user: {}", userId);
            return "error";
        }
    }

    @RequestMapping(value = "modify-password/{id}/{old-password}/{new-password}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyUserPassword(@PathVariable("id") String userId,
                             @PathVariable("old-password") String oldPassword,
                             @PathVariable("new-password") String newPassword, HttpSession session) {
        try {
            Boolean status = userManager.modifyUserPassword(userId, oldPassword, newPassword);
            if (status) {
                logger.debug("user password modified: {}", userId);

                logManager.addLog(session, "修改密码", "ID: " + userId);

                return "success";
            }
            else {
                logger.error("error on modify user password: {}", userId);
                return "error";
            }
        } catch (Exception e) {
            logger.error("error on modify user password: {}", userId);
            return "error";
        }
    }

    @RequestMapping(value = "delete/user/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteUser(@PathVariable("id") String userId, HttpSession session) {
        try {
            if (topicService.isRunningUser(userId) ||
                articleService.isRunningUser(userId) ||
                storyboardService.isRunningUser(userId)) {
                return "running";
            }

            userManager.deleteUser(userId);
            logger.debug("user deleted: {}", userId);
            logManager.addLog(session, "删除用户", "ID: " + userId);
            return "success";
        } catch (Exception e) {
            logger.error("error on delete user: {}", userId);
            return "error";
        }
    }

    @RequestMapping(value = "detail/user/{id}")
    @ResponseBody
    public UserDetail getUser(@PathVariable("id") String userId) {
        User user = userManager.getUserById(userId);
        logger.debug("get user detail {}", user.getId());
        return new UserDetail(user.getId(), user.getFirstName(), user.getLastName(), user.getEmail(), user.getPassword());
    }

    @RequestMapping(value = "add/group/{id}/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String addGroup(@PathVariable("id") String groupId,
                          @PathVariable("name") String name) {
        try {
            Group group = userManager.newGroup(groupId, name);
            logger.debug("group created: {}", group.getId());
            return "success";
        } catch (Exception e) {
            logger.error("error on create group: {}", groupId);
            return "error";
        }
    }

    @RequestMapping(value = "modify/group/{id}/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyGroup(@PathVariable("id") String groupId,
                             @PathVariable("name") String name) {
        try {
            Group group = userManager.modifyGroup(groupId, name);
            logger.debug("group modified: {}", group.getId());
            return "success";
        } catch (Exception e) {
            logger.error("error on modify group: {}", groupId);
            return "error";
        }
    }

    @RequestMapping(value = "delete/group/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteGroup(@PathVariable("id") String groupId) {
        try {
            userManager.deleteGroup(groupId);
            logger.debug("group deleted: {}", groupId);
            return "success";
        } catch (Exception e) {
            logger.error("error on delete group: {}", groupId);
            return "error";
        }
    }

    @RequestMapping(value = "detail/group/{id}")
    @ResponseBody
    public Group getGroup(@PathVariable("id") String groupId) {
        Group group = userManager.getGroupById(groupId);
        logger.debug("get group detail {}", group.getId());
        return group;
    }

    @RequestMapping(value = "objlist/allgroups")
    @ResponseBody
    public List<Group> getAllGroups() {

        List<Group> list = new ArrayList<Group>();
        //  skip column group
        for (Group group : userManager.createGroupQuery().list()) {
            if (!columnService.isColumnGroup(group)) {
                list.add(group);
            }
        }

        return list;
    }

    @RequestMapping(value = "objlist/columngroups")
    @ResponseBody
    public List<Group> getColumnGroups() {

        List<Group> list = new ArrayList<Group>();
        for (Group group : userManager.createGroupQuery().list()) {
            if (columnService.isColumnGroup(group)) {
                list.add(group);
            }
        }

        return list;
    }

//    @RequestMapping(value = "idlist/usergroups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
//    @ResponseBody
//    public List<String> getUserGroups(@PathVariable("id") String userId) {
//        List<String> result = new ArrayList<String>();
//        for (Group group : userManager.getGroupListByUserId(userId)) {
//            result.add(group.getId());
//        }
//        return result;
//    }

    @RequestMapping(value = "idlist/user/columns/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> getUserColumnGroups(@PathVariable("id") String userId) {
        List<String> result = new ArrayList<String>();
        for (Group group : userManager.getGroupListByUserId(userId)) {
            if (columnService.isColumnGroup(group)) {
                result.add(group.getId());
            }
        }
        return result;
    }

    @RequestMapping(value = "objlist/groupmembers/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<UserDetail> getGroupMembers(@PathVariable("id") String groupId) {
        List<UserDetail> result = new ArrayList<UserDetail>();
        for (User user : userManager.getGroupMembers(groupId)) {
            result.add(new UserDetail(user.getId(), user.getFirstName(), user.getLastName(), user.getEmail(), user.getPassword()));
        }
        return result;
    }

//    @RequestMapping(value = "modify/user/groups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
//    @ResponseBody
//    public String setUserGroups(@PathVariable("id") String userId, Variable var) {
//        try {
//            userManager.setUserGroups(userId, var);
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on set user groups {}, variables={}", userId, var.getVariableMap());
//            logger.error(e.getMessage());
//            return "error";
//        }
//    }

    @RequestMapping(value = "modify/user/columns/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setUserColumns(@PathVariable("id") String userId, Variable var, HttpSession session) {
        try {
            userManager.setUserGroups(userId, var);
            logManager.addLog(session, "设置用户栏目", "ID: " + userId);
            return "success";
        } catch (Exception e) {
            logger.error("error on set user columns {}, variables={}", userId, var.getVariableMap());
            logger.error(e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "add/role/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String addRole(@PathVariable("name") String name, HttpSession session) {
        try {
            Role role = userManager.newRole(name);
            logger.debug("role created: {}", role.getId());
            logManager.addLog(session, "添加角色", "ID: " + role.getId());
            return role.getId().toString();//"success";
        } catch (Exception e) {
            logger.error("error on create role: {}", name);
            return "error";
        }
    }

    @RequestMapping(value = "modify/role/{id}/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyRole(@PathVariable("id") Long id, @PathVariable("name") String name,
                             HttpSession session) {
        try {
            Role role = userManager.modifyRole(id, name);
            logger.debug("role modified: {}", role.getId());
            logManager.addLog(session, "修改角色", "ID: " + role.getId());
            return role.getId().toString();//"success";
        } catch (Exception e) {
            logger.error("error on modify role: {}", id);
            return "error";
        }
    }

    @RequestMapping(value = "modify/role/groups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setRoleGroups(@PathVariable("id") Long roleId, Variable var, HttpSession session) {
        try {
            List<String> groupList = new ArrayList<String>();
            Map<String, Object> variables = var.getVariableMap();
            Set<String> set = variables.keySet();
            for (Object groupObj : set) {
                String group = (String)groupObj;
                Boolean v = (Boolean)variables.get(group);
                if (v) {
                    groupList.add(group);
                }
            }

            userManager.setRoleGroups(roleId, groupList);
            for (User user : userManager.getRoleUsers(roleId)) {
                userManager.refreshUserRoles(user.getId());
            }

            logManager.addLog(session, "修改角色权限", "ID: " + roleId);
            return "success";
        } catch (Exception e) {
            logger.error("error on set role groups {}, variables={}", roleId, var.getVariableMap());
            logger.error(e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "delete/role/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteRole(@PathVariable("id") Long roleId, HttpSession session) {
        try {
            if (!userManager.isRoleEmpty(roleId)) {
                return "notempty";
            }
            userManager.deleteRole(roleId);
            logger.debug("role deleted: {}", roleId);
            logManager.addLog(session, "删除角色", "ID: " + roleId);
            return "success";
        } catch (Exception e) {
            logger.error("error on delete role: {}", roleId);
            return "error";
        }
    }

    @RequestMapping(value = "detail/role/{id}")
    @ResponseBody
    public Role getRole(@PathVariable("id") Long roleId) {
        Role role = userManager.getRoleById(roleId);
        logger.debug("get role detail {}", role.getId());
        return role;
    }

    @RequestMapping(value = "idlist/rolegroups/{roleId}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> getRoleGroups(@PathVariable("roleId") Long roleId) {
        return userManager.getRoleGroups(roleId);
    }

    @RequestMapping(value = "idlist/user/roles/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> getUserRoles(@PathVariable("id") String userId) {
        List<String> result = new ArrayList<String>();
        for (Long roleId : userManager.getUserRoles(userId)) {
            result.add(roleId.toString());
        }
        return result;
    }

    @RequestMapping(value = "objlist/allroles", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<Role> getAllRoles() {
        return userManager.getAllRoles();
    }

    @RequestMapping(value = "modify/user/roles/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setUserRoles(@PathVariable("id") String userId, Variable var, HttpSession session) {
        try {
            List<Long> roleList = new ArrayList<Long>();
            Map<String, Object> variables = var.getVariableMap();
            Set<String> set = variables.keySet();
            for (Object roleObj : set) {
                String role = (String)roleObj;
//                logger.debug("role: {}", role);
                Boolean v = (Boolean)variables.get(role);
                if (v) {
                    roleList.add(Long.parseLong(role));
                }
            }
            userManager.setUserRoles(userId, roleList);
            logManager.addLog(session, "修改用户角色", "ID: " + userId);

            return "success";
        } catch (Exception e) {
            logger.error("error on set user roles {}, variables={}", userId, var.getVariableMap());
            logger.error(e.getMessage());
            return "error";
        }
    }

//    @Autowired
//    public void setIdentityService(IdentityService identityService) {
//        this.identityService = identityService;
//    }

    @Autowired
    public void setUserManager(UserManager userManager) {
        this.userManager = userManager;
    }

}
