package com.videostar.vsnews.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.engine.identity.User;
import org.springframework.web.servlet.ModelAndView;

/**
 * 处理session超时的拦截器
 *
 * Created by patchao2000 on 14/11/14.
 */
public class SessionTimeoutInterceptor  implements HandlerInterceptor {
    private Logger logger = LoggerFactory.getLogger(getClass());

    public String[] allowUrls;  //  还没发现可以直接配置不拦截的资源，所以在代码里面来排除

    public void setAllowUrls(String[] allowUrls) {
        this.allowUrls = allowUrls;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        String requestUrl = request.getRequestURI().replace(request.getContextPath(), "");
//        System.out.println(requestUrl);
//        logger.debug("SessionTimeoutInterceptor: {}", requestUrl);

        if (null != allowUrls && allowUrls.length >= 1)
            for(String url : allowUrls) {
                if(requestUrl.contains(url)) {
                    return true;
                }
            }

        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            return true;  //返回true，则这个方面调用后会接着调用postHandle(),  afterCompletion()
        }else{
            // 未登录  跳转到登录页面
            throw new SessionTimeoutException();    //  返回到配置文件中定义的路径
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
            throws Exception {
    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
            throws Exception {
    }

}