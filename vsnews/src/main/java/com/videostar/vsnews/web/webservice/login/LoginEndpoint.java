package com.videostar.vsnews.web.webservice.login;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

/**
 * LoginEndpoint
 *
 * Created by patchao2000 on 14-9-15.
 */
@Endpoint
public class LoginEndpoint {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @PayloadRoot(namespace="http://localhost/ws/login",localPart="LoginRequest")
    @ResponsePayload
    public LoginResponse login(@RequestPayload LoginRequest request) {

        logger.debug("webservice: login request {}", request);
        logger.debug("webservice: login {} {}", request.getUsername(), request.getPassword());
        LoginResponse response = new LoginResponse();
        response.setResult(0);

        return response;
    }

}
