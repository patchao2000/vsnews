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
    <link href="${ctx }/js/jquery.fileTree/jqueryFileTree.css" rel="stylesheet">
    <style type="text/css">
        .filetree1 {
            width: 560px;
            height: 200px;
            background: #FFF;
            padding: 5px;
            overflow: auto;
        }
    </style>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<%--@elvariable id="videoCount" type="java.lang.Integer"--%>
<%--@elvariable id="audioCount" type="java.lang.Integer"--%>
<%--@elvariable id="isAdmin" type="java.lang.Boolean"--%>
<%--@elvariable id="sambaServer" type="java.lang.String"--%>
<%--@elvariable id="sambaDirectory" type="java.lang.String"--%>
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
                                        <c:if test="${videoCount < 1}">
                                        <a id="add-video" class="btn btn-success" href="#"><i class="icon-add icon-white"></i> 添加视频素材</a>
                                        </c:if>
                                        <c:if test="${audioCount < 1}">
                                        <a id="add-audio" class="btn btn-success" href="#"><i class="icon-add icon-white"></i> 添加音频素材</a>
                                        </c:if>
                                    </div>
                                </div>
                                <div class='responsive-table'>
                                    <div class='scrollable-area'>
                                        <table class="data-table table table-bordered table-striped" style='margin-bottom:0;'>
                                            <thead>
                                            <tr>
                                                <th>添加人</th>
                                                <th>添加时间</th>
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
                                                <tr id="${detail.newsFileInfo.id }"
                                                    data-file-sign="${detail.newsFileInfo.type }"
                                                    data-file-status="${detail.newsFileInfo.status }"
                                                    data-file-title="${detail.newsFileInfo.title}"
                                                    data-file-path="${detail.newsFileInfo.filePath}"
                                                    data-file-length="${detail.newsFileInfo.lengthTC}">
                                                    <td>${detail.userName }</td>
                                                    <td><fmt:formatDate value="${detail.newsFileInfo.addedTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                    <td>${detail.newsFileInfo.title }</td>
                                                    <td>${detail.fileTypeName }</td>
                                                    <td>${detail.newsFileInfo.statusString }</td>
                                                    <td>${detail.newsFileInfo.lengthTC }</td>
                                                    <%--<td>${detail.newsFileInfo.filePath }</td>--%>
                                                    <td>
                                                        <a class="view-file btn btn-primary btn-xs" href="#"><i class="icon-eye-open"></i> 查看</a>
                                                        <c:if test="${detail.newsFileInfo.statusString == '剪辑开始' || isAdmin == true}">
                                                        <a class="edit-file btn btn-primary btn-xs" href="#"><i class="icon-edit"></i> 编辑</a>
                                                        <a class="remove-file btn btn-primary btn-xs" href="#"><i class="icon-remove"></i> 删除</a>
                                                        </c:if>
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

<%--@elvariable id="materialFiles" type="java.util.List"--%>
<%--<div class="modal fade group-dialog" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="fileModalLabel" aria-hidden="true">--%>
    <%--<div class="modal-dialog">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                <%--<h4 class="modal-title" id="fileModalLabel">添加素材位置</h4>--%>
            <%--</div>--%>
            <%--<div class="modal-body">--%>
                <%--<label for='file_title'>素材名称：</label>--%>
                <%--<input class='form-control' name="title" id="file_title">--%>
                <%--<label for='file_path'>素材文件：</label>--%>
                <%--&lt;%&ndash;<input class='form-control' name="file_path" id="file_path">&ndash;%&gt;--%>
                <%--<select class='form-control' id="file_path">--%>
                    <%--&lt;%&ndash;<c:forEach items="${materialFiles }" var="file">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<option value="${file }">${file }</option>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</c:forEach>&ndash;%&gt;--%>
                <%--</select>--%>
                <%--<label for='file_length'>素材长度：</label>--%>
                <%--<input class='form-control' name="length" id="file_length">--%>
                <%--<hr class='hr-normal'>--%>
                <%--<label>状态： </label>--%>
                <%--<label class="radio-inline">--%>
                    <%--<input type="radio" name="inlineRadioOptions" id="edit_begin" value="edit_begin"> 剪辑开始--%>
                <%--</label>--%>
                <%--<label class="radio-inline">--%>
                    <%--<input type="radio" name="inlineRadioOptions" id="edit_end" value="edit_end"> 剪辑结束--%>
                <%--</label>--%>
            <%--</div>--%>
            <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                <%--<button type="button" class="btn btn-primary" id="savefile"><i class='icon-save'></i> 保存</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<div class="modal fade group-dialog" data-width="630" id="browseFileModal" tabindex="-1" role="dialog" aria-labelledby="browseFileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="browseFileModalLabel">添加素材位置</h4>
            </div>
            <div class="modal-body">
                <label for='browse_file_title'>素材名称：</label>
                <input class='form-control' name="title" id="browse_file_title">
                <label for='browse_file_path'>素材文件：</label>
                <input class='form-control' name="path" id="browse_file_path" readonly="readonly">
                <label for='browse_file_length'>素材长度：</label>
                <input class='form-control' name="length" id="browse_file_length">
                <label>状态： </label>
                <label class="radio-inline">
                <input type="radio" name="inlineRadioOptions" id="browse_edit_begin" value="edit_begin"> 剪辑开始
                </label>
                <label class="radio-inline">
                <input type="radio" name="inlineRadioOptions" id="browse_edit_end" value="edit_end"> 剪辑结束
                </label>
                <hr class='hr-normal'>
                <div id="fileTree1" class="filetree1"></div>
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
<script src="${ctx }/js/jquery.fileTree/jqueryFileTree.js"></script>

