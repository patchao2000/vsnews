<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-7
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>角色列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <%--<link href="${ctx}/css/_pagination.css" media="all" rel="stylesheet" type="text/css"/>--%>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    <style>
        .group-dialog .modal-dialog {
            width: 400px;
        }
    </style>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <nav class='navbar navbar-default'>
                <form class='navbar-form'>
                    <div class='navbar-left'>
                        <a id="addgroup" class="btn btn-success" title='创建新角色' href="#"><i class="icon-plus icon-white"></i> 创建</a>
                    </div>
                    <%--<div class='navbar-right'>--%>
                        <%--<div class='form-group'>--%>
                            <%--<input class='form-control' placeholder='角色名' type='text' name='LoginName' >--%>
                        <%--</div>--%>
                        <%--<button class='btn btn-default' type='submit'>搜索 <i class="icon-search"></i></button>--%>
                    <%--</div>--%>
                </form>
            </nav>
            <c:if test="${not empty message}">
                <div id="message" class="alert alert-success">${message}</div>
            </c:if>
            <div class='row'>
                <div class='col-sm-12'>
                    <div class='box bordered-box blue-border' style='margin-bottom:0;'>
                        <div class='box-header blue-background'>
                            <div class='title'>角色列表</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='data-table-column-filter table table-bordered table-striped' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <th>角色名</th>
                                            <th>说明</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="group" type="org.activiti.engine.identity.Group"--%>
                                        <c:forEach items="${list }" var="group">
                                            <tr id="${group.id }">
                                                <td>${group.id }</td>
                                                <td>${group.name }</td>
                                                <td>
                                                    <div>
                                                        <a class='btn btn-success btn-xs editgroup' href='#'>
                                                            <i class='icon-edit'></i> 编辑
                                                        </a>
                                                        <a class='btn btn-danger btn-xs deletegroup' href='#'>
                                                            <i class='icon-remove'></i> 删除
                                                        </a>
                                                    </div>
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

<div class="modal fade group-dialog" id="groupModal" tabindex="-1" role="dialog" aria-labelledby="groupModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="groupModalLabel">创建新角色</h4>
            </div>
            <div class="modal-body">
                <table>
                    <tbody>
                    <tr>
                        <td>角色名：</td>
                        <td>
                            <label for='groupid'></label>
                            <input class='form-control' name="groupid" id="groupid" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>说明：</td>
                        <td>
                            <label for='name'></label>
                            <input class='form-control' name="name" id="name" style="width:260px"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="savegroup"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var saveaction = '/user/add/group/';
        $('#addgroup').click(function () {
            $('#groupModal').modal('toggle');
        });

        $('.editgroup').click(function () {
            var groupId = $(this).parents('tr').attr('id');
            $.getJSON(ctx + '/user/detail/group/' + groupId, function(data) {
                $.each(data, function(k, v) {
                    if (k == 'id')
                        $('#groupid').val(v);
                    else
                        $("#" + k.toLowerCase()).val(v);
                });
                if ($.isFunction(callback)) {
                    callback(data);
                }
            });
            $('#groupModalLabel').text('修改角色');
            $('#groupid').prop('readonly', true);
            saveaction = '/user/modify/group/';

            $('#groupModal').modal('toggle');
        });

        $('#savegroup').click(function () {
            var groupid = $('#groupid').val();
            if (groupid.length == 0) {
                alert('角色名为空！');
                return;
            }
            var name = $('#name').val();
            if (name.length == 0) {
                name = "null";
            }

            $.post(ctx + saveaction + groupid + '/' + name,
                    function(resp) {
                        if (resp == 'success') {
                            alert('任务完成');
                            location.href = ctx + '/user/list/group';
                        } else {
                            alert('操作失败!');
                        }
                    });
        });

        $('.deletegroup').click(function () {
            var groupId = $(this).parents('tr').attr('id');
            var dialog = new BootstrapDialog({
                type: BootstrapDialog.TYPE_WARNING,
                title: '删除角色',
                message: '<div><h3>真要删除角色' + groupId + '吗？</h3></div>',
                buttons: [{
                    icon: 'icon-remove',
                    label: '删除',
                    cssClass: 'btn-danger',
                    action: function(){
                        $.post(ctx + '/user/delete/group/' + groupId,
                                function(resp) {
                                    if (resp == 'success') {
                                        alert('任务完成');
                                        location.href = ctx + '/user/list/group';
                                    } else {
                                        alert('操作失败!');
                                    }
                                });
                    }
                }, {
                    label: '关闭',
                    action: function(dialog){
                        dialog.close();
                    }
                }]
            });
            dialog.realize();
            dialog.open();

        });
    });
</script>
</body>
</html>
