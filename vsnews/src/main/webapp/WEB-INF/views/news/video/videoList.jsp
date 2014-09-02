<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-1
  Time: 下午5:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>文件列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-dialog.min.css" rel="stylesheet">
    <%--<style>--%>
        <%--.column-dialog .modal-dialog {--%>
            <%--width: 400px;--%>
        <%--}--%>
    <%--</style>--%>
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
                            <div class='title'>文件列表</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='data-table table table-bordered table-striped' style='margin-bottom:0;' id="videoListTable">
                                        <thead>
                                        <tr>
                                            <th>栏目名</th>
                                            <th>标题</th>
                                            <th>类型</th>
                                            <th>大小</th>
                                            <th>上载者</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.VideoDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <tr id="${detail.video.id }" data-title="${detail.video.title }">
                                                <td>${detail.columnName }</td>
                                                <td>${detail.video.title }</td>
                                                <td>${detail.video.fileType }</td>
                                                <td>${detail.video.fileSize }</td>
                                                <td>${detail.uploadUserName }</td>
                                                <td>
                                                    <div>
                                                        <a class='btn btn-danger btn-xs deletevideo' href='#'>
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

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">

    var tbody = $('#videoListTable').find('tbody');

    tbody.on('click', 'td .deletevideo', function() {
        var title = $(this).parents('tr').attr('data-title');
        var video_id = $(this).parents('tr').attr('id');
        var dlg = new BootstrapDialog({
            type: BootstrapDialog.TYPE_WARNING,
            title: '删除文件',
            message: '<div><h3>真要删除文件' + title + '吗？</h3></div>',
            buttons: [{
                icon: 'icon-remove',
                label: '删除',
                cssClass: 'btn-danger',
                action: function(){
                    $.post(ctx + '/news/video/delete/' + video_id,
                            function(resp) {
                                if (resp == 'success') {
                                    alert('任务完成');
                                    location.href = ctx + '/news/video/list/all';
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
        dlg.realize();
        dlg.open();
    });

    $(document).ready(function () {

    });
</script>
</body>
</html>
