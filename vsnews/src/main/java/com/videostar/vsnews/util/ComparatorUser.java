package com.videostar.vsnews.util;

import org.activiti.engine.identity.User;

import java.util.Comparator;

/**
 * ComparatorUser
 *
 * Created by patchao2000 on 14-8-15.
 */
public class ComparatorUser implements Comparator {
    public int compare(Object arg0, Object arg1) {
        User user0 = (User)arg0;
        User user1 = (User)arg1;

        return user0.getFirstName().compareTo(user1.getFirstName());
    }
}

