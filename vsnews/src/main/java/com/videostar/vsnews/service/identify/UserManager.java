package com.videostar.vsnews.service.identify;

import com.videostar.vsnews.dao.RoleDao;
import com.videostar.vsnews.entity.Role;
import com.videostar.vsnews.util.Variable;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * UserManager
 *
 * Created by patchao2000 on 14-7-14.
 */
@Component
@Transactional(readOnly = true)
public class UserManager {
    public static final int RIGHTS_USER                     = 0;
    public static final int RIGHTS_TOPIC_WRITE              = 1;
    public static final int RIGHTS_TOPIC_AUDIT              = 2;
    public static final int RIGHTS_TOPIC_DISPATCH           = 3;
    public static final int RIGHTS_ARTICLE_WRITE            = 4;
    public static final int RIGHTS_ARTICLE_AUDIT_1          = 5;
    public static final int RIGHTS_ARTICLE_AUDIT_2          = 6;
    public static final int RIGHTS_ARTICLE_AUDIT_3          = 7;
    public static final int RIGHTS_EDITOR                   = 8;
    public static final int RIGHTS_REPORTER                 = 9;
    public static final int RIGHTS_TECHNICIAN               = 10;
    public static final int RIGHTS_DEVICE_AUDIT             = 11;
    public static final int RIGHTS_STORYBOARD_WRITE         = 12;
    public static final int RIGHTS_STORYBOARD_AUDIT_1       = 13;
    public static final int RIGHTS_STORYBOARD_AUDIT_2       = 14;
    public static final int RIGHTS_STORYBOARD_TEMP_WRITE    = 15;
    public static final int RIGHTS_STORYBOARD_TEMP_AUDIT    = 16;
    public static final int RIGHTS_FILE_AUDIT               = 17;
    public static final int RIGHTS_ADMIN                    = 99;

    public static final String INFO_USER_ROLES      = "roles";

    //    @Autowired
    private IdentityService identityService;

    @Autowired
    private RoleDao roleDao;


    private Map<Integer, String> userRights;

    private Logger logger = LoggerFactory.getLogger(getClass());

    public UserManager() {
        userRights = new HashMap<Integer, String>();
        userRights.put(RIGHTS_USER, "user");
        userRights.put(RIGHTS_TOPIC_WRITE, "topicWrite");
        userRights.put(RIGHTS_TOPIC_AUDIT, "topicAudit");
        userRights.put(RIGHTS_TOPIC_DISPATCH, "topicDispatch");
        userRights.put(RIGHTS_ARTICLE_WRITE, "articleWrite");
        userRights.put(RIGHTS_ARTICLE_AUDIT_1, "articleAudit1");
        userRights.put(RIGHTS_ARTICLE_AUDIT_2, "articleAudit2");
        userRights.put(RIGHTS_ARTICLE_AUDIT_3, "articleAudit3");
        userRights.put(RIGHTS_EDITOR, "editor");
        userRights.put(RIGHTS_REPORTER, "reporter");
        userRights.put(RIGHTS_TECHNICIAN, "technician");
        userRights.put(RIGHTS_DEVICE_AUDIT, "deviceAudit");
        userRights.put(RIGHTS_STORYBOARD_WRITE, "storyboardWrite");
        userRights.put(RIGHTS_STORYBOARD_AUDIT_1, "storyboardAudit1");
        userRights.put(RIGHTS_STORYBOARD_AUDIT_2, "storyboardAudit2");
        userRights.put(RIGHTS_STORYBOARD_TEMP_WRITE, "storyboardTempWrite");
        userRights.put(RIGHTS_STORYBOARD_TEMP_AUDIT, "storyboardTempAudit");
        userRights.put(RIGHTS_FILE_AUDIT, "fileAudit");
        userRights.put(RIGHTS_ADMIN, "admin");
    }

    public boolean checkPassword(String userName, String password) {
        return identityService.checkPassword(userName, password);
    }

