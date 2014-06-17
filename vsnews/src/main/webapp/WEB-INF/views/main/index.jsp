<%@page import="com.videostar.vsnews.util.PropertyFileUtil" %>
<%@page import="org.springframework.beans.factory.config.PropertiesFactoryBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    PropertyFileUtil.init();
%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <script>
        var notLogon = ${empty user};
        if (notLogon) {
            location.href = '${ctx}/login?timeout=true';	//	jump to login
        }
    </script>
    <title>VSNews</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <%--<%@ include file="/common/include-base-styles.jsp" %>--%>
    <%--<%@ include file="/common/include-jquery-ui-theme.jsp" %>--%>
    <%--<link rel="stylesheet" type="text/css" href="${ctx }/css/menu.css" />--%>
    <%--<%@ include file="/common/include-custom-styles.jsp" %>--%>
    <%--<link href="${ctx }/css/main.css" type="text/css" rel="stylesheet"/>--%>
    <style type="text/css">
        /*.ui-tabs-panel {height: 100%; width: 100%;}*/
        /*.ui-tabs .ui-tabs-nav li a {padding-right: .5em;}*/
        /*#tabs li .ui-icon-close { float: left; margin: 0.5em 0.2em 0 0; cursor: pointer; }*/
        /*#add_tab { cursor: pointer; }*/
        /*.list-group-item-success { background:#d9edf7; }*/

        /*.list-group-item-success { background:#8ab9dc; }*/
        /*.list-group > a.list-group-item:hover {*/
        /*color: #000000;*/
        /*}*/
        /*.list-group > a.list-group-item {*/
        /*color: #ffffff;*/
        /*}*/

        /* keep iframe full height */
        body,html,.container,.centerpane,.col-md-10,#maintabs,.tab-content,.tab-pane {
            height:100%;
        }

        .nav-tabs > li .close {
            margin: -2px 0 0 10px;
            font-size: 18px;
        }
    </style>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <%--<script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>--%>
    <%--<script src="${ctx }/js/common/plugins/jquery-ui/extends/layout/jquery.layout.min.js?v=1.3" type="text/javascript"></script>--%>
    <script src='${ctx }/js/common/tools.js' type="text/javascript"></script>
    <script src='${ctx }/js/module/main/mainframe.js' type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            $('#loginOut').click(function () {
                if (confirm('系统提示，您确定要退出本次登录吗?')) {
                    location.href = ctx + '/user/logout';
                }
            });
        });
    </script>
</head>

<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">VSNews</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b
                                    class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li class="divider"></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <p class="navbar-text">欢迎您, <a href="#" class="navbar-link">${user.id }</a></p>
                        <%--<li>角色：${groupNames } ${user.firstName }${user.lastName }/${user.id }</li>--%>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">操作 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" id="loginOut">安全退出</a></li>
                                <%--<li><a href="#">Action</a></li>--%>
                                <%--<li><a href="#">Another action</a></li>--%>
                                <%--<li><a href="#">Something else here</a></li>--%>
                                <%--<li class="divider"></li>--%>
                                <%--<li><a href="#">Separated link</a></li>--%>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>
        </div>
    </div>
    <div class="row clearfix centerpane">
        <div class="col-md-2 column">
            <div id="navimenu">
                <div class="list-group">
                    <a rel="main/welcome" href="#" class="list-group-item active" data-parent="#navimenu">首页</a>
                    <a rel="#" href="#topic" class="list-group-item list-group-item-info" data-toggle="collapse"
                       data-parent="#navimenu">新闻选题</a>

                    <div class="collapse" id="topic">
                        <a rel="news/topic/apply" href="#" class="list-group-item">创建选题</a>
                        <a rel="news/topic/list/task" href="#" class="list-group-item">待办任务</a>
                        <a rel="news/topic/list/running" href="#" class="list-group-item">运行中</a>
                        <a rel="news/topic/list/finished" href="#" class="list-group-item">已结束</a>
                    </div>
                    <a rel="#" href="#article" class="list-group-item list-group-item-info" data-toggle="collapse"
                       data-parent="#navimenu">新闻文稿</a>

                    <div class="collapse" id="article">
                        <a rel="news/article/apply" href="#" class="list-group-item">创建文稿</a>
                        <a rel="news/article/list/task" href="#" class="list-group-item"><span class="badge">99</span>待办任务</a>
                        <a rel="news/article/list/running" href="#" class="list-group-item">运行中</a>
                        <a rel="news/article/list/finished" href="#" class="list-group-item">已结束</a>
                    </div>
                    <a rel="#" href="#leave" class="list-group-item list-group-item-info" data-toggle="collapse"
                       data-parent="#navimenu">请假</a>

                    <div class="collapse" id="leave">
                        <a rel="oa/leave/apply" href="#" class="list-group-item">请假申请</a>
                        <a rel="oa/leave/list/task" href="#" class="list-group-item">请假办理</a>
                        <a rel="oa/leave/list/running" href="#" class="list-group-item">运行中流程</a>
                        <a rel="oa/leave/list/finished" href="#" class="list-group-item">已结束流程</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-10 column">
            <div id="maintabs">
                <ul class="nav nav-tabs">
                    <li><a href="#home" id="tab-0" data-toggle="tab"><button class="close closeTab" type="button">×</button>首页</a></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane" id="home">
                        <iframe id="mainIframe" name="mainIframe" src="welcome" class="module-iframe" seamless
                                style="width:100%;height:100%;border:none;" frameborder="no"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- #BottomPane -->
<%--<div id="bottomPane"--%>
<%--class="ui-layout-south ui-widget ui-widget-content">--%>
<%--<div class="footer ui-state-default">--%>
<%--<a href="http://www.videostar.com" target="_blank">Videostar</a> <span--%>
<%--class="copyright">©2014</span> <span class="version">Version：${prop['system.version']}</span>--%>
<%--</div>--%>
<%--</div>--%>

</body>
</html>
