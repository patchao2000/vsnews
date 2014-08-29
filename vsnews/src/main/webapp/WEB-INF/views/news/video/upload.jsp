<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-8-26
  Time: 下午5:49
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="columnsList" type="java.util.List"--%>
<%--@elvariable id="user" type="org.activiti.engine.identity.User"--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>上传文件</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx}/js/common/fileupload/css/jquery.fileupload.css" media="all"
          rel="stylesheet" type="text/css"/>
    <style>
        .progress {
            height: 35px;
        }
        .progress-bar {
            font-size: 20px;
            line-height: 30px;
        }
    </style>
</head>
<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <%@ include file="/common/message-error.jsp" %>

            <div class='row'>
                <div class='col-sm-12'>
                    <div class='box' style='margin-bottom:0'>
                        <div class='box-header blue-background'>
                            <div class='title'>上传文件</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <div class="form form-horizontal" style="margin-bottom: 0;">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='video_columnId'>栏目：</label>
                                    <div class='col-md-4'>
                                        <select class='select2 form-control' id="video_columnId">
                                            <%--@elvariable id="column" type="com.videostar.vsnews.entity.news.NewsColumn"--%>
                                            <c:forEach items="${columnsList }" var="column">
                                            <option value="${column.id}">${column.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='video_title'>标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='video_title' type='text' />
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='video_file'>文件：</label>
                                    <div class='col-md-8'>
                                        <input class='form-control' id='video_file' type='text' readonly="readonly"/>
                                    </div>
                                    <span class="btn btn-success fileinput-button">
                                        <i class="glyphicon glyphicon-plus"></i>
                                        <span>选择文件</span>
                                        <input id="fileupload" type="file" name="files[]">
                                    </span>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label'>进度：</label>
                                    <div class="col-md-10">
                                        <!-- The global progress bar -->
                                        <div id="progress" class="progress">
                                            <div class="progress-bar progress-bar-success">0%</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- The container for the uploaded files -->
                                <div id="files" class="files"></div>

                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button type="submit" class="btn btn-primary start" id="start-upload">
                                                <i class="glyphicon glyphicon-upload"></i>
                                                <span>开始上传</span>
                                            </button>
                                        </div>
                                    </div>
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
<script src="${ctx}/js/common/fileupload/js/jquery.iframe-transport.js"></script>
<script src="${ctx}/js/common/fileupload/js/vendor/jquery.ui.widget.js"></script>
<script src="${ctx}/js/common/fileupload/js/jquery.fileupload.js"></script>

<script type="text/javascript">

    function setProgress(progress) {
        var bar = $('#progress').find('.progress-bar');
        bar.css('width', progress + '%');
        bar.text(progress + '%');
    }

    $(function () {
        'use strict';

        $('#fileupload').fileupload({
            autoUpload: false,
            maxNumberOfFiles: 1,
            url: "${ctx}/news/video/upload-start",
            dataType: 'json',
            add: function (e, data) {
                $.each(data.files, function (index, file) {
//                    $.getJSON(ctx + '/news/video/get-by-filename/'+file.name, function(data) {
//                        alert(file.name + ":" + data);
//                        if (data != null) {
//                            mustReturn = true;
//                        }
//                    });

                    $("#video_file").val(file.name);
                });

                $("#start-upload").unbind('click').removeAttr('onclick').click(function () {
                    var title = $("#video_title").val();
                    if (title.length == 0) {
                        alert("必须输入标题！");
                        return;
                    }
                    data.url = "${ctx}/news/video/upload-start/" + title + "/" +
                            $('#video_columnId' + ' :selected').val() + "/${user.id}";

                    var mustReturn = true;

                    $.ajax({
                        type: 'post',
                        async: false,
                        url: ctx + '/news/video/check-exists-by-title/' + title,
                        contentType: "application/json; charset=utf-8",
                        success: function (resp) {
                            if (resp == "error") {
                                alert("不能使用重复的标题！");
                            } else {
                                mustReturn = false;
                            }
                        },
                        error: function () {
                            alert('video get-by-title error!!');
                        }
                    });

                    if (mustReturn) {
                        return;
                    }

                    $("#start-upload").prop("disabled", true);
                    $(".fileinput-button").hide();
                    data.submit();
                })
            },
            done: function (e, data) {
                setProgress(100);
                $.each(data.result, function (index, file) {
                    alert(file.fileName + " 上传成功!");
//                    $('<p/>').text(file.fileName).appendTo('#files');
                });
                location.href = ctx + '/news/video/upload';
            },
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                setProgress(progress);
            }
//            processfail: function (e, data) {
//                alert(data.files[data.index].name + "\n" + data.files[data.index].error);
//            }
        }).prop('disabled', !$.support.fileInput)
                .parent().addClass($.support.fileInput ? undefined : 'disabled');

    });
</script>
</body>
</html>
