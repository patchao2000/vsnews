<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-5
  Time: 下午6:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <title>News待办任务列表</title>
    <%@ include file="/common/meta.jsp" %>

    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css"
          rel="stylesheet"/>
    <%-- <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" /> --%>
    <%@ include file="/common/include-custom-styles.jsp" %>
    <style type="text/css">
        /* block ui */
        .blockOverlay {
            z-index: 1004 !important;
        }

        .blockMsg {
            z-index: 1005 !important;
        }
    </style>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.js"
            type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-zh-CN.js"
            type="text/javascript"></script>
    <%-- <script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script> --%>
    <script src="${ctx }/js/common/plugins/jquery.blockUI.js" type="text/javascript"></script>
    <%-- <script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script> --%>
    <%--<script src="${ctx }/js/module/oa/entity/entity-todo.js" type="text/javascript"></script>--%>
</head>

<body>
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
</c:if>
<table style="width:100%" class="table table-striped">
    <thead>
    <tr>
        <th>申请人</th>
        <th>申请时间</th>
        <th>当前节点</th>
        <th>任务创建时间</th>
        <th>流程状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
    <c:forEach items="${page.result }" var="entity">
        <c:set var="task" value="${entity.task }"/>
        <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
        <c:set var="pi" value="${entity.processInstance }"/>
        <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

        <tr id="${entity.id }" tid="${task.id }">
            <td>${entity.userId }</td>
            <td>${entity.applyTime }</td>
            <td>
                    <%-- <a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a> --%>
                    ${task.name }
            </td>
            <td>${task.createTime }</td>
            <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${entity.processDefinition.version }</b></td>
            <td>
                <c:if test="${empty task.assignee }">
                    <a class="claim" type="button" href="${ctx }/news/task/claim/${task.id}">签收</a>
                </c:if>
                <c:if test="${not empty task.assignee }">
                    <%-- 此处用tkey记录当前节点的名称 --%>
                    <%--<a class="handle" type="button" tkey='${task.taskDefinitionKey }' tname='${task.name }' href="#">办理</a>--%>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%-- <tags:pagination page="${page}" paginationSize="${page.pageSize}"/> --%>

</body>
</html>
