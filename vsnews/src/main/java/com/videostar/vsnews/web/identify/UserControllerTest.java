package com.videostar.vsnews.web.identify;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import javax.sql.DataSource;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

@ContextConfiguration("/applicationContext.xml")
public class UserControllerTest extends AbstractTransactionalJUnit4SpringContextTests {

    protected DataSource dataSource;

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
        String view = c.logon("kafeitu", "000000", session);
        assertEquals("redirect:/main/index", view);
        assertNotNull(session.getAttribute("user"));
        User user = (User) session.getAttribute("user");
        assertEquals("kafeitu", user.getId());
    }

    @org.junit.Test
    public void testLogout() throws Exception {

    }

    @Override
    @Autowired
    public void setDataSource(DataSource dataSource) {
        super.setDataSource(dataSource);
        this.dataSource = dataSource;
    }
}