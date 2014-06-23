<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-23
  Time: 下午5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>新闻选题结束的流程实例列表</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
</head>

<body>
<table width="100%" class="table table-hover">
    <thead>
    <tr>
        <th>申请人</th>
        <th>申请时间</th>
        <th>标题</th>
        <th>内容</th>
        <th>设备</th>
        <th>流程启动时间</th>
        <th>流程结束时间</th>
        <th>流程结束原因</th>
        <th>流程版本</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
    <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.Topic"--%>
    <c:forEach items="${page.result }" var="topic">
        <c:set var="task" value="${topic.task }" />
        <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
        <%--<c:set var="pi" value="${topic.processInstance }"/>--%>
        <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>
        <c:set var="hpi" value="${topic.historicProcessInstance }" />

        <tr id="${topic.id }" tid="${task.id }">
            <td>${topic.userId }</td>
            <td><fmt:formatDate value="${topic.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${topic.title }</td>
            <td>${topic.content }</td>
            <td>${topic.devices }</td>
            <td><fmt:formatDate value="${hpi.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><fmt:formatDate value="${hpi.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td>${hpi.deleteReason }</td>
            <td><b title='流程版本号'>V: ${topic.processDefinition.version }</b></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%--<tags:pagination page="${page}" paginationSize="${page.pageSize}"/>--%>
</body>
</html>