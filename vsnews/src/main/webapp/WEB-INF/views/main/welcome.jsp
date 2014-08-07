<%@ page import="com.videostar.vsnews.util.PropertyFileUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    PropertyFileUtil.init();
%>
<%--<?xml version="1.0" encoding="UTF-8" ?>--%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<!doctype html>--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>

    <title>欢迎</title>
    <%@ include file="/common/allcss.jsp" %>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <%@ include file="/common/message-error.jsp" %>

            <div class='row' id='content-wrapper'>
                <div class='col-xs-12'>

                    <div class='page-header page-header-with-buttons'>
                        <h1 class='pull-left'>
                            <i class='icon-dashboard'></i>
                            <span>欢迎访问VSNews</span>
                        </h1>
                        <div class='pull-right'>
                            <div class='btn-group'>
                                <a class="btn btn-white hidden-xs" href="#">上个月</a>
                                <a class="btn btn-white" href="#">上周</a>
                                <a class="btn btn-white " href="#">今天</a>
                                <%--<a class="btn btn-white" id="daterange" href="#"><i class='icon-calendar'></i>--%>
                                    <%--<span>Custom</span>--%>
                                    <%--<b class='caret'></b>--%>
                                <%--</a>--%>
                            </div>
                        </div>
                    </div>
                    <div class='alert alert-info alert-dismissable'>
                        <a class='close' data-dismiss='alert' href='#'>&times;</a>
                        您好，${user.firstName }！欢迎您访问VSNews系统。
                    </div>

                    <div class='row'>
                        <div class='col-sm-12 col-md-6'>
                            <div class='row todo-list'>
                                <div class='col-sm-12'>
                                    <div class='box'>
                                        <div class='box-header'>
                                            <div class='title'>
                                                <i class='icon-list-alt'></i>
                                                待办任务
                                            </div>
                                            <div class='actions'>
                                                <a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                                                </a>

                                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class='box-content box-no-padding'>
                                            <div class='sortable-container'>
                                                <%--<div class='date text-contrast'>Today</div>--%>
                                                <ul class='list-unstyled sortable' data-sortable-axis='y' data-sortable-connect='.sortable'>
                                                    <li class='important item'>
                                                        <label class='pull-left todo'>
                                                            <span id="topicTodo">您没有任何待办任务</span>
                                                        </label>
                                                    </li>
                                                    <li class='important item'>
                                                        <%--<label class='check pull-left todo'>--%>
                                                        <label class='pull-left todo'>
                                                            <%--<input type='checkbox'>--%>
                                                            <span id="articleTodo">您没有任何待办任务</span>
                                                        </label>
                                                        <%--<div class='actions pull-right'>--%>
                                                        <%--<a class='btn btn-link edit has-tooltip' data-placement='top' href='#' title='Edit todo'>--%>
                                                        <%--<i class='icon-pencil'></i>--%>
                                                        <%--</a>--%>
                                                        <%--<a class='btn btn-link remove has-tooltip' data-placement='top' href='#' title='Remove todo'>--%>
                                                        <%--<i class='icon-remove'></i>--%>
                                                        <%--</a>--%>
                                                        <%--<a class='btn btn-link important has-tooltip' data-placement='top' href='#' title='Mark as important'>--%>
                                                        <%--<i class='icon-bookmark-empty'></i>--%>
                                                        <%--</a>--%>
                                                        <%--</div>--%>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class='col-sm-12 col-md-6'>
                            <div class='row chat'>
                                <div class='col-sm-12'>
                                    <div class='box'>
                                        <div class='box-header'>
                                            <div class='title'>
                                                <i class='icon-comments-alt'></i>
                                                留言
                                            </div>
                                            <div class='actions'>
                                                <a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                                                </a>

                                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class='box-content box-no-padding'>
                                            <div class='scrollable' data-scrollable-height='300' data-scrollable-start='bottom'>
                                                <ul class='list-unstyled list-hover list-striped'>
                                                    <li class='message'>
                                                        <div class='avatar'>
                                                            <img alt='Avatar' height='23' src='${ctx}/assets/images/avatar.gif' width='23'>
                                                        </div>
                                                        <div class='name-and-time'>
                                                            <div class='name pull-left'>
                                                                <small>
                                                                    <a class="text-contrast" href="#">张三</a>
                                                                </small>
                                                            </div>
                                                            <div class='time pull-right'>
                                                                <small class='date pull-right text-muted'>
                                                                    <span class='timeago fade has-tooltip' data-placement='top' title='2013-09-15 17:42:37 +0200'>September 15, 2013 - 17:42</span>
                                                                    <i class='icon-time'></i>
                                                                </small>
                                                            </div>
                                                        </div>
                                                        <div class='body'>
                                                            下班后请来我办公室领奖金
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class='col-md-12'>
                <textarea class='form-control' id='track_sample' rows='20' >
                    近日，新加坡联合早报网刊登对台湾军事学者、淡江大学国际事务与战略研究所教授林中斌的专访，认为习近平有“七项超越”，包括在福建、浙江和上海任职长达23年，深耕台商人脉，对台湾的理解超越历史;对国际社会的了解超越历史；对军队的了解超越历史;父亲习仲勋在党内的良好名声，使习近平接班时的党内地位就很高;他也是中共第一个“博士总书记”；有亮丽的夫人可为他“政治加分”；对宗教问题也比较同情。现予转发，与网友分享：

                    台湾著名军事学者、现任淡江大学国际事务与战略研究所教授林中斌，可以说是一个奇人。

                    说林教授是“奇人”，一是他曾先后在台湾蓝绿执政时担任国民主政的“行政院”大陆委员会副主委，以及民进党主政时的“国防部”副部长;二是他曾长时间无法踏足中国大陆，却依然深谙中国时局变化，提出的见解与预测深受重视。

                    在新加坡出席“慧眼中国环球论坛”期间，林中斌接受专访时向《联合早报》证实，从1996年他出任陆委会副主委，到2003年至2004年出任“国防部”副部长，此后再守住敏感公职人员离任后不得访问大陆的“冷冻期”。算起来，从1996年到2009年，他有整整13年没有到大陆。
                </textarea>
            </div>

            <%--<div class="center">--%>
                <%--<div style="text-align: center;">--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                    <%--<h1>欢迎访问VSNews</h1>--%>
                    <%--<h2>欢迎访问VSNews</h2>--%>
                    <%--<h3>欢迎访问VSNews</h3>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/js/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="${ctx}/js/ckeditor/plugins/lite/lite_interface.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/article/count/task',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#articleTodo').html("您没有任何待办新闻文稿任务。");
                else
                    $('#articleTodo').html("您<a class='text-contrast' href='${ctx}/news/article/list/task'>有 " + resp + " 条</a>待办新闻文稿任务。");
            },
            error: function () {
                alert('articleTodo error!!');
            }
        });

        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/topic/count/task',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#topicTodo').html("您没有任何待办新闻选题任务。");
                else
                    $('#topicTodo').html("您<a class='text-contrast' href='${ctx}/news/topic/list/task'>有 " + resp + " 条</a>待办新闻选题任务。");
            },
            error: function () {
                alert('articleTodo error!!');
            }
        });

        var editor = CKEDITOR.replace("track_sample", {
            height: "400",
            customConfig: "${ctx}/js/ckeditor/ckeditor-loopindex-conf.js"
        });

//        function onConfigLoaded(e) {
//            var conf = e.editor.config;
//            var lt = conf.lite = conf.lite || {};
//            if (location.href.indexOf("debug") > 0) {
//                lt.includeType = "debug";
//            }
//        }
//        editor.on('configLoaded', onConfigLoaded);

        editor.on(LITE.Events.INIT, function(event) {
            var lite = event.data.lite;
            lite.toggleShow(true);
        });
    });


</script>
</body>
</html>
