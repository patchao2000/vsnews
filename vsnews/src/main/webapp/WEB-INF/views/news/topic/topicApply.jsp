<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-4
  Time: 下午5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.videostar.vsnews.entity.news.Topic" %>
<%@ page import="com.videostar.vsnews.service.news.TopicManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%
        String paraReApply = request.getParameter("reapply");
        String paraDeviceOnly = request.getParameter("devonly");
        String ctx = request.getContextPath();
        String action = ctx + "/news/topic/start";
        String mainTitle = "创建选题";
        String title = "", content = "", devices = "";
        boolean reApplyMode = false, modifyDeviceOnly = false;
        if (paraReApply != null && paraReApply.equals("true")) {
            mainTitle = "调整申请内容";
            reApplyMode = true;
            action = "#";
            if (paraDeviceOnly != null && paraDeviceOnly.equals("true"))
                modifyDeviceOnly = true;

            ApplicationContext servctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
            TopicManager man = (TopicManager)servctx.getBean("TopicManager");
            Topic topic;

            Long id = 0L;
            if (request.getParameter("id") != null)
                id = Long.parseLong(request.getParameter("id"));
            topic = man.getTopic(id);
            title = topic.getTitle();
            content = topic.getContent();
            devices = topic.getDevices();
        }
    %>
    <title><%=mainTitle%></title>

    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>

    <% if (reApplyMode) { %>
        <script type="text/javascript">
            var taskid = '<%=request.getParameter("taskid") %>';

            $(function () {
                $( "#inputForm" ).submit(function( event ) {
                    var keys = "title,content,devices", types = "S,S,S";
                    var values = $('#title').val() + ',' + $('#content').val() + ',' + $('#devices').val();
                    $.post(ctx + '/news/topic/complete/' + taskid, {
                        keys: keys,
                        values: values,
                        types: types
                    }, function(resp) {
                        if (resp == 'success') {
                            alert('任务完成');
                            location.reload();
                        } else {
                            alert('操作失败!');
                        }
                    });

                    event.preventDefault();
                });
            });
        </script>
    <% } %>
</head>

<body>
<!-- <div class="container"> -->
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#message').hide('slow');
        }, 5000);
    </script>
</c:if>
<c:if test="${not empty error}">
    <div id="error" class="alert alert-error">${error}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#error').hide('slow');
        }, 5000);
    </script>
</c:if>
<form:form id="inputForm" action="<%=action%>" method="post" class="well col-md-8">
    <h3><%=mainTitle%></h3>
    <hr>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="title">标题：</label>
            <textarea id="title" name="title" class="form-control" rows="1"><%=title%></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="content">内容：</label>
            <textarea id="content" name="content" class="form-control" rows="5"><%=content%></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="devices">需要设备：</label>
            <textarea id="devices" name="devices" class="form-control" rows="3"><%=devices%></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-4">
            <button type="submit" class="btn btn-default">提交</button>
        </div>
    </div>
</form:form>
<!-- </div> -->
</body>
</html>
