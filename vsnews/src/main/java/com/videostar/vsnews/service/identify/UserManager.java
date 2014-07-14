package com.videostar.vsnews.service.identify;

import com.videostar.vsnews.util.Variable;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.GroupQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.identity.UserQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * UserManager
 *
 * Created by patchao2000 on 14-7-14.
 */
@Component
@Transactional(readOnly = true)
public class UserManager {
//    @Autowired
    private IdentityService identityService;

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
        Set set = variables.keySet();
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

    @Autowired
    public void setIdentityService(IdentityService identityService) {
        this.identityService = identityService;
    }
}