    public User getUserById(String userId) {
        return identityService.createUserQuery().userId(userId).singleResult();
    }

    public List<Group> getGroupListByUserId(String userId) {
        return identityService.createGroupQuery().groupMember(userId).list();
    }

    public UserQuery createUserQuery() {
        return identityService.createUserQuery();
    }

    public GroupQuery createGroupQuery() {
        return identityService.createGroupQuery();
    }

    @Transactional(readOnly = false)
    public User newUser(String userId, String firstName, String password, String email, String lastName) {
        User user = identityService.newUser(userId);
        if (!firstName.equals("null"))
            user.setFirstName(firstName);
        user.setPassword(password);
        if (!email.equals("null"))
            user.setEmail(email);
        if (!lastName.equals("null"))
            user.setLastName(lastName);
        identityService.saveUser(user);

        return user;
    }

    @Transactional(readOnly = false)
    public User modifyUser(String userId, String firstName, String password, String email, String lastName) {
        User user = getUserById(userId);
        if (!firstName.equals("null"))
            user.setFirstName(firstName);
        user.setPassword(password);
        if (!email.equals("null"))
            user.setEmail(email);
        if (!lastName.equals("null"))
            user.setLastName(lastName);
        identityService.saveUser(user);

        return user;
    }

    @Transactional(readOnly = false)
    public Boolean modifyUserPassword(String userId, String oldPassword, String newPassword) {
        if (!checkPassword(userId, oldPassword)) {
            return false;
        }

        User user = getUserById(userId);
        user.setPassword(newPassword);
        identityService.saveUser(user);

        return true;
    }

    @Transactional(readOnly = false)
    public void deleteUser(String userId) {
        identityService.deleteUser(userId);
    }

//    @Transactional(readOnly = false)
//    public void saveUser(User user) {
//        identityService.saveUser(user);
//    }

    @Transactional(readOnly = false)
    public Group newGroup(String groupId, String name) throws ActivitiException {
        GroupQuery query = createGroupQuery();
        if (query.groupId(groupId).count() > 0) {
            throw new ActivitiException("group id already exist");
        }

        Group group = identityService.newGroup(groupId);
        group.setType("assignment");
        if (!name.equals("null"))
            group.setName(name);

        identityService.saveGroup(group);

        return group;
    }

    public Group getGroupById(String groupId) {
        return identityService.createGroupQuery().groupId(groupId).singleResult();
    }

    @Transactional(readOnly = false)
    public Group modifyGroup(String groupId, String name) {
        Group group = getGroupById(groupId);
        group.setType("assignment");
        if (!name.equals("null"))
            group.setName(name);

        identityService.saveGroup(group);

        return group;
    }

    @Transactional(readOnly = false)
    public void deleteGroup(String groupId) {
        identityService.deleteGroup(groupId);
    }

    @Transactional(readOnly = false)
    public void setUserGroups(String userId, Variable var) {
        List<Group> list = getGroupListByUserId(userId);
        Map<String, Object> variables = var.getVariableMap();
        Set<String> set = variables.keySet();
        for (Object groupObj : set) {
            String group = (String)groupObj;
            Boolean v = (Boolean)variables.get(group);
            Boolean inlist = false;
            for(Group g : list) {
                if (g.getId().equals(group)) {
                    inlist = true;
                    break;
                }
            }
            if (v) {
                if (!inlist) {
                    identityService.createMembership(userId, group);
                }
            }
            else {
                if (inlist) {
                    identityService.deleteMembership(userId, group);
                }
            }
        }
    }

    public Boolean isUserInGroup(String userId, String groupId) {
//        logger.debug("isUserInGroup: {}", userId);
        List<Group> groups = identityService.createGroupQuery().groupMember(userId).list();
        for (Group group : groups) {
//            logger.debug("check group: {}, {}", group.getId(), groupId);
            if (group.getId().equals(groupId)) {
//                logger.debug("equals!!");
                return true;
            }
        }
        return false;
    }

