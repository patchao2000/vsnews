<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-28
  Time: 下午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>待办文稿任务</title>
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
                            <div class='title'>新闻文稿</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class="data-table-column-filter table table-bordered table-striped" style='margin-bottom:0;' id="tasklist">
                                        <thead>
                                        <tr>
                                            <th>栏目</th>
                                            <th>申请人</th>
                                            <th>申请时间</th>
                                            <th>标题</th>
                                            <th>内容</th>
                                            <th>当前节点</th>
                                            <th>任务创建时间</th>
                                            <th>流程状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="article" type="com.videostar.vsnews.entity.news.NewsArticle"--%>
                                        <c:forEach items="${list }" var="article">
                                            <c:set var="task" value="${article.task }"/>
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${article.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

                                            <tr id="${article.id }" data-tid="${task.id }">
                                                <td>${article.columnId }</td>
                                                <td>${article.userId }</td>
                                                <td><fmt:formatDate value="${article.applyTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${article.mainTitle }</td>
                                                <td>${article.content }</td>
                                                <td>
                                                    <%--<a href='${ctx }/diagram-viewer/index.html?processDefinitionId=${pi.processDefinitionId}&processInstanceId=${pi.id }' title="点击查看流程图">${task.name }</a>--%>
                                                    <a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>
                                                    <%--${task.name }--%>
                                                </td>
                                                <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${article.processDefinition.version }</b></td>
                                                <td>

                                                    <c:if test="${empty task.assignee }">
                                                        <a class="btn btn-success btn-xs" href="${ctx }/news/article/task/claim/${task.id}">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>

        <div id="class1Audit" style="display: none">
            <%@include file="view-form.jsp" %>
        </div>
        <div id="class2Audit" style="display: none">
            <%@include file="view-form.jsp" %>
        </div>
        <div id="class3Audit" style="display: none">
            <%@include file="view-form.jsp" %>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
function complete(taskid, varmap) {
    // 发送任务完成请求
    $.ajax({
        type: 'post',
        async: false,
        url: ctx + '/news/article/complete/' + taskid,
        contentType: "application/json; charset=utf-8",
        data : JSON.stringify(varmap),
        success: function (resp) {
            if (resp == 'success') {
                alert('任务完成');
                location.href = ctx + '/news/article/list/task'
            } else {
                alert('操作失败!');
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert('操作失败!!');
        }
    });
}

var handleOpts = {
    buttons: [
        {
            id: 'btn-agree',
            label: '同意',
            cssClass: 'btn-primary',
            action: function(dialogRef){
                var taskId = dialogRef.getData('taskId');
                var auditPass = dialogRef.getData('auditPass');
                var map = {};
                map[auditPass] = true;

                complete(taskId, map);
            }
        },
        {
            id: 'btn-reject',
            label: '驳回',
            action: function(dialogRef){
                var taskId = dialogRef.getData('taskId');
                var auditPass = dialogRef.getData('auditPass');

                var rejcontent = $('<div/>', {
                    title: '填写驳回理由',
                    html: "<div class='form-group'><textarea id='auditBackReason' class='form-control' rows='2'></textarea></div>"
                });

                var rejdialog = new BootstrapDialog({
                    title: '填写驳回理由',
                    message: rejcontent,
                    data: { 'taskId': taskId },
                    buttons: [
                        {
                            label: '驳回',
                            action: function(dialogRef){
                                var auditBackReason = $('#auditBackReason').val();
                                if (auditBackReason == '') {
                                    alert('请输入驳回理由！');
                                    return;
                                }

                                var map = {};
                                map[auditPass] = false;
                                map['auditBackReason'] = auditBackReason;
                                complete(taskId, map);
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
};

function loadDetail(id, content) {
    $.getJSON(ctx + '/news/article/detail/' + id, function(data) {
        $.each(data, function(k, v) {
            // 格式化日期
            if (k == 'applyTime' || k == 'interviewTime') {
                $(content).find('td[data-name=' + k + ']').text(new Date(v).format('yyyy-MM-dd hh:mm'));
            } else {
                $(content).find('td[data-name=' + k + ']').text(v);
            }
        });
    });
}

$(document).ready(function () {
//    var colmap = {};
//    $.ajaxSettings.async = false;
//    $.getJSON(ctx + '/news/column/objlist/allcolumns', function (data) {
//        $.each(data, function (dk, dv) {
//            var colid;
//            $.each(dv, function (k, v) {
//                if (k == 'id') {
//                    colid = v + "";
//                }
//                else if (k == 'name') {
//                    colmap[colid] = v;
//                }
//            });
//        });
//    });
//    $.ajaxSettings.async = true;
//    $("table #tasklist tr").each(function () {
//        alert($(this).first('td').text());
////                html());
//    });

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
        if (tkey == 'modifyForAudit1' || tkey == 'modifyForAudit2' || tkey == 'modifyForAudit3') {
            location.href = ctx + '/news/article/apply?reapply=true&id='+rowId+'&taskid='+taskId;
            return;
        }

        var content = $('#' + tkey).clone().attr("style", "display: block");
        loadDetail(rowId, content);
        var auditPass;
        switch (tkey) {
            case 'class1Audit':
                auditPass = 'audit1Pass';
                break;
            case 'class2Audit':
                auditPass = 'audit2Pass';
                break;
            case 'class3Audit':
                auditPass = 'audit3Pass';
                break;
        }

        var dialog = new BootstrapDialog({
            title: '流程办理[' + tname + ']',
            message: content,
            data: { 'taskId': taskId,
                    'auditPass': auditPass },
            buttons: handleOpts.buttons
        });
        dialog.realize();
        dialog.open();

    });
});
</script>
</body>
</html>
