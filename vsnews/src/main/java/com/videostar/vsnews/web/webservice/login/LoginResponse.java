package com.videostar.vsnews.web.webservice.login;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * LoginResponse
 *
 * Created by patchao2000 on 14-9-15.
 */
@XmlRootElement(namespace="http://localhost/ws/login", name = "LoginResponse")
@XmlAccessorType(XmlAccessType.FIELD)
public class LoginResponse {
    private int result;

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
}
