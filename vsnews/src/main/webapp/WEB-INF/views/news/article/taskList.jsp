<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-28
  Time: 下午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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
                            <div class='title'>待办文稿任务</div>
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
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.ArticleDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <c:set var="task" value="${detail.article.task }"/>
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${detail.article.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>
                                            <tr id="${detail.article.id }" data-tid="${task.id }">
                                                <td>${detail.columnName }</td>
                                                <td>${detail.userName }</td>
                                                <td><fmt:formatDate value="${detail.article.applyTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${detail.article.mainTitle }</td>
                                                <td>${detail.plainContent }</td>
                                                <td>
                                                    <%--<a href='${ctx }/diagram-viewer/index.html?processDefinitionId=${pi.processDefinitionId}&processInstanceId=${pi.id }' title="点击查看流程图">${task.name }</a>--%>
                                                    <a class="trace" href='#' data-pid="${pi.id }" data-pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>
                                                    <%--${task.name }--%>
                                                </td>
                                                <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${detail.article.processDefinition.version }</b></td>
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
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
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
        else if (tkey == 'class1Audit' || tkey == 'class2Audit' || tkey == 'class3Audit') {
            location.href = ctx + '/news/article/apply?audit=true&id='+rowId+'&taskid='+taskId+'&tkey='+tkey;
            return;
        }

        alert(tkey + " ERROR!");
    });
});
</script>
</body>
</html>
