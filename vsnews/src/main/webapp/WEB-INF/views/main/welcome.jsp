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
                                                    <%--@elvariable id="list" type="java.util.List"--%>
                                                    <%--@elvariable id="msg" type="com.videostar.vsnews.entity.news.NewsMessage"--%>
                                                    <c:forEach items="${list }" var="msg">
                                                    <li class='message'>
                                                        <%--<div class='body'>--%>
                                                            <%--您没有任何留言--%>
                                                        <%--</div>--%>
                                                        <div class='avatar'>
                                                            <img alt='Avatar' height='23' src='${ctx}/assets/images/avatar.gif' width='23'>
                                                        </div>
                                                        <div class='name-and-time'>
                                                            <div class='name pull-left'>
                                                                <small>
                                                                    <a class="text-contrast" href="#">${msg.senderId }</a>
                                                                </small>
                                                            </div>
                                                            <%--<div class='time pull-right'>--%>
                                                                <%--<small class='date pull-right text-muted'>--%>
                                                                    <%--<span class='timeago fade has-tooltip' data-placement='top' title='2013-09-15 17:42:37 +0200'>September 15, 2013 - 17:42</span>--%>
                                                                    <%--<i class='icon-time'></i>--%>
                                                                <%--</small>--%>
                                                            <%--</div>--%>
                                                        </div>
                                                        <div class='body'>${msg.content }</div>
                                                        <%--<tr id="${msg.id }">--%>
                                                            <%--<td><fmt:formatDate value="${msg.sentDate}" pattern="yyyy-MM-dd HH:mm" /></td>--%>
                                                            <%--<td>${msg.senderId }</td>--%>
                                                            <%--<td>${msg.receiverId }</td>--%>
                                                            <%--<td>${msg.content }</td>--%>
                                                        <%--</tr>--%>
                                                    </li>
                                                    </c:forEach>
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

            <%--<div class="col-md-6">--%>
                <%--<div id="video">Loading the player...</div>--%>
            <%--</div>--%>

            <%--<div class='col-md-12'>--%>
                <%--<div class='form-group'>--%>
                    <%--<textarea class='ckeditor form-control' id='track_sample' rows='20' ></textarea>--%>
                <%--</div>--%>
            <%--</div>--%>

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
<%--<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/js/htmldiff.js" type="text/javascript"></script>--%>

<%--<script src="${ctx}/js/jwplayer/jwplayer.js" ></script>--%>
<%--<script>jwplayer.key="H6eyBd5KQX42h8hPhe04Ldd7sd9a24ZYwXh5sA==";</script>--%>

<%--<script src="${ctx}/js/ckplayer/ckplayer.js" ></script>--%>

<script type="text/javascript">
    $(function () {
//        jwplayer("video").setup({
//            file: "http://192.168.1.119/Sample2.mp4",
//            image: "http://192.168.1.119/Sample2.jpg",
//            width: 640,
//            height: 360
//        });

        <%--//  CKobject.embedSWF(播放器路径,容器id,播放器id/name,播放器宽,播放器高,flashvars的值,其它定义也可省略);--%>
        <%--//  swf--%>
        <%--var flashvars={ f:'http://192.168.1.119/Sample1.mp4', c:0, b:1 };--%>
        <%--var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always',wmode:'transparent'};--%>
        <%--CKobject.embedSWF('${ctx}/js/ckplayer/ckplayer.swf','video','ckplayer_a1','640','360',flashvars,params);--%>

        <%--//  html5--%>
        <%--var video=['http://192.168.1.119/1.mp4->video/mp4','http://www.ckplayer.com/webm/0.webm->video/webm','http://www.ckplayer.com/webm/0.ogv->video/ogg'];--%>
        <%--var support=['iPad','iPhone','ios','android+false','msie10+false'];--%>
        <%--CKobject.embedHTML5('video','ckplayer_a1',640,360,video,flashvars,support);--%>

        <%--function closelights(){//关灯--%>
            <%--alert(' 本演示不支持开关灯');--%>
        <%--}--%>
        <%--function openlights(){//开灯--%>
            <%--alert(' 本演示不支持开关灯');--%>
        <%--}--%>

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

//        var oldT = '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">【媒体称叶迎春和沈冰卷入周永康案 正接受调查】据媒体从权威渠道了解到的消息，央视主播叶迎春和前主播沈冰卷入周永康案，目前正接受调查。今年年初，曾有传言称叶迎春被调查。她在央视许久未露面，但她未通过任何渠道澄清过传闻。沈冰08年北京奥运会后淡出央视。据悉，其自2009年2月起，担任中央政法委信息中心副主任。当时周永康任中共中央政治局常委、中央政法委书记。</p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">周永康被立案审查后，有传闻称央视女主播欧阳夏丹、李小萌、劳春燕涉案，经查证，三人目前均正常工作。有关传闻均系谣言。</p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;"><strong>贾晓烨曾经和叶迎春、沈冰等一起任职央视</strong></p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">据东北网报道，近日，鉴于周永康涉嫌严重违纪，中共中央决定，依据《中国共产党章程》和《中国共产党纪律检查机关案件检查工作条例》的有关规定，由中共中央纪律检查委员会对其立案审查。周永康现任妻子贾晓烨曾供职央视，2001年嫁给周永康。贾晓烨的身份一直很神秘，据传，目前在国内的互联网上搜索到的照片均不是贾晓烨本人。另据传言，央视女主播叶迎春是周永康的秘密情人。</p>';
//        var newT = '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">【媒体称，叶某某和沈火</p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">卷入周永康案 正接受调查】据媒体从权威渠道了解到的消息，央视主播叶某某和前主播沈火卷入周永康案，目前正接受调查。今年年初，曾有传言称叶某某被调查。她在央视许久未露面，但她未通过渠道澄清过传闻。沈火08年北京奥运会后淡出央视。据悉，其自2009年2月起，担任中央政法委信息中心副主任。当时周永康任中共中央政治局常委、中央政法委书记。</p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">周永康被立案审查后，有传闻称央视女主播<span style="font-size:18px;">欧阳夏丹、李小萌</span>、劳春燕涉案，经查证，三人目前均正常工作。有关传闻均系谣言。</p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;"><strong>贾晓烨曾经和叶某某、沈火等一起任职央视</strong></p>'+
//        '<p style="padding: 0px; margin: 26px 0px; font-size: 16px; text-indent: 2em; color: rgb(37, 37, 37); font-family: 宋体, sans-serif; line-height: 28px; text-align: justify;">据东北网报道，由中共中央纪律检查委员会对其立案审查。周永康现任妻子贾晓烨曾供职央视，2001年嫁给周永康。贾晓烨的身份一直很神秘，据传，目前在国内的互联网上搜索到的照片均不是贾晓烨本人。另据传言，央视女主播叶某某是周永康的秘密情人。</p>';
//
//        $("#track_sample").html(getHTMLDiff(oldT, newT));

    });
</script>
</body>
</html>
