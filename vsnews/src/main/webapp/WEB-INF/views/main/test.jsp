<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%--%>
<%--String path = request.getContextPath();--%>
<%--String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";--%>
<%--%>--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%--<base href="<%=basePath%>">--%>
    <title>上传文件进度条示例</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx}/js/common/fileupload/css/jquery.fileupload.css" media="all"
        rel="stylesheet" type="text/css"/>
    <%--<link href="${ctx}/assets/stylesheets/plugins/jquery_fileupload/jquery.fileupload-ui.css" media="all"--%>
          <%--rel="stylesheet" type="text/css"/>--%>
    <%--<style>--%>
    <%--#dropzone {--%>
    <%--background: #ccccc;--%>
    <%--width: 150px;--%>
    <%--height: 50px;--%>
    <%--line-height: 50px;--%>
    <%--text-align: center;--%>
    <%--font-weight: bold;--%>
    <%--}--%>
    <%--#dropzone.in {--%>
    <%--width: 600px;--%>
    <%--height: 200px;--%>
    <%--line-height: 200px;--%>
    <%--font-size: larger;--%>
    <%--}--%>
    <%--#dropzone.hover {--%>
    <%--background: lawngreen;--%>
    <%--}--%>
    <%--#dropzone.fade {--%>
    <%---webkit-transition: all 0.3s ease-out;--%>
    <%---moz-transition: all 0.3s ease-out;--%>
    <%---ms-transition: all 0.3s ease-out;--%>
    <%---o-transition: all 0.3s ease-out;--%>
    <%--transition: all 0.3s ease-out;--%>
    <%--opacity: 1;--%>
    <%--}--%>
    <%--</style>--%>
    <%--<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.1.js"></script>--%>
    <%--<script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>--%>
    <%--<script>--%>
    <%--function beginUpload(){--%>
    <%--$("#progress_bar").show();--%>
    <%--setInterval("getUploadMeter()",1000);--%>
    <%--}--%>

    <%--function getUploadMeter(){--%>
    <%--$.post("/servlet/UploadPercentServlet",function(data){--%>
    <%--var json = eval_r("("+data+")");--%>
    <%--jQuery("#progress").css("width",json.percentage/100*200+"px");--%>
    <%--jQuery("#msg").css("padding","1px").html(json.percentage+"%");--%>
    <%--});--%>
    <%--}--%>
    <%--</script>--%>
</head>
<body>
<%--<form action="/servlet/UploadServlet"  method="post" enctype="multipart/form-data" onsubmit="beginUpload()" target="_self">--%>
<%--<input type="file" name="formFile" >--%>
<%--<br/>--%>
<%--<div id="progress_bar" style="width:200px;height:1px;display:none;border:1px solid black;">--%>
<%--<div id="progress" style="background-color:red;height:1px;width:0px;"> </div>--%>
<%--</div>--%>

<%--<div id="msg"></div>--%>
<%--<input type="submit" value="submit">--%>
<%--</form>--%>
<div class="container">
    <!-- The fileinput-button span is used to style the file input field as button -->
    <span class="btn btn-success fileinput-button">
        <i class="glyphicon glyphicon-plus"></i>
        <span>Select files...</span>
        <!-- The file input field used as target for the file upload widget -->
        <input id="fileupload" type="file" name="files[]" multiple>
    </span>
    <br>
    <button type="submit" class="btn btn-primary start" id="start-upload">
        <i class="glyphicon glyphicon-upload"></i>
        <span>Start upload</span>
    </button>
    <br>
    <!-- The global progress bar -->
    <div id="progress" class="progress">
        <div class="progress-bar progress-bar-success"></div>
    </div>
    <!-- The container for the uploaded files -->
    <div id="files" class="files"></div>
    <br>

    <%--<form action="" method="post" enctype="multipart/form-data">--%>
    <%--<input type='text' name='textfield' id='textfield' class='txt' />--%>
    <%--<input type='button' class='btn' value='浏览...' />--%>
    <%--<input type="file" name="fileField" class="file" id="fileField" size="28" onchange="document.getElementById('textfield').value=this.value" />--%>
    <%--<input type="submit" name="submit" class="btn" value="上传" />--%>
    <%--<%--<input id="fileupload" type="file" name="files[]" data-url="${ctx}/news/video/upload" multiple style="display: none">--%>--%>
    <%--<%--<div class="input-append">--%>--%>
    <%--<%--<input id="photoCover" class="input-large" type="text" style="height:30px;">--%>--%>
    <%--<%--<a class="btn" onclick="$('input[id=fileupload]').click();">Browse</a>--%>--%>
    <%--<%--</div>--%>--%>
    <%--</form>--%>

    <%--<div id="dropzone">Drop files here</div>--%>

    <%--<div id="progress">--%>
    <%--<div style="width: 0%;"></div>--%>
    <%--</div>--%>
    <%--<div class='col-sm-6'>--%>
    <%--<div class='progress'>--%>
    <%--<div class='progress-bar progress-bar-primary' id='upload-bar' style='width:0;'></div>--%>
    <%--</div>--%>
    <%--</div>--%>

    <%--<table id="uploaded-files">--%>
    <%--<tr>--%>
    <%--<th>File Name</th>--%>
    <%--<th>File Size</th>--%>
    <%--<th>File Type</th>--%>
    <%--<th>Download</th>--%>
    <%--</tr>--%>
    <%--</table>--%>

