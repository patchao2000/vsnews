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
                                            <th>当前节点</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.TopicTaskDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <c:set var="task" value="${detail.task }"/>
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${detail.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

                                            <c:choose>
                                                <c:when test="${detail.isFileInfoTask == true}">
                                                    <tr id="${detail.fileInfo.id }" data-tid="${task.id }">
                                                </c:when>
                                                <c:otherwise>
                                                    <tr id="${detail.topic.id }" data-tid="${task.id }">
                                                </c:otherwise>
                                            </c:choose>
                                                <td>${detail.userName }</td>
                                                <td>${detail.dispatcherName }</td>
                                                <td>
                                                    <c:choose>
                                                    <c:when test="${detail.isFileInfoTask == true}">
                                                        <fmt:formatDate value="${detail.fileInfo.applyTime}" pattern="yyyy-MM-dd HH:mm" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatDate value="${detail.topic.applyTime}" pattern="yyyy-MM-dd HH:mm" />
                                                    </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                    <c:when test="${detail.isFileInfoTask == true}">
                                                        ${detail.fileInfo.title}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${detail.topic.title}
                                                    </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <%--<a class="trace" href='#' pid="${pi.id }" pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>--%>
                                                    ${task.name }
                                                </td>
                                                <td>
                                                    <%-- 此处用tkey记录当前节点的名称 --%>
                                                    <a class="handle btn btn-primary btn-xs" data-tkey='${task.taskDefinitionKey }' data-tname='${task.name }'
                                                       data-assignee="${task.assignee }" href="#"><i class="icon-edit"></i>办理</a>
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

<div class="modal fade group-dialog" id="auditModal" tabindex="-1" role="dialog" aria-labelledby="auditModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="auditModalLabel">添加素材位置</h4>
            </div>
            <div class="modal-body">
                <label for='audit_file_title'>素材名称：</label>
                <input class='form-control' name="title" id="audit_file_title">
                <label for='audit_file_path'>素材文件：</label>
                <input class='form-control' name="path" id="audit_file_path">
                <label for='audit_file_length'>素材长度：</label>
                <input class='form-control' name="length" id="audit_file_length">
                <%--<hr class='hr-normal'>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <%--<button type="button" class="btn btn-primary" id="savefile"><i class='icon-save'></i> 保存</button>--%>
                <button class='btn btn-primary' type='button' id="auditPass"><i class='icon-ok'></i> 同意</button>
                <button class='btn btn-danger' type='button' id="auditReject"><i class='icon-remove'></i> 驳回</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade group-dialog" id="reapplyModal" tabindex="-1" role="dialog" aria-labelledby="reapplyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="reapplyModalLabel">添加素材位置</h4>
            </div>
            <div class="modal-body">
                <label for='reapply_file_title'>素材名称：</label>
                <input class='form-control' name="title" id="reapply_file_title">
                <label for='reapply_file_path'>素材文件：</label>
                <input class='form-control' name="path" id="reapply_file_path">
                <label for='reapply_file_length'>素材长度：</label>
                <input class='form-control' name="length" id="reapply_file_length">
                <%--<hr class='hr-normal'>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="reapply"><i class='icon-save'></i> 提交</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
    var g_taskId = '';

    $('#auditPass').click(function () {
        var map = {};
        map["leaderPass"] = true;
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/topic/complete/' + g_taskId,
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(map),
            success: function (resp) {
                if (resp == 'success') {
                    alert('任务完成');
                } else {
                    alert('操作失败!');
                }
                location.href = ctx + '/news/topic/list/task'
            },
            error: function () {
                alert('操作失败!!');
                location.href = ctx + '/news/topic/list/task'
            }
        });
    });

    $('#auditReject').click(function () {
        var map = {};
        map["leaderPass"] = false;
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/topic/complete/' + g_taskId,
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(map),
            success: function (resp) {
                if (resp == 'success') {
                    alert('任务完成');
                } else {
                    alert('操作失败!');
                }
                location.href = ctx + '/news/topic/list/task'
            },
            error: function () {
                alert('操作失败!!');
                location.href = ctx + '/news/topic/list/task'
            }
        });
    });

    $('#reapply').click(function () {
        var map = {};
        map["title"] = $("#reapply_file_title").val();
        map["filePath"] = $("#reapply_file_path").val();
        map["lengthTC"] = $("#reapply_file_length").val();
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/topic/complete/' + g_taskId,
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(map),
            success: function (resp) {
                if (resp == 'success') {
                    alert('任务完成');
                } else {
                    alert('操作失败!');
                }
                location.href = ctx + '/news/topic/list/task'
            },
            error: function () {
                alert('操作失败!!');
                location.href = ctx + '/news/topic/list/task'
            }
        });
    });

    function handle(tkey, entityId, taskId) {
        if (tkey == 'fileInfoLeaderAudit') {
            $.getJSON(ctx + '/news/topic/detail/fileinfo/' + entityId, function(data) {
                $("#audit_file_title").val(data.title);
                $("#audit_file_path").val(data.filePath);
                $("#audit_file_length").val(data.lengthTC);

                g_taskId = taskId;
                $('#auditModal').modal('toggle');
            });

//            location.href = ctx + '/news/topic/audit-fileinfo/'+entityId+'/'+taskId;
        }
        else if (tkey == 'fileInfoModifyContent') {
            $.getJSON(ctx + '/news/topic/detail/fileinfo/' + entityId, function(data) {
                $("#reapply_file_title").val(data.title);
                $("#reapply_file_path").val(data.filePath);
                $("#reapply_file_length").val(data.lengthTC);

                g_taskId = taskId;
                $('#reapplyModal').modal('toggle');
            });
//            location.href = ctx + '/news/topic/reapply-fileinfo/'+entityId+'/'+taskId;
        }
        else if (tkey == 'modifyContent') {
            location.href = ctx + '/news/topic/reapply/'+entityId+'/'+taskId;
        }
        else if (tkey == 'adjustDevices') {
            location.href = ctx + '/news/topic/reapply-device/'+entityId+'/'+taskId;
        }
        else if (tkey == 'leaderAudit') {
            location.href = ctx + '/news/topic/audit/'+entityId+'/'+taskId+'/'+tkey;
        }
        else if (tkey == 'deviceAudit') {
            location.href = ctx + '/news/topic/audit-device/'+entityId+'/'+taskId+'/'+tkey;
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
            var entityId = $(this).parents('tr').attr('id');
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
                            handle(tkey, entityId, taskId);
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
                handle(tkey, entityId, taskId);
            }
        });
    });
</script>
</body>
</html>
