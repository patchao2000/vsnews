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

                    <tr id="${topic.id }" data-tid="${task.id }">
                        <td>${topic.userId }</td>
                        <td><fmt:formatDate value="${topic.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${topic.title }</td>
                        <td>${topic.content }</td>
                        <td>${topic.devices }</td>
                        <td>
                            <%--<a href='${ctx }/diagram-viewer/index.html?processDefinitionId=${pi.processDefinitionId}&processInstanceId=${pi.id }' title="点击查看流程图">${task.name }</a>--%>
                            <a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>
                        <%--${task.name }--%>
                        </td>
                        <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${topic.processDefinition.version }</b></td>
                        <td>

                            <c:if test="${empty task.assignee }">
                                <a class="btn btn-success btn-xs" href="${ctx }/news/topic/task/claim/${task.id}">
                                    <i class="icon-edit"></i>签收</a>
                            </c:if>
                            <c:if test="${not empty task.assignee }">
                                <%-- 此处用tkey记录当前节点的名称 --%>
                                <a class="handle btn btn-primary btn-xs" data-tkey='${task.taskDefinitionKey }' data-tname='${task.name }'
                                   href="#"><i class="icon-edit"></i>办理</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <%-- <tags:pagination page="${page}" paginationSize="${page.pageSize}"/> --%>

            <div id="leaderAudit" style="display: none">
                <%@include file="view-form.jsp" %>
            </div>

            <div id="deviceAudit" style="display: none">
                <%@include file="view-form.jsp" %>
            </div>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
function complete(taskId, variables) {
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
                        html: "<div class='form-group'><textarea id='leaderBackReason' class='form-control' rows='2'></textarea></div>"
                    });

                    var rejdialog = new BootstrapDialog({
//                                title: '流程办理[' + tname + ']',
                        title: '填写驳回理由',
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
                        html: "<div class='form-group'><textarea id='deviceBackReason' class='form-control' rows='2'></textarea></div>"
                    });

                    var rejdialog = new BootstrapDialog({
//                                title: '流程办理[' + tname + ']',
                        title: '填写驳回理由',
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

Date.prototype.format = function(format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    };
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
};

function loadDetail(id, content) {
    $.getJSON(ctx + '/news/topic/detail/' + id, function(data) {
        $.each(data, function(k, v) {
            // 格式化日期
            if (k == 'applyTime') {
                $(content).find('td[data-name=' + k + ']').text(new Date(v).format('yyyy-MM-dd hh:mm'));
            } else {
                $(content).find('td[data-name=' + k + ']').text(v);
            }
        });
    });
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

    })
    $('.handle').click(function () {
        // 当前节点的英文名称
        var tkey = $(this).attr('data-tkey');
        // 当前节点的中文名称
        var tname = $(this).attr('data-tname');
        // 记录ID
        var rowId = $(this).parents('tr').attr('id');
        // 任务ID
        var taskId = $(this).parents('tr').attr('data-tid');

        //  若调整申请内容
        if (tkey == 'modifyLeaderApply') {
//            window.parent.addOrSwitchToTab('news/topic/apply?reapply=true&id='+rowId+'&taskid='+taskId, '调整申请内容');
            location.href = ctx + '/news/topic/apply?reapply=true&id='+rowId+'&taskid='+taskId;
            return;
        }
        else if (tkey == 'modifyDeviceApply') {
//            window.parent.addOrSwitchToTab('news/topic/apply?reapply=true&devonly=true&id='+rowId+'&taskid='+taskId, '调整设备申请内容');
            location.href = ctx + '/news/topic/apply?reapply=true&devonly=true&id='+rowId+'&taskid='+taskId;
            return;
        }

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
</body>
</html>