</div>
<%@ include file="/common/alljs.jsp" %>
<%--<script src="${ctx}/js/common/jquery-1.11.1.js"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/fileupload/jquery.iframe-transport.min.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/fileupload/jquery.fileupload.min.js" type="text/javascript"></script>--%>
<%--<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>--%>
<%--<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>--%>
<script src="${ctx}/js/common/fileupload/js/jquery.iframe-transport.js"></script>
<script src="${ctx}/js/common/fileupload/js/vendor/jquery.ui.widget.js"></script>
<script src="${ctx}/js/common/fileupload/js/jquery.fileupload.js"></script>
<%--<script src="${ctx}/js/common/fileupload/js/jquery.fileupload-process.js"></script>--%>
<%--<script src="${ctx}/js/common/fileupload/js/jquery.fileupload-image.js"></script>--%>
<%--<script src="${ctx}/js/common/fileupload/js/jquery.fileupload-audio.js"></script>--%>
<%--<script src="${ctx}/js/common/fileupload/js/jquery.fileupload-video.js"></script>--%>
<%--<script src="${ctx}/js/common/fileupload/js/jquery.fileupload-validate.js"></script>--%>
<script type="text/javascript">
//    $("#start-upload").on("click",function() {
////        alert("01290");
//        $("#fileupload").submit();
//    });

    //    $(function () {
    //        $('input[id=fileupload]').change(function() {
    //            $('#photoCover').val($(this).val());
    //        });
    //
    //        $('#fileupload').fileupload({
    //            dataType: 'json',
    //
    //            done: function (e, data) {
    //                $("tr:has(td)").remove();
    //                $.each(data.result, function (index, file) {
    //
    //                    $("#uploaded-files").append(
    //                            $('<tr/>')
    //                                    .append($('<td/>').text(file.fileName))
    //                                    .append($('<td/>').text(file.fileSize))
    //                                    .append($('<td/>').text(file.fileType))
    //                                    .append($('<td/>').html("<a href='rest/controller/get/"+index+"'>Click</a>"))
    //                    )//end $("#uploaded-files").append()
    //                });
    //            },
    //
    //            progressall: function (e, data) {
    //                var progress = parseInt(data.loaded / data.total * 100, 10);
    ////                $('#progress .bar').css(
    ////                        'width',
    ////                                progress + '%'
    ////                );
    //                $('#upload-bar').css('width', progress + '%');
    //            }
    //
    ////            dropZone: $('#dropzone')
    //        });
    //    });

    $(function () {
    'use strict';

        $('#fileupload').fileupload({
            autoUpload: false,
        url: "${ctx}/news/video/upload",
        dataType: 'json',
            add: function (e, data) {
                $("#start-upload").click(function () {
//                    $("p").html("Requête envoyée");
                    data.submit();
                })
            },
        done: function (e, data) {
        $.each(data.result, function (index, file) {
//            alert(file.name);
        $('<p/>').text(file.fileName).appendTo('#files');
        });
        },
        progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress .progress-bar').css(
        'width',
        progress + '%'
        );
        }
        }).prop('disabled', !$.support.fileInput)
            .parent().addClass($.support.fileInput ? undefined : 'disabled');

