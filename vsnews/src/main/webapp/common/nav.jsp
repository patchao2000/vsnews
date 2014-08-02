<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String uri = request.getRequestURI();
    boolean inTopic = false, inTopicApply = false, inTopicList = false, inTopicRunning = false, inTopicFinished = false;
    boolean inArticle = false, inArticleEdit = false, inArticleList = false;
//    , inArticleRunning = false
    boolean inManage = false, inUserManage = false, inGroupManage = false, inColumnManage = false;
    boolean inWelcome = false;
    if (uri.contains("/news/topic"))
        inTopic = true;
    if (uri.contains("/news/article"))
        inArticle = true;
    if (uri.contains("topicApply"))
        inTopicApply = true;
    if (uri.contains("/topic/taskList"))
        inTopicList = true;
    if (uri.contains("/topic/running"))
        inTopicRunning = true;
    if (uri.contains("/topic/alltopics"))
        inTopicFinished = true;
    if (uri.contains("articleEdit"))
        inArticleEdit = true;
    if (uri.contains("/article/taskList"))
        inArticleList = true;
//    if (uri.contains("/article/running"))
//        inArticleRunning = true;
    if (uri.contains("/main/welcome"))
        inWelcome = true;
    if (uri.contains("/user") || uri.contains("/news/column"))
        inManage = true;
    if (uri.contains("/list/user"))
        inUserManage = true;
    if (uri.contains("/list/group"))
        inGroupManage = true;
    if (uri.contains("/news/column"))
        inColumnManage = true;
%>
<div id='main-nav-bg'></div>
<nav class='main-nav-fixed' id='main-nav'>
    <div class='navigation'>
        <%--<div class='search'>--%>
            <%--<form action='search_results.html' method='get'>--%>
                <%--<div class='search-wrapper'>--%>
                    <%--<input value="" class="search-query form-control" placeholder="Search..." autocomplete="off" name="q"--%>
                           <%--type="text"/>--%>
                    <%--<button class='btn btn-link icon-search' name='button' type='submit'></button>--%>
                <%--</div>--%>
            <%--</form>--%>
        <%--</div>--%>
        <ul class='nav nav-stacked'>
            <li class='<%=inWelcome?"active":""%>'>
                <a href='${ctx}/main/welcome'>
                    <i class='icon-dashboard'></i>
                    <span>主页</span>
                </a>
            </li>
            <li class='<%=inTopic?"active":""%>'>
                <a class="dropdown-collapse" href="#"><i class='icon-edit'></i>
                    <span>新闻选题</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='<%=inTopic?"in":""%> nav nav-stacked'>
                    <li class='<%=inTopicApply?"active":""%>'>
                        <a href='${ctx}/news/topic/apply'>
                            <i class='icon-caret-right'></i>
                            <span>撰写选题</span>
                        </a>
                    </li>
                    <li class='<%=inTopicList?"active":""%>'>
                        <a href='${ctx}/news/topic/list/task'>
                            <i class='icon-caret-right'></i>
                            <span>待办任务</span>
                        </a>
                    </li>
                    <li class='<%=inTopicRunning?"active":""%>'>
                        <a href='${ctx}/news/topic/list/running'>
                            <i class='icon-caret-right'></i>
                            <span>运行中任务</span>
                        </a>
                    </li>
                    <li class='<%=inTopicFinished?"active":""%>'>
                        <a href='${ctx}/news/topic/list/all'>
                            <i class='icon-caret-right'></i>
                            <span>所有选题</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class='<%=inArticle?"active":""%>'>
                <a class="dropdown-collapse" href="#"><i class='icon-folder-open'></i>
                    <span>新闻文稿</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='<%=inArticle?"in":""%> nav nav-stacked'>
                    <li class='<%=inArticleEdit?"active":""%>'>
                        <a href='${ctx}/news/article/apply'>
                            <i class='icon-caret-right'></i>
                            <span>创建文稿</span>
                        </a>
                    </li>
                    <li class='<%=inArticleList?"active":""%>'>
                        <a href='${ctx}/news/article/list/task'>
                            <i class='icon-caret-right'></i>
                            <span>待办任务</span>
                        </a>
                    </li>
                    <%--<li class='<%=inArticleRunning?"active":""%>'>--%>
                        <%--<a href='${ctx}/news/article/list/running'>--%>
                            <%--<i class='icon-caret-right'></i>--%>
                            <%--<span>运行中任务</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <li class=''>
                        <a href='${ctx}/news/article/list/all'>
                            <i class='icon-caret-right'></i>
                            <span>所有文稿</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class='<%=inManage?"active":""%>'>
                <a class="dropdown-collapse" href="#"><i class='icon-user'></i>
                    <span>系统管理</span>
                    <i class='icon-angle-down angle-down'></i>
                </a>
                <ul class='<%=inManage?"in":""%> nav nav-stacked'>
                    <li class='<%=inUserManage?"active":""%>'>
                        <a href='${ctx}/user/list/user'>
                            <i class='icon-caret-right'></i>
                            <span>用户管理</span>
                        </a>
                    </li>
                    <li class='<%=inGroupManage?"active":""%>'>
                        <a href='${ctx}/user/list/group'>
                            <i class='icon-caret-right'></i>
                            <span>角色管理</span>
                        </a>
                    </li>
                    <li class='<%=inColumnManage?"active":""%>'>
                        <a href='${ctx}/news/column/list'>
                            <i class='icon-caret-right'></i>
                            <span>栏目管理</span>
                        </a>
                    </li>
                </ul>
            </li>
            <%--<li class=''>--%>
                <%--<a class="dropdown-collapse" href="#"><i class='icon-user'></i>--%>
                    <%--<span>请假</span>--%>
                    <%--<i class='icon-angle-down angle-down'></i>--%>
                <%--</a>--%>
                <%--<ul class='nav nav-stacked'>--%>
                    <%--<li class=''>--%>
                        <%--<a href='${ctx}/oa/leave/apply'>--%>
                            <%--<i class='icon-caret-right'></i>--%>
                            <%--<span>请假申请</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li class=''>--%>
                        <%--<a href='${ctx}/oa/leave/list/task'>--%>
                            <%--<i class='icon-caret-right'></i>--%>
                            <%--<span>请假办理</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li class=''>--%>
                        <%--<a href='${ctx}/oa/leave/list/running'>--%>
                            <%--<i class='icon-caret-right'></i>--%>
                            <%--<span>运行中流程</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li class=''>--%>
                        <%--<a href='${ctx}/oa/leave/list/finished'>--%>
                            <%--<i class='icon-caret-right'></i>--%>
                            <%--<span>已结束流程</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</li>--%>

        </ul>
    </div>
</nav>
