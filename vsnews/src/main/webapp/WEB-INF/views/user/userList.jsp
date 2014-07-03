<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-2
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>用户列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx}/css/_pagination.css" media="all" rel="stylesheet" type="text/css"/>
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
                        <a id="adduser" class="btn btn-success" title='创建新用户' href="#" data-toggle="modal" data-target="#myModal"><i class="icon-plus icon-white"></i> 创建</a>
                    </div>
                    <div class='navbar-right'>
                        <div class='form-group'>
                            <input class='form-control' placeholder='用户名' type='text' name='LoginName' >
                        </div>
                        <button class='btn btn-default' type='submit'>搜索 <i class="icon-search"></i></button>
                    </div>
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
                                    <table class='table' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <%--<th>ID</th>--%>
                                            <th>用户名</th>
                                            <th>全名</th>
                                            <th>电子邮件</th>
                                            <th>附注</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
                                        <%--@elvariable id="user" type="org.activiti.engine.identity.User"--%>
                                        <c:forEach items="${page.result }" var="user">
                                            <tr>
                                                <td>${user.id }</td>
                                                <td>${user.firstName }</td>
                                                <td>${user.email }</td>
                                                <td>${user.lastName }</td>
                                                <td></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <tags:pagination page="${page}" paginationSize="${page.pageSize}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="modal fade user-dialog" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form id="InfroText" method="POST">
                    <input type="hidden" name="InfroText" value="1">
                    <table>
                        <tbody>
                        <tr>
                            <td>用户名：</td>
                            <td><input class='form-control' name="title" id="title" style="width:280px"></td>
                        </tr>
                        <tr>
                            <td>用户用户名：</td>
                            <td><input class='form-control' name="name" id="name" style="width:280px"></td>
                        </tr>

                        <%--<tr><td>Introudction</td><td><textarea name="contect" style="width:300px;height:100px"></textarea></td></tr>--%>
                        </tbody>
                    </table>
                </form>
                <%--<table class='view-info table table-striped'>--%>
                    <%--<tr>--%>
                        <%--<td>申请人：</td>--%>
                        <%--<td><input class='form-control' id='title' name='title' placeholder='用户名' type='text'></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>申请时间：</td>--%>
                        <%--<td data-name="applyTime"></td>--%>
                    <%--</tr>--%>
                <%--</table>--%>
            <%--<form id="userform" action="#" class="form" method="post" accept-charset="UTF-8">--%>
                    <%--<div class='form-inline'>--%>
                        <%--<div class='form-group'>--%>
                            <%--<label class='control-label' for='username'>用户名：</label>--%>
                            <%--<input class='form-control' id='username' name='username' placeholder='用户名' type='text'>--%>
                        <%--</div>--%>
                        <%--<p />--%>
                        <%--<div class='form-group'>--%>
                            <%--<label class='control-label' for='fullname'>用户全称：</label>--%>
                            <%--<input class='form-control' id='fullname' name='fullname' placeholder='用户全称' type='text'>--%>
                        <%--</div>--%>
                        <%--<div class='form-group'>--%>
                            <%--<label class='control-label' for='email'>用户名：</label>--%>
                            <%--<input class='form-control' id='email' name='email' placeholder='用户名' type='text'>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</form>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
//    $(document).ready(function () {
//        $('#adduser').click(function () {

//            var dialog = new BootstrapDialog({
//                title: '流程办理[' + tname + ']',
//                message: content,
//                data: { 'taskId': taskId },
//                buttons: handleOpts[tkey].buttons
//            });
//            dialog.realize();
//            dialog.open();

//            BootstrapDialog.show({
//                title: 'Default Title',
//                message: 'Click buttons below.',
//                buttons: [{
//                    label: 'Title 1',
//                    action: function(dialog) {
//                        dialog.setTitle('Title 1');
//                    }
//                }, {
//                    label: 'Title 2',
//                    action: function(dialog) {
//                        dialog.setTitle('Title 2');
//                    }
//                }]
//            });


//            var dialog = new BootstrapDialog({
//                title: '创建用户',
//                cssClass: 'user-dialog',
//                message: $('<div></div>').load('/user/add/user'),
//                buttons: [{
////                    icon: 'glyphicon glyphicon-ban-circle',
//                    icon: 'icon-user',
//                    label: '创建',
//                    cssClass: 'btn-success'
//                }, {
//                    label: '关闭',
//                    action: function(dialogItself){
//                        dialogItself.close();
//                    }
//                }],
//                closable: true
//            });
//            dialog.realize();
//            dialog.getModalHeader().hide();
//            dialog.getModalFooter().hide();
//            dialog.getModalBody().css('background-color', '#0088cc');
//            dialog.getModalBody().css('color', '#fff');
//            dialog.open();
//        });
//    });
</script>
</body>
</html>
