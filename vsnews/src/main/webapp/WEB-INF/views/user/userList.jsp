<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-2
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>用户列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    <style>
        .user-dialog .modal-dialog {
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
                        <a id="adduser" class="btn btn-success" title='创建新用户' href="#"><i class="icon-plus icon-white"></i> 创建</a>
                    </div>
                    <%--<div class='navbar-right'>--%>
                        <%--<div class='form-group'>--%>
                            <%--<input class='form-control' placeholder='用户名' type='text' name='LoginName' >--%>
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
                            <div class='title'>用户列表</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='data-table table table-bordered table-striped' style='margin-bottom:0;' id="userListTable">
                                        <thead>
                                        <tr>
                                            <th>用户名</th>
                                            <th>全名</th>
                                            <th>角色</th>
                                            <th>栏目</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.identify.UserDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <tr id="${detail.userId }">
                                                <td>${detail.userId }</td>
                                                <td>${detail.firstName }</td>
                                                <td>${detail.roles }</td>
                                                <td>${detail.columns }</td>
                                                <td>
                                                    <div>
                                                        <a class='btn btn-success btn-xs edituser' href='#'>
                                                            <i class='icon-edit'></i> 编辑
                                                        </a>
                                                        <a class='btn btn-danger btn-xs deleteuser' href='#'>
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

<div class="modal fade user-dialog" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="userModalLabel">创建新用户</h4>
            </div>
            <div class="modal-body">
                <table>
                    <tbody>
                    <tr>
                        <td>用户名：</td>
                        <td>
                            <%--<label for='userid'></label>--%>
                            <input class='form-control' name="userid" id="userid" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>用户全名：</td>
                        <td>
                            <%--<label for='firstname'></label>--%>
                            <input class='form-control' name="firstname" id="firstname" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>密码：</td>
                        <td>
                            <%--<label for='password'></label>--%>
                            <input class='form-control' type="password" name="password" id="password" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>再次输入密码：</td>
                        <td>
                            <%--<label for='password2'></label>--%>
                            <input class='form-control' type="password" name="password2" id="password2" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>电子邮件：</td>
                        <td>
                            <%--<label for='email'></label>--%>
                            <input class='form-control' name="email" id="email" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>附注：</td>
                        <td>
                            <%--<label for='lastname'></label>--%>
                            <input class='form-control' name="lastname" id="lastname" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>所属角色：</td>
                        <td id="roles"></td>
                    </tr>
                    <tr>
                        <td>所属栏目：</td>
                        <td id="columns"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveuser"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
    function modifyRolesColumns(userId, rolesVars, columnsVars) {
        var keys = "", values = "", types = "";
        $.each(rolesVars, function() {
            if (keys != "") {
                keys += ",";
                values += ",";
                types += ",";
            }
            keys += this.key;
            values += this.value;
            types += this.type;
        });
        $.post(ctx + '/user/modify/user/roles/' + userId, {
            keys: keys,
            values: values,
            types: types
        }, function(resp) {
            if (resp == 'success') {
                keys = "", values = "", types = "";
                $.each(columnsVars, function() {
                    if (keys != "") {
                        keys += ",";
                        values += ",";
                        types += ",";
                    }
                    keys += this.key;
                    values += this.value;
                    types += this.type;
                });
                $.post(ctx + '/user/modify/user/columns/' + userId, {
                    keys: keys,
                    values: values,
                    types: types
                }, function(resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/user/list/user';
                    } else {
                        alert('modify/user/columns 操作失败!');
                    }
                });
            } else {
                alert('modify/user/roles 操作失败!');
            }
        });
    }

    var saveaction = '/user/add/user/';

    $('#userListTable tbody').on('click', 'td .deleteuser', function(event) {
        var userId = $(this).parents('tr').attr('id');
        var dialog = new BootstrapDialog({
            type: BootstrapDialog.TYPE_WARNING,
            title: '删除用户',
            message: '<div><h3>真要删除用户' + userId + '吗？</h3></div>',
            buttons: [{
                icon: 'icon-remove',
                label: '删除',
                cssClass: 'btn-danger',
                action: function(){
                    $.post(ctx + '/user/delete/user/' + userId,
                            function(resp) {
                                if (resp == 'success') {
                                    alert('任务完成');
                                    location.href = ctx + '/user/list/user';
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

    $('#userListTable tbody').on('click', 'td .edituser', function(event) {
//        alert($(this).parents('tr').attr('id'));
        var userId = $(this).parents('tr').attr('id');
        $.getJSON(ctx + '/user/detail/user/' + userId, function(data) {
            $.each(data, function(k, v) {
                $("#" + k.toLowerCase()).val(v);
                if (k == "password") {
                    $("#password2").val(v);
                }
            });
        });

        $.getJSON(ctx + '/user/idlist/user/roles/' + userId, function(data) {
            $("#roles").find("input").prop('checked', false);
            $.each(data, function(k, v) {
                $("#role_" + v).prop('checked', true);
            });

            $.getJSON(ctx + '/user/idlist/user/columns/' + userId, function(data) {
                $("#columns").find("input").prop('checked', false);
                $.each(data, function(k, v) {
                    $("#group_" + v).prop('checked', true);
                });

                $('#userModalLabel').text('修改用户');
                $('#userid').prop('readonly', true);
                saveaction = '/user/modify/user/';

                $('#userModal').modal('toggle');
            });
        });
    });

    $(document).ready(function () {
        $.getJSON(ctx + '/user/objlist/allroles', function(data) {
            var roles = '';
            var template = "<div class='checkbox'><label><input type='checkbox' value='' id='#id'>  #name</label></div>";
            $.each(data, function(dk, dv) {
                var curr = template;
                $.each(dv, function(k, v) {
                    var id = '';
                    if (k == 'id') {
                        curr = curr.replace(/#id/g, 'role_' + v);
                    }
                    else if (k == 'name') {
                        curr = curr.replace(/#name/g, v);
                    }
                });
                roles += curr;
            });
            $('#roles').html(roles);
        });

        $.getJSON(ctx + '/user/objlist/columngroups', function(data) {
            var columns = '';
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
                columns += curr;
            });
            $('#columns').html(columns);
        });

        $('#adduser').click(function () {
            $('#userModalLabel').text('创建新用户');
            $('#userid').prop('readonly', false);
            $("#roles").find("input").prop('checked', false);
            $("#columns").find("input").prop('checked', false);
            $('#userid').attr('value', '');
            $('#firstname').attr('value', '');
            $('#password').attr('value', '');
            $('#password2').attr('value', '');
            $('#email').attr('value', '');
            $('#lastname').attr('value', '');
            saveaction = '/user/add/user/';
            $('#userModal').modal('toggle');
        });

        $('#saveuser').click(function () {
            var userid = $('#userid').val();
            if (userid.length == 0) {
                alert('用户名为空！');
                return;
            }
            var password1 = $('#password').val();
            var password2 = $('#password2').val();
            if (password1.length == 0) {
                alert('密码为空！');
                return;
            }
            if (password1 != password2) {
                alert('两次密码内容不一致！');
                return;
            }
            var firstname = $('#firstname').val();
            if (firstname.length == 0) {
                firstname = "null";
            }
            var email = $('#email').val();
            if (email.length == 0) {
                email = "null";
            }
            var lastname = $('#lastname').val();
            if (lastname.length == 0) {
                lastname = "null";
            }

            $.post(ctx + saveaction + userid + '/' + firstname + '/' +
                            password1 + '/' + email + '/' + lastname,
                    function(resp) {
                        if (resp == 'success') {
//                        alert('任务完成');
//                        location.href = ctx + '/user/list/user';
                            var rolesVars = [];
                            $('#roles').find('input').each(function(){
                                var id = $(this).attr('id').substr(5);
                                if ($(this).prop('checked'))
                                    rolesVars.push({key: id, value: true, type: 'B'});
                                else
                                    rolesVars.push({key: id, value: false, type: 'B'});
                            });
                            var columnsVars = [];
                            $('#columns').find('input').each(function(){
                                var id = $(this).attr('id').substr(6);
                                if ($(this).prop('checked'))
                                    columnsVars.push({key: id, value: true, type: 'B'});
                                else
                                    columnsVars.push({key: id, value: false, type: 'B'});
                            });
                            modifyRolesColumns(userid, rolesVars, columnsVars);
                        } else {
                            alert('操作失败!');
                        }
                    });
        });
    });
</script>
</body>
</html>
