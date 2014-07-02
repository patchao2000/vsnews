package com.videostar.vsnews.web.identify;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

//import javax.sql.DataSource;

import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

@ContextConfiguration("/applicationContext.xml")
public class UserControllerTest extends AbstractTransactionalJUnit4SpringContextTests {

//    protected DataSource dataSource;
    private static Logger logger = LoggerFactory.getLogger(UserControllerTest.class);

    @Autowired
    private IdentityService identityService;

    @org.junit.Before
    public void setUp() throws Exception {
    }

    @org.junit.After
    public void tearDown() throws Exception {

    }

    @org.junit.Test
    public void testLogon() throws Exception {
        UserController c = new UserController();
        c.setIdentityService(identityService);
        MockHttpSession session = new MockHttpSession();
        String view = c.logon("leader", "000000", session);
        assertEquals("redirect:/main/index", view);
        assertNotNull(session.getAttribute("user"));
        User user = (User) session.getAttribute("user");
        assertEquals("leader", user.getId());
    }

    @org.junit.Test
    public void testUserQuery() throws Exception {
        List<User> list = identityService.createUserQuery().list();
        for (User user : list) {
            logger.debug(user.getId());
        }

    }

//    @Override
//    @Autowired
//    public void setDataSource(DataSource dataSource) {
//        super.setDataSource(dataSource);
//        this.dataSource = dataSource;
//    }
}