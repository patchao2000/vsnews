<%--
  Created by IntelliJ IDEA.
  User: zhaopeng
  Date: 2014/7/29
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="article" type="com.videostar.vsnews.entity.news.NewsArticle"--%>
<%--@elvariable id="columns" type="java.util.map"--%>
<%--@elvariable id="reporters" type="java.util.List"--%>
<%--@elvariable id="cameramen" type="java.util.List"--%>
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="readonly" type="java.lang.Boolean"--%>
<%--@elvariable id="contentReadonly" type="java.lang.Boolean"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="createMode" type="java.lang.Boolean"--%>
<%--@elvariable id="auditMode" type="java.lang.Boolean"--%>
<%--@elvariable id="taskId" type="java.lang.String"--%>
<%--@elvariable id="taskKey" type="java.lang.String"--%>
<%--@elvariable id="reapplyMode" type="java.lang.Boolean"--%>
<%--@elvariable id="videos" type="java.util.List"--%>
<%--@elvariable id="secondsPerChar" type="java.lang.String"--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
    <%@ include file="/common/allcss.jsp" %>
    <style>
        .help-block { color: #ff0000; }
    </style>
    <c:if test="${createMode == true}">
        <c:set var="action" value="${ctx}/news/article/start"/>
    </c:if>
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
                            <div class='title'>${title}</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="article" id="inputForm" action="${action}" class="form form-horizontal"
                                       style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <c:if test="${reapplyMode == true}">
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='auditOpinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='auditOpinion' name='auditOpinion' type='text' readonly="readonly">
                                    </div>
                                </div>
                                </c:if>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_mainTitle' path='mainTitle' type='text' readonly="${readonly}" />
                                        <form:errors path="mainTitle" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group' style="display: none;">
                                    <label class='col-md-2 control-label' for='article_topicUuid'>UUID：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_topicUuid' path='topicUuid' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_columnId'>栏目：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="article_columnId" path="columnId">
                                            <form:options items="${columns}" itemValue="id" itemLabel="name" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='article_subTitle'>副标题：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_subTitle' path='subTitle' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_reporters'>记者：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_reporters" multiple="true" path="reporters">
                                            <form:options items="${reporters}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_cameramen'>摄像员：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_cameramen" multiple="true" path="cameramen">
                                            <form:options items="${cameramen}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_editors'>编辑：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_editors" multiple="true" path="editors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_interviewTime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <%--<fmt:formatDate value="${article.interviewTime}"--%>
                                                            <%--type="date"--%>
                                                            <%--pattern="yyyy-MM-dd HH:mm"--%>
                                                            <%--var="f_interviewTime"/>--%>
                                            <form:input class='form-control' id='article_interviewTime' path='interviewTime' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='article_location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_location' path='location' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_sourcers'>报料人：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcers' path='sourcers' type='text' readonly="${readonly}" />
                                    </div>

                                    <label class='col-md-2 control-label' for='article_sourcersTel'>报料人电话：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcersTel' path='sourcersTel' type='text' readonly="${readonly}" />
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_sourcers'>快捷方式：</label>
                                    <div class='col-md-6'>
                                        <input class="btn btn-default shortcut" id="sc_content" style="margin-bottom:5px" value="正文" type="button" />
                                        <input class="btn btn-default shortcut" id="sc_cg" style="margin-bottom:5px" value="CG" type="button" />
                                        <input class="btn btn-default shortcut" id="sc_interview" style="margin-bottom:5px" value="采访" type="button" />
                                        <input class="btn btn-default shortcut" id="sc_sync" style="margin-bottom:5px" value="同期" type="button" />
                                        <input class="btn btn-default shortcut" id="sc_shot" style="margin-bottom:5px" value="空镜" type="button" />
                                        <input class="btn btn-default shortcut" id="sc_scene" style="margin-bottom:5px" value="现场" type="button" />
                                    </div>
                                    <c:if test="${reapplyMode == true || auditMode == true}">
                                        <%--<div class='form-group'>--%>
                                            <label class='col-md-2 control-label' for='article_history'>修改历史：</label>
                                            <div class='col-md-3'>
                                                <select class='select2 form-control' id="article_history"></select>
                                            </div>
                                            <input class="btn btn-primary" id="check_article_history" value="比较" type="button" />
                                        <%--</div>--%>
                                    </c:if>

                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_content'>内容：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control ckeditor' id='article_content' path='content' readonly="${contentReadonly}" rows='7' />
                                        <form:errors path="content" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group' id="video_group" hidden="hidden">
                                    <label class='col-md-2 control-label' for='article_content'>视频：</label>
                                    <div class='col-md-10' id="video_parent">
                                        <div id="video"></div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_video'>视频选择：</label>
                                    <div class='col-md-3'>
                                        <form:select class='select2 form-control' id="article_video" path="video">
                                            <form:options items="${videos}" itemValue="fileName" itemLabel="title" />
                                        </form:select>
                                    </div>
                                    <div class='col-md-1'>
                                        <input class="btn btn-default shortcut" id="article_show_video" style="margin-bottom:5px" value="显示" type="button" />
                                    </div>
                                    <label class='col-md-1 control-label' for='content_time'>时长：</label>
                                    <div class='col-md-3'>
                                        <input class='form-control' id='content_time' readonly="readonly" type='text' rows="1" />
                                    </div>
                                    <c:if test="${createMode == null}">
                                        <input class="btn btn-default" id="download_text" style="margin-bottom:5px" value="下载文本" type="button" />
                                    </c:if>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label'>拟报单位：</label>
                                    <div class='col-md-10'>
                                        <label class='checkbox-inline' for='article_prepareSendProvTV'>
                                            <form:checkbox id='article_prepareSendProvTV' path='prepareSendProvTV' value='' />拟报省台
                                        </label>
                                        <label class='checkbox-inline' for='article_prepareSendCCTV'>
                                            <form:checkbox id='article_prepareSendCCTV' path='prepareSendCCTV' value='' />拟报央台
                                        </label>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label'>报送单位：</label>
                                    <div class='col-md-10'>
                                        <label class='checkbox-inline' for='article_sentToProvTV'>
                                            <form:checkbox id='article_sentToProvTV' path='sentToProvTV' value='' />报送省台
                                        </label>
                                        <label class='checkbox-inline' for='article_sentToCCTV'>
                                            <form:checkbox id='article_sentToCCTV' path='sentToCCTV' value='' />报送央台
                                        </label>
                                        <label class='checkbox-inline' for='article_adoptedByProvTV'>
                                            <form:checkbox id='article_adoptedByProvTV' path='adoptedByProvTV' value='' />省台采用
                                        </label>
                                        <label class='checkbox-inline' for='article_adoptedByCCTV'>
                                            <form:checkbox id='article_adoptedByCCTV' path='adoptedByCCTV' value='' />央台采用
                                        </label>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_notes' path='notes' readonly="${readonly}" type='text' rows="2" />
                                    </div>
                                </div>

                                <%--审核意见--%>
                                <c:if test="${auditMode == true}">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='opinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='opinion' name='opinion' placeholder='审核意见' type='text' rows="2">
                                    </div>
                                </div>
                                <input type="hidden" name="submit_type" value="" id="submit-type"/>
                                </c:if>

                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <c:if test="${createMode == true || reapplyMode == true}">
                                            <button class='btn btn-primary' type='submit'><i class='icon-save'></i> 提交</button>
                                            </c:if>
                                            <c:if test="${auditMode == true}">
                                            <button class='btn btn-primary' type='submit' id="auditPass"><i class='icon-ok'></i> 同意</button>
                                            <button class='btn btn-danger' type='submit' id="auditReject"><i class='icon-remove'></i> 驳回</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="${ctx}/js/ckplayer/ckplayer.js" ></script>
<script src="${ctx}/js/htmldiff.js" type="text/javascript"></script>
<script type="text/javascript">

    var video_shown = false;

    function show_video() {
        var file = nginx_url + $("#article_video").find(" :selected").val();
        alert(file);

        <%--//  CKobject.embedSWF(播放器路径,容器id,播放器id/name,播放器宽,播放器高,flashvars的值,其它定义也可省略);--%>
        <%--//  swf--%>
        var flashvars={ f:file, c:0, b:1 };
        var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always',wmode:'transparent'};
        CKobject.embedSWF('${ctx}/js/ckplayer/ckplayer.swf','video','ckplayer_a1','640','360',flashvars,params);

        //  html5
        var video=[file + '->video/mp4','http://www.ckplayer.com/webm/0.webm->video/webm','http://www.ckplayer.com/webm/0.ogv->video/ogg'];
        var support=['iPad','iPhone','ios','android+false','msie10+false'];
        CKobject.embedHTML5('video','ckplayer_a1',640,360,video,flashvars,support);
    }

    $("#article_video").change(function(){
        if (video_shown == true) {
            show_video();
        }
    });

    $("#article_show_video").live("click",function(){
        var group = $("#video_group");
        var button = $("#article_show_video");
        if (video_shown == false) {
            group.show();

            show_video();

            button.val("隐藏");
            video_shown = true;
        }
        else {
            CKobject.videoPause();

            group.hide();
            button.val("显示");
            video_shown = false;
        }
    });

    //  ckeditor采取异步方式setData, 以下函数可以在提交时正确得到ckeditor数据
    function ckupdate() {
//        var instance;
//        for (instance in CKEDITOR.instances)
            CKEDITOR.instances['article_content'].updateElement();
    }

    function removeHTMLTag(str) {
        str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
        str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
        str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
        str = str.replace(/&nbsp;/ig,'');   //去掉&nbsp;
        str = str.replace(/\s/g, '');   //去掉所有空格
        str = str.replace(/[\ |\~|\`|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?]/g, '');
        //         。 ；  ， ： “ ”（ ） 、 ？ 《 》
        str = str.replace(/[\u3002\uff1b\uff0c\uff1a\u201c\u201d\uff08\uff09\u3001\uff1f\u300a\u300b]/g, '');
        return str;
    }

    function removeHTMLTag2(str) {
        str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
        return str;
    }

    <c:if test="${auditMode == true}">
    $("#auditPass").live("click",function(){
        $("#submit-type").val("pass");
    });

    $("#auditReject").live("click",function(){
        $("#submit-type").val("reject");
    });
    </c:if>

    var history_diff_mode = false;
    var current_content = "";
    <c:if test="${auditMode == true || reapplyMode == true}">
    $("#check_article_history").live("click",function(){
        var editor = CKEDITOR.instances['article_content'];
        if (history_diff_mode) {
            editor.setReadOnly(false);
            history_diff_mode = false;
            editor.setData(current_content);
            $("#check_article_history").val("比较");
        }
        else {
            ckupdate();

            current_content = $('#article_content').val();
            var selected = $("#article_history").find(" :selected").val();
            $.getJSON(ctx + '/news/article/history/' + selected, function (data) {
                var history = data.content;
                var diff = getHTMLDiff(history, current_content);
                editor.setData(diff);
                editor.setReadOnly(true);
                history_diff_mode = true;
                $("#check_article_history").val("退出比较");
            });
        }
    });
    </c:if>

    $("#download_text").live("click",function() {
        location.href = ctx + '/util/download/text/' + ${article.id};
    });

    <c:if test="${auditMode == true || createMode == true}">
    $(".shortcut").live("click",function(){
        var tag = "";
        switch ($(this).attr('id')) {
            case "sc_content":
                tag = "【正文】";
                break;
            case "sc_cg":
                tag = "【CG】";
                break;
            case "sc_interview":
                tag = "【采访】";
                break;
            case "sc_sync":
                tag = "【同期】";
                break;
            case "sc_shot":
                tag = "【空镜】";
                break;
            case "sc_scene":
                tag = "【现场】";
                break;
        }
        CKEDITOR.instances['article_content'].insertHtml("<span style='color:#FF0000'>"+tag+"</span> ");
    });
    </c:if>

    function checkContentLength(){
        ckupdate();
        var c = $('#article_content').val();
        c = removeHTMLTag(c);
        var chars = c.length;
        var seconds = chars * ${secondsPerChar};
        $("#content_time").val("总字数："+chars+",   总时长："+seconds+"秒");
    }

    $(function () {
        //  set readonly states of ckeditor
        CKEDITOR.replace('article_content', {readOnly: (${contentReadonly == true})} );

        setInterval(checkContentLength, 500);   // 检查ckeditor定时器

        var column_sel = $("#article_columnId");
        column_sel.select2({minimumResultsForSearch: -1});

        var video_sel = $("#article_video");
        video_sel.select2({minimumResultsForSearch: -1});

        //  set readonly states of select2 controls
        <c:if test="${readonly == true}">
            column_sel.select2("readonly", true);
            $("#article_reporters").select2("readonly", true);
            $("#article_cameramen").select2("readonly", true);
            $("#article_editors").select2("readonly", true);
            video_sel.select2("readonly", true);
        </c:if>

        <c:if test="${reapplyMode == true}">
        $.getJSON(ctx + '/news/article/detail-with-vars/${article.id}/${taskId}', function(data) {
            $("#auditOpinion").val(data.variables.auditOpinion);
        });
        </c:if>

        <c:if test="${reapplyMode == true || auditMode == true}">
        $.getJSON(ctx + '/news/article/objlist/histories/' + ${article.id}, function(data) {
            var histories = '';
            var template = "<option value='#id'>#name</option>";
            var templateSelected = "<option value='#id' selected='selected'>#name</option>";
            var i = 0;
            $.each(data, function(dk, dv) {
                var curr;
                if (i++ == 0)
                    curr = templateSelected;
                else
                    curr = template;
                $.each(dv, function(k, v) {
                    var id = '';
                    if (k == 'id') {
                        curr = curr.replace(/#id/g, v);
                    }
                    else if (k == 'displayTitle') {
                        curr = curr.replace(/#name/g, v);
                    }
                });
                histories += curr;
            });
            var article_sel = $('#article_history');
            article_sel.html(histories);
            article_sel.select2({minimumResultsForSearch: -1});
        });
        </c:if>

        $("#inputForm").submit(function (event) {
            if (history_diff_mode) {
                CKEDITOR.instances['article_content'].setData(current_content);
//                alert('请退出历史比较模式！');
//                event.preventDefault();
//                return;
            }

            ckupdate();
            
            var map = {};

            //  audit mode
            <c:if test="${auditMode == true}">
            var opinion = $('#opinion').val();
            if (opinion.length == 0) {
                alert('请输入审核意见！');
                event.preventDefault();
                return;
            }
            var taskKey = "${taskKey}";
            var passed = false;
            if ($("#submit-type").val() == "pass")
                passed = true;
            switch (taskKey) {
                case 'class1Audit':
                    map["audit1Pass"] = passed;
                    break;
                case 'class2Audit':
                    map["audit2Pass"] = passed;
                    break;
                case 'class3Audit':
                    map["audit3Pass"] = passed;
                    break;
            }
            map["auditOpinion"] = opinion;
            </c:if>
            
            //  reapply mode and audit mode, all changes must send as variable map
            <c:if test="${reapplyMode == true || auditMode == true}">
            map["mainTitle"] = $('#article_mainTitle').val();
            map["subTitle"] = $('#article_subTitle').val();
            map["content"] = $('#article_content').val();
            map["location"] = $('#article_location').val();
            map["interviewTime"] = $('#article_interviewTime').val();
            map["sourcers"] = $('#article_sourcers').val();
            map["sourcersTel"] = $('#article_sourcersTel').val();
            map["notes"] = $('#article_notes').val();
            map["prepareSendProvTV"] = $('#article_prepareSendProvTV').is(':checked');
            map["prepareSendCCTV"] = $('#article_prepareSendCCTV').is(':checked');
            map["sentToProvTV"] = $('#article_sentToProvTV').is(':checked');
            map["sentToCCTV"] = $('#article_sentToCCTV').is(':checked');
            map["adoptedByProvTV"] = $('#article_adoptedByProvTV').is(':checked');
            map["adoptedByCCTV"] = $('#article_adoptedByCCTV').is(':checked');

            //  new Array()不能用{}代替，否则会报错！
            var reps = [];//new Array();
            var cams = [];//new Array();
            var edts = [];//new Array();
            var i = 0;
            $.each(
                    $('#article_reporters' + ' :selected'), function () {
                        reps[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#article_cameramen' + ' :selected'), function () {
                        cams[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#article_editors' + ' :selected'), function () {
                        edts[i++] = $(this).val();
                    }
            );
            map["reporters"] = reps;
            map["cameramen"] = cams;
            map["editors"] = edts;
            map["video"] = video_sel.find(" :selected").val();
            <%--</c:if>--%>

            <%--<c:if test="${auditMode == true || reapplyMode == true}">--%>
            //  sending complete req
            $.ajax({
                type: 'post',
                async: true,
                url: ctx + '/news/article/complete/' + ${taskId},
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/article/list/task'
                    } else {
                        alert('操作失败!');
                    }
                },
                error: function () {
                    alert('操作失败!!');
                }
            });
            event.preventDefault();
            </c:if>
        });
    });
</script>

</body>
</html>