    public List<User> getGroupMembers(String groupId) {
        return identityService.createUserQuery().memberOfGroup(groupId).list();
    }

//    public Map<String, String> getGroupMembersIdNameMap(String groupId) {
//        Map<String, String> map = new HashMap<String, String>();
//        for (User user : identityService.createUserQuery().memberOfGroup(groupId).list()) {
//            map.put(user.getId(), user.getFirstName());
//        }
//        return map;
//    }

    public String getUserRightsName(int rightsId) {
        return userRights.get(rightsId);
    }
    
    public Boolean isUserHaveRights(User user, int rights) {
        return isUserInGroup(user.getId(), userRights.get(rights));
    }

    public List<Role> getAllRoles() {
        List<Role> list = new ArrayList<Role>();
        for (Role role : roleDao.findAll())
            list.add(role);

        return list;
    }

    @Transactional(readOnly = false)
    public Role newRole(String name) {
        Role role = new Role();
        role.setName(name);
        roleDao.save(role);

        return role;
    }

    @Transactional(readOnly = false)
    public Role modifyRole(Long roleId, String name) {
        Role role = roleDao.findOne(roleId);
        role.setName(name);
        roleDao.save(role);

        return role;
    }

    @Transactional(readOnly = false)
    public void setRoleGroups(Long roleId, List<String> groupList) {
        Role role = roleDao.findOne(roleId);
        role.setGroups(groupList);
    }

    public List<String> getRoleGroups(Long roleId) {
        Role role = roleDao.findOne(roleId);
        return role.getGroups();
    }

    @Transactional(readOnly = false)
    public void deleteRole(Long roleId) {
        roleDao.delete(roleId);
    }

    public Role getRoleById(Long roleId) {
        return roleDao.findOne(roleId);
    }

    public List<Long> getUserRoles(String userId) {
        List<Long> result = new ArrayList<Long>();
        String oldRoles = identityService.getUserInfo(userId, INFO_USER_ROLES);
        if (oldRoles != null) {
            if (!oldRoles.isEmpty()) {
                String[] roles = oldRoles.split(",");
                for (int i = 0; i < roles.length; i++) {
                    result.add(Long.parseLong(roles[i]));
                }
            }
        }
        return result;
    }

    @Transactional(readOnly = false)
    public void setUserRoles(String userId, List<Long> roleIdList) {
//        logger.debug("setUserRoles begin");

        //  roleIdList ==> string, separated by ","
        StringBuilder strbuf = new StringBuilder();
        for (Long roleId : roleIdList) {
            strbuf.append(",").append(roleId.toString());
        }
        String roleInfo = "";
        if (strbuf.length() > 0) {
            roleInfo = strbuf.deleteCharAt(0).toString();
        }

        String oldRoles = identityService.getUserInfo(userId, INFO_USER_ROLES);
        logger.debug("old roles: {}", oldRoles);
        identityService.setUserInfo(userId, INFO_USER_ROLES, roleInfo);
        logger.debug("new roles: {}", roleInfo);

        //  add all group id without repeated
        HashSet<String> hs = new HashSet<String>();
        for (Long roleId : roleIdList) {
            List<String> groups = roleDao.findOne(roleId).getGroups();
            for (String g : groups) {
                hs.add(g);
            }
        }

        //  make user's group sync with role's setting
        List<Group> currentGroupList = getGroupListByUserId(userId);
        for (String mustIn : hs) {
            Boolean inCurrList = false;
            for(Group g : currentGroupList) {
                if (g.getId().equals(mustIn)) {
                    inCurrList = true;
                    break;
                }
            }
            if (!inCurrList) {
                identityService.createMembership(userId, mustIn);
            }
        }
        currentGroupList = getGroupListByUserId(userId);
        for (Group currIn : currentGroupList) {
            if (!hs.contains(currIn.getId())) {
                identityService.deleteMembership(userId, currIn.getId());
            }
        }

    }

    @Autowired
    public void setIdentityService(IdentityService identityService) {
        this.identityService = identityService;
    }
}
