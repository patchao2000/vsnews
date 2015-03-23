<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-8-6
  Time: 上午12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>角色列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    <style>
        .role-dialog .modal-dialog {
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
                        <a id="addRole" class="btn btn-success" title='创建新角色' href="#"><i class="icon-plus icon-white"></i> 创建</a>
                    </div>
                    <%--<div class='navbar-right'>--%>
                    <%--<div class='form-role'>--%>
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
                                    <table class='data-table table table-bordered table-striped' style='margin-bottom:0;'
                                            id="roleListTable">
                                        <thead>
                                        <tr>
                                            <th>角色名</th>
                                            <%--<th>说明</th>--%>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="role" type="com.videostar.vsnews.entity.Role"--%>
                                        <c:forEach items="${list }" var="role">
                                            <tr id="${role.id }" data-name="${role.name }">
                                                <%--<td>${role.id }</td>--%>
                                                <td>${role.name }</td>
                                                <td>
                                                    <div>
                                                        <a class='btn btn-success btn-xs editRole' href='#'>
                                                            <i class='icon-edit'></i> 编辑
                                                        </a>
                                                        <a class='btn btn-danger btn-xs deleteRole' href='#'>
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

<div class="modal fade role-dialog" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="roleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="roleModalLabel">创建新角色</h4>
            </div>
            <div class="modal-body">
                <table>
                    <tbody>
                    <tr>
                        <td>角色名：</td>
                        <td>
                            <%--<label for='name'></label>--%>
                            <input class='form-control' name="name" id="name" style="width:260px">
                        </td>
                    </tr>
                    <tr>
                        <td>权限：</td>
                        <td id="groups"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveRole"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">

    function fillGroupsCheckBoxes() {
        $.getJSON(ctx + '/user/objlist/allgroups', function(data) {
            var groups = '';
            var template = "<div class='checkbox'><label><input type='checkbox' value='' id='#id'>  #name</label></div>";
            $.each(data, function(dk, dv) {
                var curr = template;
                $.each(dv, function(k, v) {
                    var id = '';
                    if (k == 'id') {
                        curr = curr.replace(/#id/g, 'group_' + v);
                    }
                    else if (k == 'name') {
                        curr = curr.replace(/#name/g, v);
                    }
                });
                groups += curr;
            });
            $('#groups').html(groups);
        });
    }

    function modifyGroups(roleId, variables) {
        var keys = "", values = "", types = "";
        if (variables) {
            $.each(variables, function () {
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
        $.post(ctx + '/user/modify/role/groups/' + roleId, {
            keys: keys,
            values: values,
            types: types
        }, function (resp) {
            if (resp == 'success') {
                alert('任务完成');
                location.href = ctx + '/user/list/role';
            } else {
                alert('操作失败!');
            }
        });
    }

    var saveAction = '/user/add/role/';
    var tbody = $('#roleListTable').find('tbody');

    tbody.on('click', 'td .editRole', function(event) {
        var roleId = $(this).parents('tr').attr('id');
        $.getJSON(ctx + '/user/detail/role/' + roleId, function(data) {
            $("#groups").find("input").prop('checked', false);
            $.each(data, function(k, v) {
                if (k == 'name')
                    $('#name').val(v);
                else if (k == 'groups') {
                    $.each(v, function(kk, vv) {
                        $("#group_" + vv).prop('checked', true);
                    });
                }
            });
            if ($.isFunction(callback)) {
                callback(data);
            }
        });
        $('#roleModalLabel').text('修改角色');
        saveAction = '/user/modify/role/' + roleId + '/';

        $('#roleModal').modal('toggle');
    });

    tbody.on('click', 'td .deleteRole', function(event) {
        var roleId = $(this).parents('tr').attr('id');
        var roleName = $(this).parents('tr').attr('data-name');
        var dialog = new BootstrapDialog({
            type: BootstrapDialog.TYPE_WARNING,
            title: '删除角色',
            message: '<div><h3>真要删除角色[' + roleName + ']吗？</h3></div>',
            buttons: [{
                icon: 'icon-remove',
                label: '删除',
                cssClass: 'btn-danger',
                action: function(){
                    $.post(ctx + '/user/delete/role/' + roleId,
                            function(resp) {
                                if (resp == 'success') {
                                    alert('任务完成');
                                    location.href = ctx + '/user/list/role';
                                } else if (resp == 'notempty') {
                                    alert('无法删除含有用户的角色!');
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

    $(document).ready(function () {
        fillGroupsCheckBoxes();

        $('#addRole').click(function () {
            saveAction = '/user/add/role/';
            $("#groups").find("input").prop('checked', false);
            $("#name").attr("value", "");
            $('#roleModalLabel').text('创建新角色');

            $('#roleModal').modal('toggle');
        });

        $('#saveRole').click(function () {
            var roleName = $('#name').val();
            if (roleName.length == 0) {
                alert('角色名为空！');
                return;
            }

            $.post(ctx + saveAction + roleName,
                function(resp) {
                    if (resp == 'error') {
                        alert('操作失败!');
                    }
                    else {
//                        alert('任务完成');
//                        location.href = ctx + '/user/list/role';
                        var roleId = resp;
                        var variables = [];
                        $('#groups').find('input').each(function(){
                            var id = $(this).attr('id').substr(6);
                            if ($(this).prop('checked'))
                                variables.push({key: id, value: true, type: 'B'});
                            else
                                variables.push({key: id, value: false, type: 'B'});
                        });
                        modifyGroups(roleId, variables);
                    }
                });
        });
    });
</script>
</body>
</html>

