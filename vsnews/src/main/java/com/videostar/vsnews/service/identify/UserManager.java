package com.videostar.vsnews.service.identify;

import com.videostar.vsnews.util.Variable;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
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
    public static final int RIGHTS_TOPIC_WRITE      = 1;
    public static final int RIGHTS_TOPIC_AUDIT      = 2;
    public static final int RIGHTS_TOPIC_DISPATCH   = 3;
    public static final int RIGHTS_ARTICLE_WRITE    = 4;
    public static final int RIGHTS_ARTICLE_AUDIT_1  = 5;
    public static final int RIGHTS_ARTICLE_AUDIT_2  = 6;
    public static final int RIGHTS_ARTICLE_AUDIT_3  = 7;
    public static final int RIGHTS_EDITOR           = 8;
    public static final int RIGHTS_REPORTER         = 9;
    public static final int RIGHTS_CAMERAMAN        = 10;
    public static final int RIGHTS_DEVICE_AUDIT     = 11;

    //    @Autowired
    private IdentityService identityService;

    private Map<Integer, String> userRights;

//    private Logger logger = LoggerFactory.getLogger(getClass());

    public UserManager() {
        userRights = new HashMap<Integer, String>();
        userRights.put(RIGHTS_TOPIC_WRITE, "topicWrite");
        userRights.put(RIGHTS_TOPIC_AUDIT, "topicAudit");
        userRights.put(RIGHTS_TOPIC_DISPATCH, "topicDispatch");
        userRights.put(RIGHTS_ARTICLE_WRITE, "articleWrite");
        userRights.put(RIGHTS_ARTICLE_AUDIT_1, "articleAudit1");
        userRights.put(RIGHTS_ARTICLE_AUDIT_2, "articleAudit2");
        userRights.put(RIGHTS_ARTICLE_AUDIT_3, "articleAudit3");
        userRights.put(RIGHTS_EDITOR, "editor");
        userRights.put(RIGHTS_REPORTER, "reporter");
        userRights.put(RIGHTS_CAMERAMAN, "cameraman");
        userRights.put(RIGHTS_DEVICE_AUDIT, "deviceAudit");
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

    @Autowired
    public void setIdentityService(IdentityService identityService) {
        this.identityService = identityService;
    }
}
