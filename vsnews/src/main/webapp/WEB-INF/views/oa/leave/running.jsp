<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-3
  Time: 下午4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <title>请假正在运行中的流程实例列表</title>
    <%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <%--<link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />--%>
    <%@ include file="/common/include-custom-styles.jsp" %>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <%--<script src="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/common/plugins/jquery-ui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>--%>
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
        <th>假种</th>
        <th>申请人</th>
        <th>申请时间</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>当前节点</th>
        <th>任务创建时间</th>
        <th>流程状态</th>
        <th>当前处理人</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
    <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
    <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>
    <c:forEach items="${page.result }" var="leave">
        <c:set var="task" value="${leave.task }" />
        <c:set var="pi" value="${leave.processInstance }" />
        <tr id="${leave.id }" tid="${task.id }">
            <td>${leave.leaveType }</td>
            <td>${leave.userId }</td>
            <td>${leave.applyTime }</td>
            <td>${leave.startTime }</td>
            <td>${leave.endTime }</td>
            <td>${task.name }
                <%--<a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>--%>
            </td>
            <td>${task.createTime }</td>
            <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${leave.processDefinition.version }</b></td>
            <td>${task.assignee }</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%--<tags:pagination page="${page}" paginationSize="${page.pageSize}"/>--%>
</body>
</html>
