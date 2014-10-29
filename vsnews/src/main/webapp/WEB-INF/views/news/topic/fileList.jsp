<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-24
  Time: 下午4:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>新闻选题相关文件</title>
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
                            <div class='title'>新闻选题相关文件</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <div class='form-group'>
                                    <div class='col-md-6'>
                                        <a id="add-video" class="btn btn-success" href="#"><i class="icon-add icon-white"></i> 添加视频素材</a>
                                        <a id="add-audio" class="btn btn-success" href="#"><i class="icon-add icon-white"></i> 添加音频素材</a>
                                    </div>
                                </div>
                                <div class='responsive-table'>
                                    <div class='scrollable-area'>
                                        <table class="data-table table table-bordered table-striped" style='margin-bottom:0;'>
                                            <thead>
                                            <tr>
                                                <th>添加人</th>
                                                <th>申请时间</th>
                                                <th>素材名称</th>
                                                <th>素材类别</th>
                                                <th>状态</th>
                                                <th>长度</th>
                                                <%--<th>文件路径</th>--%>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%--@elvariable id="list" type="java.util.List"--%>
                                            <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.FileInfoDetail"--%>
                                            <c:forEach items="${list }" var="detail">
                                                <tr id="${detail.newsFileInfo.id }">
                                                    <td>${detail.userName }</td>
                                                    <td><fmt:formatDate value="${detail.newsFileInfo.addedTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                    <td>${detail.newsFileInfo.title }</td>
                                                    <td>${detail.fileTypeName }</td>
                                                    <td>${detail.newsFileInfo.statusString }</td>
                                                    <td>${detail.newsFileInfo.lengthTC }</td>
                                                    <%--<td>${detail.newsFileInfo.filePath }</td>--%>
                                                    <td>
                                                        <a class="remove-file btn btn-primary btn-xs" href="#"><i class="icon-remove"></i>删除</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div class="modal fade group-dialog" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="fileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="fileModalLabel">添加素材位置</h4>
            </div>
            <div class="modal-body">
                <label for='file_title'>素材名称：</label>
                <input class='form-control' name="title" id="file_title">
                <label for='file_path'>素材位置：</label>
                <input class='form-control' name="file_path" id="file_path">
                <label for='file_length'>素材长度：</label>
                <input class='form-control' name="length" id="file_length">
                <hr class='hr-normal'>
                <label>状态： </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="edit_begin" value="edit_begin"> 剪辑开始
                </label>
                <label class="radio-inline">
                    <input type="radio" name="inlineRadioOptions" id="edit_end" value="edit_end"> 剪辑结束
                </label>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="savefile"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">

    var file_sign = '';

    $("#add-video").live("click",function(){
        file_sign = '0';
        $('#edit_begin').prop('checked', true);
        $('#fileModal').modal('toggle');
    });

    $("#add-audio").live("click",function(){
        file_sign = '1';
        $('#edit_begin').prop('checked', true);
        $('#fileModal').modal('toggle');
    });

    $(".remove-file").live("click",function(){
        var fileId = $(this).parents('tr').attr('id');

        $.post(ctx + '/news/topic/remove-file/' + ${topic.id} + '/' + fileId,
                function(resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                    } else {
                        alert('操作失败!');
                    }
                });
    });

    $('#savefile').click(function () {
        var file_title = $('#file_title').val();
        if (file_title.length == 0) {
            alert('必须输入标题！');
            return;
        }
        var file_path = $('#file_path').val();
        if (file_path.length == 0) {
            file_path = "null";
        }
        var file_length = $('#file_length').val();
        if (file_length.length == 0) {
            file_length = "00:00:00:00";
        }

        var checked = $("input[type='radio']:checked").val();
        var file_status = 0;
        if (checked == 'edit_end') {
            file_status = 1;
        }

        $.post(ctx + '/news/topic/add-file/' + ${topic.id} + '/' + file_sign + '/' + file_title + '/' + file_status + '/' + file_path + '/' + file_length,
                function(resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                    } else {
                        alert('操作失败!');
                    }
                });
    });

    $(document).ready(function () {
    });
</script>
</body>
</html>