//        var uploadButton = $('<button/>')
//                .addClass('btn btn-primary')
//                .prop('disabled', true)
//                .text('Processing...')
//                .on('click', function () {
//                    var $this = $(this),
//                            data = $this.data();
//                    $this
//                            .off('click')
//                            .text('Abort')
//                            .on('click', function () {
//                                $this.remove();
//                                data.abort();
//                            });
//                    data.submit().always(function () {
//                        $this.remove();
//                    });
//                });

        <%--$('#fileupload').fileupload({--%>
            <%--url: "${ctx}/news/video/upload",--%>
            <%--dataType: 'json',--%>
            <%--autoUpload: false,--%>
    <%--acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,--%>
    <%--maxFileSize: 5000000, // 5 MB--%>
<%--//            Enable image resizing, except for Android and Opera,--%>
<%--//            which actually support image resizing, but fail to--%>
<%--//            send Blob objects via XHR requests:--%>
    <%--disableImageResize: /Android(?!.*Chrome)|Opera/--%>
            <%--.test(window.navigator.userAgent),--%>
    <%--previewMaxWidth: 100,--%>
    <%--previewMaxHeight: 100,--%>
    <%--previewCrop: true--%>
        <%--}).on('fileuploadadd', function (e, data) {--%>
            <%--data.context = $('<div/>').appendTo('#files');--%>
            <%--$.each(data.files, function (index, file) {--%>
                <%--var node = $('<p/>')--%>
                        <%--.append($('<span/>').text(file.name));--%>
                <%--if (!index) {--%>
                    <%--node--%>
                            <%--.append('<br>')--%>
                            <%--.append(uploadButton.clone(true).data(data));--%>
                <%--}--%>
                <%--node.appendTo(data.context);--%>
            <%--});--%>
        <%--}).on('fileuploadprocessalways', function (e, data) {--%>
            <%--var index = data.index,--%>
                    <%--file = data.files[index],--%>
                    <%--node = $(data.context.children()[index]);--%>
            <%--if (file.preview) {--%>
                <%--node--%>
                        <%--.prepend('<br>')--%>
                        <%--.prepend(file.preview);--%>
            <%--}--%>
            <%--if (file.error) {--%>
                <%--node--%>
                        <%--.append('<br>')--%>
                        <%--.append($('<span class="text-danger"/>').text(file.error));--%>
            <%--}--%>
            <%--if (index + 1 === data.files.length) {--%>
                <%--data.context.find('button')--%>
                        <%--.text('Upload')--%>
                        <%--.prop('disabled', !!data.files.error);--%>
            <%--}--%>
        <%--}).on('fileuploadprogressall', function (e, data) {--%>
            <%--var progress = parseInt(data.loaded / data.total * 100, 10);--%>
            <%--$('#progress .progress-bar').css(--%>
                    <%--'width',--%>
                            <%--progress + '%'--%>
            <%--);--%>
        <%--}).on('fileuploaddone', function (e, data) {--%>
            <%--$.each(data.result.files, function (index, file) {--%>
                <%--if (file.url) {--%>
                    <%--var link = $('<a>')--%>
                            <%--.attr('target', '_blank')--%>
                            <%--.prop('href', file.url);--%>
                    <%--$(data.context.children()[index])--%>
                            <%--.wrap(link);--%>
                <%--} else if (file.error) {--%>
                    <%--var error = $('<span class="text-danger"/>').text(file.error);--%>
                    <%--$(data.context.children()[index])--%>
                            <%--.append('<br>')--%>
                            <%--.append(error);--%>
                <%--}--%>
            <%--});--%>
        <%--}).on('fileuploadfail', function (e, data) {--%>
            <%--$.each(data.files, function (index, file) {--%>
                <%--var error = $('<span class="text-danger"/>').text('File upload failed.');--%>
                <%--$(data.context.children()[index])--%>
                        <%--.append('<br>')--%>
                        <%--.append(error);--%>
            <%--});--%>
        <%--}).prop('disabled', !$.support.fileInput)--%>
                <%--.parent().addClass($.support.fileInput ? undefined : 'disabled');--%>
    });
</script>
</body>
</html>
