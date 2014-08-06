<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-24
  Time: 下午6:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>栏目列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    <style>
        .column-dialog .modal-dialog {
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
                        <a id="addcolumn" class="btn btn-success" title='创建新栏目' href="#"><i class="icon-plus icon-white"></i> 创建</a>
                    </div>
                    <%--<div class='navbar-right'>--%>
                        <%--<div class='form-group'>--%>
                            <%--<input class='form-control' placeholder='栏目名' type='text' name='LoginName' >--%>
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
                            <div class='title'>栏目列表</div>
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
                                            <th>栏目名</th>
                                            <th>审核级别</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="column" type="com.videostar.vsnews.entity.news.NewsColumn"--%>
                                        <c:forEach items="${list }" var="column">
                                            <tr id="${column.id }">
                                                <td>${column.name }</td>
                                                <td>
                                                    <c:if test="${column.auditLevel % 2 == 1}"> 级别一</c:if>
                                                    <c:if test="${(column.auditLevel % 4) / 2 >= 1}"> 级别二</c:if>
                                                    <c:if test="${column.auditLevel / 4 >= 1}"> 级别三</c:if>
                                                </td>
                                                <td>
                                                    <div>
                                                        <a class='btn btn-success btn-xs editcolumn' href='#'>
                                                            <i class='icon-edit'></i> 编辑
                                                        </a>
                                                        <a class='btn btn-danger btn-xs deletecolumn' href='#'>
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

<div class="modal fade column-dialog" id="columnModal" tabindex="-1" role="dialog" aria-labelledby="columnModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="columnModalLabel">创建新栏目</h4>
            </div>
            <div class="modal-body">
                <div class='form-group'>
                    <label class='control-label' for='name'>栏目名称：</label>
                    <input class='form-control' id='name' name='name'>
                </div>
                <div class='form-group'>
                    <label class='control-label'>栏目审核级别：</label>
                    <div>
                        <div class='checkbox-inline'>
                            <label><input type='checkbox' id='level1' value=''>一级审核</label>
                        </div>
                        <div class='checkbox-inline'>
                            <label><input type='checkbox' id='level2' value=''>二级审核</label>
                        </div>
                        <div class='checkbox-inline'>
                            <label><input type='checkbox' id='level3' value=''>三级审核</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="savecolumn"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var saveaction = '/news/column/add/';
        $('#addcolumn').click(function () {
            $('#columnModalLabel').text('创建新栏目');
            $('#name').attr("value", "");
            $("#level1").prop("checked", false);
            $("#level2").prop("checked", false);
            $("#level3").prop("checked", false);
            saveaction = '/news/column/add/';
            $('#columnModal').modal('toggle');
        });

        $('.editcolumn').click(function () {
            var columnId = $(this).parents('tr').attr('id');
            $.getJSON(ctx + '/news/column/detail/' + columnId, function(data) {
                $.each(data, function(k, v) {
                    if (k == 'name')
                        $('#name').val(v);
                    else if (k == 'auditLevel') {
                        var level = parseInt(v);
                        $("#level1").prop("checked", (level & 1));
                        $("#level2").prop("checked", (level & 2));
                        $("#level3").prop("checked", (level & 4));
                    }
                });
                if ($.isFunction(callback)) {
                    callback(data);
                }
            });
            $('#columnModalLabel').text('修改栏目');
            saveaction = '/news/column/modify/' + columnId + '/';

            $('#columnModal').modal('toggle');
        });

        $('#savecolumn').click(function () {
            var name = $('#name').val();
            if (name.length == 0) {
                alert('栏目名为空！');
                return;
            }
            var level1 = $("#level1").prop('checked');
            var level2 = $("#level2").prop('checked');
            var level3 = $("#level3").prop('checked');
            if (((!level1) && level2) || ((!level2) && level3)) {
                alert('级别选择错误！');
                return;
            }
            var level = (level1 ? 1 : 0) + (level2 ? 2 : 0) +(level3 ? 4 : 0);

            $.post(ctx + saveaction + name + '/' + level,
            function(resp) {
                if (resp == 'success') {
                    alert('任务完成');
                    location.href = ctx + '/news/column/list';
                } else {
                    alert('操作失败!');
                }
            });
        });

        $('.deletecolumn').click(function () {
            var columnId = $(this).parents('tr').attr('id');
            var dialog = new BootstrapDialog({
                type: BootstrapDialog.TYPE_WARNING,
                title: '删除栏目',
                message: '<div><h3>真要删除栏目' + columnId + '吗？</h3></div>',
                buttons: [{
                    icon: 'icon-remove',
                    label: '删除',
                    cssClass: 'btn-danger',
                    action: function(){
                        $.post(ctx + '/news/column/delete/' + columnId,
                                function(resp) {
                                    if (resp == 'success') {
                                        alert('任务完成');
                                        location.href = ctx + '/news/column/list';
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
