<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-6
  Time: 下午5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>待办选题任务</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">

    <%--<%@ include file="/common/include-base-styles.jsp" %>--%>
    <%--<%@ include file="/common/include-jquery-ui-theme.jsp" %>--%>
    <%--<%@ include file="/common/include-custom-styles.jsp" %>--%>
    <%--<style type="text/css">--%>
    <%--.blockOverlay { z-index: 1004 !important; }--%>
    <%--.blockMsg { z-index: 1005 !important; }--%>
    <%--</style>--%>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <%--<script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/common/plugins/jquery.blockUI.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/module/news/topic/topic.js" type="text/javascript"></script>--%>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
    <script type="text/javascript">
        function complete(taskId, variables) {
//            var dialog = this;

            // 转换JSON为字符串
            var keys = "", values = "", types = "";
            if (variables) {
                $.each(variables, function() {
                    if (keys != "") {
                        keys += ",";
                        values += ",";
                        types += ",";
                    }
                    keys += this.key;
                    values += this.value;
                    types += this.type;
                });
            }

//            $.blockUI({
//                message: '<h2><img src="' + ctx + '/images/ajax/loading.gif" align="absmiddle"/>正在提交请求……</h2>'
//            });

            // 发送任务完成请求
            $.post(ctx + '/news/topic/complete/' + taskId, {
                keys: keys,
                values: values,
                types: types
            }, function(resp) {
//                $.unblockUI();
                if (resp == 'success') {
                    alert('任务完成');
                    location.reload();
                } else {
                    alert('操作失败!');
                }
            });
        }

        var handleOpts = {
            leaderAudit: {
                width: 300,
                height: 300,
                buttons: [
                    {
                        id: 'btn-agree',
                        label: '同意',
                        cssClass: 'btn-primary',
                        action: function(dialogRef){
                            var taskId = dialogRef.getData('taskId');

                            // 设置流程变量
                            complete(taskId, [
                                {
                                    key: 'leaderPass',
                                    value: true,
                                    type: 'B'
                                }
                            ]);
                        }
                    },
                    {
                        id: 'btn-reject',
                        label: '驳回',
                        action: function(dialogRef){
                            var taskId = dialogRef.getData('taskId');

                            var rejcontent = $('<div/>', {
                                title: '填写驳回理由',
                                html: "<textarea id='leaderBackReason' style='width: 250px; height: 60px;'></textarea>"
                            });

                            var rejdialog = new BootstrapDialog({
//                                title: '流程办理[' + tname + ']',
                                message: rejcontent,
                                data: { 'taskId': taskId },
                                buttons: [
                                    {
                                        label: '驳回',
                                        action: function(dialogRef){
                                            var leaderBackReason = $('#leaderBackReason').val();
                                            if (leaderBackReason == '') {
                                                alert('请输入驳回理由！');
                                                return;
                                            }

                                            // 设置流程变量
                                            complete(taskId, [
                                                {
                                                    key: 'leaderPass',
                                                    value: false,
                                                    type: 'B'
                                                },
                                                {
                                                    key: 'leaderBackReason',
                                                    value: leaderBackReason,
                                                    type: 'S'
                                                }
                                            ]);
                                        }
                                    },
                                    {
                                        label: '取消',
                                        action: function(dialogRef){
                                            dialogRef.close();
                                        }
                                    }
                                ]
                            });
                            rejdialog.realize();
                            rejdialog.open();
                        }
                    },
                    {
                        id: 'btn-cancel',
                        label: '取消',
                        action: function(dialogRef){
                            dialogRef.close();
                        }
                    }
                ]
            },
            deviceAudit: {
                width: 300,
                height: 300,
                buttons: [
                    {
                        id: 'btn-agree',
                        label: '同意',
                        cssClass: 'btn-primary',
                        action: function(dialogRef){
                            var taskId = dialogRef.getData('taskId');

                            // 设置流程变量
                            complete(taskId, [
                                {
                                    key: 'devicePass',
                                    value: true,
                                    type: 'B'
                                }
                            ]);
                        }
                    },
                    {
                        id: 'btn-reject',
                        label: '驳回',
                        action: function(dialogRef){
                            var taskId = dialogRef.getData('taskId');

                            var rejcontent = $('<div/>', {
                                title: '填写驳回理由',
                                html: "<textarea id='deviceBackReason' style='width: 250px; height: 60px;'></textarea>"
                            });

                            var rejdialog = new BootstrapDialog({
//                                title: '流程办理[' + tname + ']',
                                message: rejcontent,
                                data: { 'taskId': taskId },
                                buttons: [
                                    {
                                        label: '驳回',
                                        action: function(dialogRef){
                                            var deviceBackReason = $('#deviceBackReason').val();
                                            if (deviceBackReason == '') {
                                                alert('请输入驳回理由！');
                                                return;
                                            }

                                            // 设置流程变量
                                            complete(taskId, [
                                                {
                                                    key: 'devicePass',
                                                    value: false,
                                                    type: 'B'
                                                },
                                                {
                                                    key: 'deviceBackReason',
                                                    value: deviceBackReason,
                                                    type: 'S'
                                                }
                                            ]);
                                        }
                                    },
                                    {
                                        label: '取消',
                                        action: function(dialogRef){
                                            dialogRef.close();
                                        }
                                    }
                                ]
                            });
                            rejdialog.realize();
                            rejdialog.open();
                        }
                    },
                    {
                        id: 'btn-cancel',
                        label: '取消',
                        action: function(dialogRef){
                            dialogRef.close();
                        }
                    }
                ]
            }
        };

        function loadDetail(id, content) {
            $.getJSON(ctx + '/news/topic/detail/' + id, function(data) {
                $.each(data, function(k, v) {
//                    // 格式化日期
//                    if (k == 'applyTime') {
//                        $('.view-info td[name=' + k + ']', dialog).text(new Date(v).format('yyyy-MM-dd hh:mm'));
//                    } else {
//                        $('.view-info td[name=' + k + ']', dialog).text(v);
//                    }
                    $(content).find('td[name=' + k + ']').text(v);
                });
            });
        }

        $(document).ready(function () {
            $('.handle').click(function () {
                // 当前节点的英文名称
                var tkey = $(this).attr('tkey');
                // 当前节点的中文名称
                var tname = $(this).attr('tname');
                // 记录ID
                var rowId = $(this).parents('tr').attr('id');
                // 任务ID
                var taskId = $(this).parents('tr').attr('tid');

                var content = $('#' + tkey).clone().attr("style", "display: block");
                loadDetail(rowId, content);

                var dialog = new BootstrapDialog({
                    title: '流程办理[' + tname + ']',
                    message: content,
                    data: { 'taskId': taskId },
                    buttons: handleOpts[tkey].buttons
                });
                dialog.realize();
                dialog.open();

            });
        });
    </script>

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
        <th>标题</th>
        <th>内容</th>
        <th>设备</th>
        <th>当前节点</th>
        <th>任务创建时间</th>
        <th>流程状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
    <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.Topic"--%>
    <c:forEach items="${page.result }" var="topic">
        <c:set var="task" value="${topic.task }"/>
        <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
        <c:set var="pi" value="${topic.processInstance }"/>
        <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

        <tr id="${topic.id }" tid="${task.id }">
            <td>${topic.userId }</td>
            <td>${topic.applyTime }</td>
            <td>${topic.title }</td>
            <td>${topic.content }</td>
            <td>${topic.devices }</td>
            <td>
                    <%-- <a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a> --%>
                    ${task.name }
            </td>
            <td>${task.createTime }</td>
            <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${topic.processDefinition.version }</b></td>
            <td>
                <c:if test="${empty task.assignee }">
                    <a class="claim" type="button" href="${ctx }/news/topic/task/claim/${task.id}">签收</a>
                </c:if>
                <c:if test="${not empty task.assignee }">
                    <%-- 此处用tkey记录当前节点的名称 --%>
                    <a class="handle" type="button" tkey='${task.taskDefinitionKey }' tname='${task.name }'
                       href="#">办理</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%-- <tags:pagination page="${page}" paginationSize="${page.pageSize}"/> --%>

<%--<button class="btn btn-primary" id="test">Run the code</button>--%>

<div id="leaderAudit" style="display: none">
    <table class='view-info'>
        <tr>
            <td>申请人：</td>
            <td name="userId"></td>
        </tr>
        <tr>
            <td>申请时间：</td>
            <td name="applyTime"></td>
        </tr>
        <tr>
            <td>标题：</td>
            <td name="title"></td>
        </tr>
        <tr>
            <td>内容：</td>
            <td name="content"></td>
        </tr>
        <tr>
            <td>设备：</td>
            <td name="devices"></td>
        </tr>
    </table>
</div>

<div id="deviceAudit" style="display: none">
    <table class='view-info'>
        <tr>
            <td>申请人：</td>
            <td name="userId"></td>
        </tr>
        <tr>
            <td>申请时间：</td>
            <td name="applyTime"></td>
        </tr>
        <tr>
            <td>标题：</td>
            <td name="title"></td>
        </tr>
        <tr>
            <td>内容：</td>
            <td name="content"></td>
        </tr>
        <tr>
            <td>设备：</td>
            <td name="devices"></td>
        </tr>
    </table>
</div>

</body>
</html>
