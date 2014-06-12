<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-12
  Time: 下午2:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>新闻选题正在运行中的流程实例列表</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    
    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
    
    <%--<script type="text/javascript">--%>
    <%--$(function() {--%>
    <%--// 跟踪--%>
    <%--$('.trace').click(graphTrace);--%>
    <%--});--%>
    <%--</script>--%>
</head>

<body>
<table width="100%" class="need-border">
    <thead>
    <tr>
        <th>申请人</th>
        <th>申请时间</th>
        <th>标题</th>
        <th>内容</th>
        <th>设备</th>
        <th>当前节点</th>
        <th>任务创建时间</th>
        <th>流程状态</th>
        <th>当前处理人</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
    <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.Topic"--%>
    <c:forEach items="${page.result }" var="topic">
        <c:set var="task" value="${topic.task }" />
        <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
        <c:set var="pi" value="${topic.processInstance }"/>
        <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>
        
        <tr id="${topic.id }" tid="${task.id }">
            <td>${topic.userId }</td>
            <td>${topic.applyTime }</td>
            <td>${topic.title }</td>
            <td>${topic.content }</td>
            <td>${topic.devices }</td>
            <td>${task.name }</td>
            <td>${task.createTime }</td>
            <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${topic.processDefinition.version }</b></td>
            <td>${task.assignee }</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%--<tags:pagination page="${page}" paginationSize="${page.pageSize}"/>--%>
</body>
</html>
