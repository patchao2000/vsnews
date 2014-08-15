<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-6
  Time: 下午5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>待办新闻选题任务</title>
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
                            <div class='title'>待办选题任务</div>
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
                                            <th>派遣人</th>
                                            <th>申请时间</th>
                                            <th>标题</th>
                                            <%--<th>内容</th>--%>
                                            <%--<th>设备</th>--%>
                                            <th>当前节点</th>
                                            <%--<th>任务创建时间</th>--%>
                                            <%--<th>流程状态</th>--%>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.TopicDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <c:set var="task" value="${detail.topic.task }"/>
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${detail.topic.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

                                            <tr id="${detail.topic.id }" data-tid="${task.id }">
                                                <td>${detail.userName }</td>
                                                <td>${detail.dispatcherName }</td>
                                                <td><fmt:formatDate value="${detail.topic.applyTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${detail.topic.title }</td>
                                                <%--<td>${topic.content }</td>--%>
                                                <%--<td>${topic.devices }</td>--%>
                                                <td>
                                                    <%--<a href='${ctx }/diagram-viewer/index.html?processDefinitionId=${pi.processDefinitionId}&processInstanceId=${pi.id }' title="点击查看流程图">${task.name }</a>--%>
                                                    <a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>
                                                <%--${task.name }--%>
                                                </td>
                                                <%--<td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>--%>
                                                <%--<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${topic.processDefinition.version }</b></td>--%>
                                                <td>

                                                    <%--<c:if test="${empty task.assignee }">--%>
                                                        <%--<a class="btn btn-success btn-xs" href="${ctx }/news/topic/task/claim/${task.id}">--%>
                                                            <%--<i class="icon-edit"></i>签收</a>--%>
                                                    <%--</c:if>--%>
                                                    <%--<c:if test="${not empty task.assignee }">--%>
                                                        <%-- 此处用tkey记录当前节点的名称 --%>
                                                        <a class="handle btn btn-primary btn-xs" data-tkey='${task.taskDefinitionKey }' data-tname='${task.name }'
                                                           data-assignee="${task.assignee }" href="#"><i class="icon-edit"></i>办理</a>
                                                    <%--</c:if>--%>
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
    function handle(tkey, topicId, taskId) {
        if (tkey == 'modifyContent') {
            location.href = ctx + '/news/topic/reapply/'+topicId+'/'+taskId;
        }
        else if (tkey == 'adjustDevices') {
            location.href = ctx + '/news/topic/reapply-device/'+topicId+'/'+taskId;
        }
        else if (tkey == 'leaderAudit') {
            location.href = ctx + '/news/topic/audit/'+topicId+'/'+taskId+'/'+tkey;
        }
        else if (tkey == 'deviceAudit') {
            location.href = ctx + '/news/topic/audit-device/'+topicId+'/'+taskId+'/'+tkey;
        }
        else if (tkey == 'dispatching') {
            var map = {};
            $.ajax({
                type: 'post',
                async: true,
                url: ctx + '/news/topic/complete/' + taskId,
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('派遣任务完成');
                        location.href = ctx + '/news/topic/list/task'
                    } else {
                        alert('操作失败!');
                    }
                },
                error: function () {
                    alert('操作失败!!');
                }
            });
        }
        else
            alert("ERROR!");
    }

    $(document).ready(function () {
        $('.trace').click(function() {
            var dialog = new BootstrapDialog({
                title: '123',
                message: "<img src='" + ctx + '/workflow/process/trace/auto/' + $(this).attr('pid') + "' />",
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
            var topicId = $(this).parents('tr').attr('id');
            // 任务ID
            var taskId = $(this).parents('tr').attr('data-tid');

            if (assignee.length == 0) {
                $.ajax({
                    type: 'post',
                    async: true,
                    url: ctx + '/news/topic/task/claim/' + taskId,
                    contentType: "application/json; charset=utf-8",
                    success: function (resp) {
                        if (resp == 'success') {
                            handle(tkey, topicId, taskId);
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
                handle(tkey, topicId, taskId);
            }
        });
    });
</script>
</body>
</html>
