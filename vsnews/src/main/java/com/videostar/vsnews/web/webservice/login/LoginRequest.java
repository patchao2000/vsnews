package com.videostar.vsnews.web.webservice.login;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * LoginRequest
 *
 * Created by patchao2000 on 14-9-15.
 */
@XmlRootElement(namespace="http://localhost/ws/login",name="LoginRequest")
@XmlAccessorType(XmlAccessType.FIELD)
public class LoginRequest {
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
