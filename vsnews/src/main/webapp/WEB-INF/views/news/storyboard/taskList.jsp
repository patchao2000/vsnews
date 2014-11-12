<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-10-14
  Time: 上午11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>待办新闻串联单任务</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <c:if test="${not empty message}">
                <div id="message" class="alert alert-success">${message}</div>
            </c:if>
            <div class='row'>
                <div class='col-sm-12'>
                    <div class='box bordered-box blue-border' style='margin-bottom:0;'>
                        <div class='box-header blue-background'>
                            <div class='title'>待办串联单任务</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class="data-table table table-bordered table-striped" style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <th>申请人</th>
                                            <th>申请时间</th>
                                            <th>类别</th>
                                            <th>标题</th>
                                            <th>当前节点</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.StoryboardTaskDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <tr id="${detail.entityId }" data-tid="${detail.task.id }" data-temp-task="${detail.isTemplateTask }">
                                                <td>${detail.userName }</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${detail.isTemplateTask == true}">
                                                            <fmt:formatDate value="${detail.template.applyTime}" pattern="yyyy-MM-dd HH:mm" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatDate value="${detail.storyboard.applyTime}" pattern="yyyy-MM-dd HH:mm" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${detail.isTemplateTask == true}">模板</c:when>
                                                        <c:otherwise>串联单</c:otherwise>
                                                    </c:choose>
                                                <td>${detail.title }</td>
                                                <td>
                                                    <%--<a href='${ctx }/diagram-viewer/index.html?processDefinitionId=${pi.processDefinitionId}&processInstanceId=${pi.id }' title="点击查看流程图">${task.name }</a>--%>
                                                    <%--<a class="trace" href='#' data-pid="${detail.processInstance.id }"--%>
                                                    <%--data-pdid="${detail.processInstance.processDefinitionId}" title="点击查看流程图">${detail.task.name }</a>--%>
                                                    ${detail.task.name }
                                                </td>
                                                <td>
                                                    <a class="handle btn btn-primary btn-xs" data-tkey='${detail.task.taskDefinitionKey }'
                                                       data-tname='${detail.task.name }'
                                                       data-assignee="${detail.task.assignee }" href="#"><i class="icon-edit"></i>办理</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
    function handle(tkey, entityId, taskId, isTempTask) {
        if (isTempTask) {
            if (tkey == 'modifyContent') {
                location.href = ctx + '/news/storyboard/reapply/template/' + entityId + '/' + taskId;
            }
            else if (tkey == 'leaderAudit') {
                location.href = ctx + '/news/storyboard/audit/template/' + entityId + '/' + taskId;
            }
            else
                alert("ERROR!");
        }
        else {
            if (tkey == 'modifyForAudit1' || tkey == 'modifyForAudit2') {
                location.href = ctx + '/news/storyboard/reapply/' + entityId + '/' + taskId;
            }
            else if (tkey == 'class1Audit' || tkey == 'class2Audit') {
                location.href = ctx + '/news/storyboard/audit/' + entityId + '/' + taskId;
            }
            else
                alert("ERROR!");
        }
    }

    $(document).ready(function () {
        $('.trace').click(function() {
            var dialog = new BootstrapDialog({
                title: '123',
                message: "<img src='" + ctx + '/workflow/process/trace/auto/' + $(this).attr('data-pid') + "' />",
                buttons: [{
                    id: 'btn-close',
                    label: 'Close',
                    action: function(dialogRef){
                        dialogRef.close();
                    }
                }]
            });
            dialog.realize();
            dialog.open();

        });

        $('.handle').click(function () {
            var assignee = $(this).attr('data-assignee');
            // 当前节点的英文名称
            var tkey = $(this).attr('data-tkey');
            // 记录ID
            var entityId = $(this).parents('tr').attr('id');
            // 任务ID
            var taskId = $(this).parents('tr').attr('data-tid');
            var isTempTask = ($(this).parents('tr').attr('data-temp-task') == "true");

            if (assignee.length == 0) {
                $.ajax({
                    type: 'post',
                    async: true,
                    url: ctx + '/news/storyboard/task/claim/' + taskId,
                    contentType: "application/json; charset=utf-8",
                    success: function (resp) {
                        if (resp == 'success') {
                            handle(tkey, entityId, taskId, isTempTask);
                        } else {
                            alert('任务签收失败!');
                        }
                    },
                    error: function () {
                        alert('任务签收失败!!');
                    }
                });

            }
            else {
                handle(tkey, entityId, taskId, isTempTask);
            }
        });
    });
</script>
</body>
</html>
