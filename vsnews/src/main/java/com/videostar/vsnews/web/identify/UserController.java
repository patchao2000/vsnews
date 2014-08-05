package com.videostar.vsnews.web.identify;

import com.videostar.vsnews.entity.Role;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.ColumnService;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.Variable;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
import org.apache.commons.lang3.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    /**
     * 登录系统
     *
     */
    @RequestMapping(value = "/logon")
    public String logon(@RequestParam("username") String userName, @RequestParam("password") String password, HttpSession session) {
        logger.debug("logon request: {username={}, password={}}", userName, password);
        boolean checkPassword = userManager.checkPassword(userName, password);
        if (checkPassword) {

            // read user from database
            User user = userManager.getUserById(userName);
            UserUtil.saveUserToSession(session, user);

            List<Group> groupList = userManager.getGroupListByUserId(userName);
            session.setAttribute("groups", groupList);

            String[] groupNames = new String[groupList.size()];
            for (int i = 0; i < groupNames.length; i++) {
                logger.debug("in group: {}", groupList.get(i).getName());
                groupNames[i] = groupList.get(i).getName();
            }

            session.setAttribute("groupNames", ArrayUtils.toString(groupNames));

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
        session.removeAttribute("user");
        logger.debug("logout");
        return "/login";
    }

    @RequestMapping(value = "list/user")
    public ModelAndView userList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/user/userList");
        UserQuery query = userManager.createUserQuery();
        GroupQuery groupQuery = userManager.createGroupQuery();
        List<UserDetail> detailList = new ArrayList<UserDetail>();
        for (User user : query.list()) {
            UserDetail detail = new UserDetail(user.getId(), user.getFirstName(), user.getLastName(), user.getEmail(), user.getPassword());
            String groupNames = "";
            int i = 0;
            for (Group group : groupQuery.groupMember(user.getId()).list()) {
                if (i++ > 0)
                    groupNames += ", ";
                groupNames += group.getName();
            }
            detail.setRole(groupNames);
            detailList.add(detail);
        }
        mav.addObject("list", detailList);

        return mav;
    }

    @RequestMapping(value = "list/group")
    public ModelAndView groupList(HttpServletRequest request) {
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
                          @PathVariable("lastname") String lastName) {
        try {
            UserQuery query = userManager.createUserQuery();
            if (query.userId(userId).count() > 0) {
                logger.error("user id {} already exist", userId);
                return "error";
            }

            User user = userManager.newUser(userId, firstName, password, email, lastName);
            logger.debug("user created: {}", user.getId());
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
                          @PathVariable("lastname") String lastName) {
        try {
            User user = userManager.modifyUser(userId, firstName, password, email, lastName);
            logger.debug("user modified: {}", user.getId());
            return "success";
        } catch (Exception e) {
            logger.error("error on modify user: {}", userId);
            return "error";
        }
    }

    @RequestMapping(value = "delete/user/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteUser(@PathVariable("id") String userId) {
        try {
            userManager.deleteUser(userId);
            logger.debug("user deleted: {}", userId);
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

    @RequestMapping(value = "idlist/usergroups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> getUserGroups(@PathVariable("id") String userId) {
        List<String> result = new ArrayList<String>();
        for (Group group : userManager.getGroupListByUserId(userId)) {
            result.add(group.getId());
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

    @RequestMapping(value = "add/role/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String addRole(@PathVariable("name") String name) {
        try {
            Role role = userManager.newRole(name);
            logger.debug("role created: {}", role.getId());
            return role.getId().toString();//"success";
        } catch (Exception e) {
            logger.error("error on create role: {}", name);
            return "error";
        }
    }

    @RequestMapping(value = "modify/role/{id}/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String modifyRole(@PathVariable("id") Long id, @PathVariable("name") String name) {
        try {
            Role role = userManager.modifyRole(id, name);
            logger.debug("role modified: {}", role.getId());
            return role.getId().toString();//"success";
        } catch (Exception e) {
            logger.error("error on modify role: {}", id);
            return "error";
        }
    }

    @RequestMapping(value = "modify/role/groups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setRoleGroups(@PathVariable("id") Long roleId, Variable var) {
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
            return "success";
        } catch (Exception e) {
            logger.error("error on set role groups {}, variables={}", roleId, var.getVariableMap());
            logger.error(e.getMessage());
            return "error";
        }
    }

    @RequestMapping(value = "delete/role/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public String deleteRole(@PathVariable("id") Long roleId) {
        try {
            userManager.deleteRole(roleId);
            logger.debug("role deleted: {}", roleId);
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

    @RequestMapping(value = "modify/user/roles/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setUserRoles(@PathVariable("id") String userId, Variable var) {
        try {
            List<Long> roleList = new ArrayList<Long>();
            Map<String, Object> variables = var.getVariableMap();
            Set<String> set = variables.keySet();
            for (Object roleObj : set) {
                String role = (String)roleObj;
                Boolean v = (Boolean)variables.get(role);
                if (v) {
                    roleList.add(Long.parseLong(role));
                }
            }
            userManager.setUserRoles(userId, roleList);

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
