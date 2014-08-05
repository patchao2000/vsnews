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
    });
</script>
</body>
</html>
