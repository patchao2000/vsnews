package com.videostar.vsnews.web.identify;

import com.videostar.vsnews.util.Page;
import com.videostar.vsnews.util.PageUtil;
import com.videostar.vsnews.util.UserUtil;
import com.videostar.vsnews.util.Variable;
import org.activiti.engine.IdentityService;
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
    private IdentityService identityService;

    /**
     * 登录系统
     *
     */
    @RequestMapping(value = "/logon")
    public String logon(@RequestParam("username") String userName, @RequestParam("password") String password, HttpSession session) {
        logger.debug("logon request: {username={}, password={}}", userName, password);
        boolean checkPassword = identityService.checkPassword(userName, password);
        if (checkPassword) {

            // read user from database
            User user = identityService.createUserQuery().userId(userName).singleResult();
            UserUtil.saveUserToSession(session, user);

            List<Group> groupList = identityService.createGroupQuery().groupMember(userName).list();
            session.setAttribute("groups", groupList);

            String[] groupNames = new String[groupList.size()];
            for (int i = 0; i < groupNames.length; i++) {
                System.out.println(groupList.get(i).getName());
                groupNames[i] = groupList.get(i).getName();
            }

            session.setAttribute("groupNames", ArrayUtils.toString(groupNames));

            return "redirect:/main/index";
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
        Page<UserDetail> page = new Page<UserDetail>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        UserQuery query = identityService.createUserQuery();

        GroupQuery groupQuery = identityService.createGroupQuery();
        List<User> list = query.listPage(pageParams[0], pageParams[1]);
        List<UserDetail> detailList = new ArrayList<UserDetail>();
        for (User user : list) {
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
        page.setTotalCount(query.count());
        page.setResult(detailList);

        mav.addObject("page", page);

        return mav;
    }

    @RequestMapping(value = "list/group")
    public ModelAndView groupList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/user/groupList");
        Page<Group> page = new Page<Group>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        GroupQuery query = identityService.createGroupQuery();
        List<Group> list = query.listPage(pageParams[0], pageParams[1]);
        page.setTotalCount(query.count());
        page.setResult(list);

        mav.addObject("page", page);
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
            UserQuery query = identityService.createUserQuery();
            if (query.userId(userId).count() > 0) {
                logger.error("user id {} already exist", userId);
                return "error";
            }

            User user = identityService.newUser(userId);
            if (!firstName.equals("null"))
                user.setFirstName(firstName);
            user.setPassword(password);
            if (!email.equals("null"))
                user.setEmail(email);
            if (!lastName.equals("null"))
                user.setLastName(lastName);
            identityService.saveUser(user);
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
            User user = identityService.createUserQuery().userId(userId).singleResult();
            if (!firstName.equals("null"))
                user.setFirstName(firstName);
            user.setPassword(password);
            if (!email.equals("null"))
                user.setEmail(email);
            if (!lastName.equals("null"))
                user.setLastName(lastName);
            identityService.saveUser(user);
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
            identityService.deleteUser(userId);
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
        User user = identityService.createUserQuery().userId(userId).singleResult();
        logger.debug("get user detail {}", user.getId());
        UserDetail detail = new UserDetail(user.getId(), user.getFirstName(), user.getLastName(), user.getEmail(), user.getPassword());
        return detail;
    }

    @RequestMapping(value = "add/group/{id}/{name}", method = {RequestMethod.POST})
    @ResponseBody
    public String addGroup(@PathVariable("id") String groupId,
                          @PathVariable("name") String name) {
        try {
            GroupQuery query = identityService.createGroupQuery();
            if (query.groupId(groupId).count() > 0) {
                logger.error("group id {} already exist", groupId);
                return "error";
            }

            Group group = identityService.newGroup(groupId);
            group.setType("assignment");
            if (!name.equals("null"))
                group.setName(name);

            identityService.saveGroup(group);
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
            Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
            if (!name.equals("null"))
                group.setName(name);
            identityService.saveGroup(group);
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
            identityService.deleteGroup(groupId);
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
        Group group = identityService.createGroupQuery().groupId(groupId).singleResult();
        logger.debug("get group detail {}", group.getId());
        return group;
    }

    @RequestMapping(value = "detail/allgroup")
    @ResponseBody
    public List<Group> getAllGroup(HttpServletRequest request) {
        return identityService.createGroupQuery().list();
    }

    @RequestMapping(value = "detail/user/groups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public List<String> getUserGroups(@PathVariable("id") String userId) {
        List<String> result = new ArrayList<String>();
        for (Group group : identityService.createGroupQuery().groupMember(userId).list()) {
            result.add(group.getId());
        }
        return result;
    }

    @RequestMapping(value = "modify/user/groups/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String setUserGroups(@PathVariable("id") String userId, Variable var) {
        try {
            List<Group> list = identityService.createGroupQuery().groupMember(userId).list();
            Map<String, Object> variables = var.getVariableMap();
            Set set = variables.keySet();
            Iterator it = set.iterator();
            while (it.hasNext()) {
                String group = (String)it.next();
                Boolean v = (Boolean)variables.get(group);
                Boolean inlist = false;
                for(Group g : list) {
                    if (g.getId().equals(group)) {
                        inlist = true;
                        break;
                    }
                }
//                logger.debug("user: {} group: {} inlist: {}", userId, group, inlist);
                if (v) {
                    if (!inlist) {
//                        logger.debug("createMembership");
                        identityService.createMembership(userId, group);
                    }
                }
                else {
                    if (inlist) {
//                        logger.debug("deleteMembership");
                        identityService.deleteMembership(userId, group);
                    }
                }
            }
            return "success";
        } catch (Exception e) {
            logger.error("error on set user groups {}, variables={}", userId, var.getVariableMap());
            return "error";
        }
    }

    @Autowired
    public void setIdentityService(IdentityService identityService) {
        this.identityService = identityService;
    }

}