<script type="text/javascript">
    var file_sign = '', add_mode = true;
    var fileId = '';

    $("#add-video").live("click",function(){
        file_sign = '0';
        add_mode = true;
        $('#browse_edit_begin').prop('checked', true);
        $("#browse_file_path").empty();
        $('#browseFileModal').modal('toggle');
    });

    $("#add-audio").live("click",function(){
        file_sign = '1';
        add_mode = true;
        $('#browse_edit_begin').prop('checked', true);
        $("#browse_file_path").empty();
        $('#browseFileModal').modal('toggle');
    });

    $(".view-file").live("click",function(){
//        alert($(this).parents('tr').attr('data-file-path'));
        var file = $(this).parents('tr').attr('data-file-path');
        if (file.length > 0) {
            var path = file;
            if (file.substr(0, 2) != '\\\\') {
                var dir = '${sambaDirectory}';
                var b = /\//g;
                var realdir= dir.replace(b, "\\");

                path = '\\\\' + '${sambaServer}' + realdir + file;
            }
            alert('将打开: ' + path);
            var wsh = new ActiveXObject("wscript.shell");
            wsh.run('"' + path + '"');
//                wsh.run('C:\\Temp\\1.txt');
        }
    });

    $(".remove-file").live("click",function(){
        fileId = $(this).parents('tr').attr('id');

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

    $(".edit-file").live("click",function(){
        fileId = $(this).parents('tr').attr('id');
        file_sign = $(this).parents('tr').attr('data-file-sign');
        add_mode = false;
        $("#browse_file_path").val($(this).parents('tr').attr('data-file-path'));
        $('#browse_edit_begin').prop('checked', $(this).parents('tr').attr('data-file-status') == "0");
        $('#browse_edit_end').prop('checked', $(this).parents('tr').attr('data-file-status') == "1");
        $('#browse_file_title').val($(this).parents('tr').attr('data-file-title'));
        $('#browse_file_length').val($(this).parents('tr').attr('data-file-length'));

        $('#browseFileModal').modal('toggle');
    });

    $('#savefile').click(function () {
        var file_title = $('#browse_file_title').val();
        if (file_title.length == 0) {
            alert('必须输入标题！');
            return;
        }
        var file_path = $('#browse_file_path').val();
        if (file_path.length == 0) {
//            file_path = "null";
            alert('必须选择素材文件！');
            return;
        }
        var file_length = $('#browse_file_length').val();
        if (file_length.length == 0) {
            file_length = "00:00:00:00";
        }

        var checked = $("input[type='radio']:checked").val();
        var file_status = "0";
        if (checked == 'edit_end') {
            file_status = "1";
        }

        var map = {};
        map["type"] = file_sign;
        map["title"] = file_title;
        map["status"] = file_status;
        map["filepath"] = file_path;
        map["length"] = file_length;

        if (add_mode == true) {
            if (file_status == "1") {
                $.ajax({
                    type: 'post',
                    async: false,
                    url: ctx + '/news/topic/start-fileinfo-args/${topic.id}',
                    contentType: "application/json; charset=utf-8",
                    data : JSON.stringify(map),
                    success: function (resp) {
                        if (resp == 'success') {
                            alert('任务完成');
                            location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                        } else {
                            alert('操作失败!');
                        }
                    },
                    error: function () {
                        alert('操作失败!');
                    }
                });
            }
            else {
                $.ajax({
                    type: 'post',
                    async: false,
                    url: ctx + '/news/topic/add-file/${topic.id}',
                    contentType: "application/json; charset=utf-8",
                    data : JSON.stringify(map),
                    success: function (resp) {
                        if (resp == 'success') {
                            alert('任务完成');
                            location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                        } else {
                            alert('操作失败!');
                        }
                    },
                    error: function () {
                        alert('操作失败!');
                    }
                });
            }
        }
        else {
            $.ajax({
                type: 'post',
                async: false,
                url: ctx + '/news/topic/edit-file/${topic.id}/' + fileId,
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        if (file_status == "1") {
                            $.post(ctx + '/news/topic/start-fileinfo-id/' + fileId,
                                    function (resp) {
                                        if (resp == 'success') {
                                            alert('任务完成');
                                            location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                                        } else {
                                            alert('操作失败!');
                                        }
                                    });
                        }
                        else {
                            alert('任务完成');
                            location.href = ctx + '/news/topic/view/files/' + ${topic.id};
                        }
                    } else {
                        alert('操作失败!');
                    }
                },
                error: function () {
                    alert('操作失败!');
                }
            });
        }
    });

    $(document).ready(function () {
        $("#browse_file_length").mask("99:99:99:99");

        function fileTreeHit(file) {
            var b = /\//g;
            var realfile = file.replace(b, "\\");
            $("#browse_file_path").val(realfile);
        }

        $('#fileTree1').fileTree({
            server: "${sambaServer}",
            root: "${sambaDirectory}",
            preset: '1',
            script: '/util/smb-conn/get',
            folderEvent: 'click',
            expandSpeed: 750,
            collapseSpeed: 750,
            multiFolder: false,
            dirmode: 'false'
        }, function (file) {
            fileTreeHit(file);
        }, function (dire) {
        });
    });
</script>
</body>
</html>

