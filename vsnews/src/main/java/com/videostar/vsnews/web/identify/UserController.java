package com.videostar.vsnews.web.identify;

import com.videostar.vsnews.util.Page;
import com.videostar.vsnews.util.PageUtil;
import com.videostar.vsnews.util.UserUtil;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
import org.apache.commons.lang3.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
     * @param userName
     * @param password
     * @param session
     * @return
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
     * @param session
     * @return
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        logger.debug("logout");
        return "/login";
    }

    @RequestMapping(value = "/list/user")
    public ModelAndView userList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/user/userList");
        Page<User> page = new Page<User>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        UserQuery query = identityService.createUserQuery();
        List<User> list = query.listPage(pageParams[0], pageParams[1]);
        page.setTotalCount(query.count());
        page.setResult(list);

        mav.addObject("page", page);
        return mav;
    }

    @Autowired
    public void setIdentityService(IdentityService identityService) {
        this.identityService = identityService;
    }

}
