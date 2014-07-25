<%@ page import="org.activiti.engine.identity.Group" %>
<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-18
  Time: 上午2:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>所有新闻选题</title>
    <%@ include file="/common/allcss.jsp" %>
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
                    <div class='box bordered-box blue-border' style='margin-bottom:0;'>
                        <div class='box-header blue-background'>
                            <div class='title'>新闻选题</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='data-table-column-filter table table-bordered table-striped' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <th>申请人</th>
                                            <th>申请时间</th>
                                            <th>标题</th>
                                            <th>内容</th>
                                            <th>设备</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.NewsTopic"--%>
                                        <c:forEach items="${list }" var="topic">
                                            <tr id="${topic.id }">
                                                <td>${topic.userId }</td>
                                                <td><fmt:formatDate value="${topic.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${topic.title }</td>
                                                <td>${topic.content }</td>
                                                <td>${topic.devices }</td>
                                                <td>${topic.statusString }</td>
                                                <td>
                                                    <a class="viewtopic btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
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
<script type="text/javascript">
    $(document).ready(function () {
        $('.viewtopic').click(function () {
            var topicId = $(this).parents('tr').attr('id');
            location.href = ctx + '/news/topic/view/' + topicId;
        });
    });
</script>
</body>
</html>
