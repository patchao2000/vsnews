<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-23
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>所有新闻串联单</title>
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
                            <div class='title'>新闻串联单</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='data-table table table-bordered table-striped' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <th>创建人</th>
                                            <th>栏目</th>
                                            <th>播出日期</th>
                                            <th>标题</th>
                                            <th>当前节点</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="userId" type="java.lang.String"--%>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.StoryboardTaskDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <tr id="${detail.storyboard.id }">
                                                <td>${detail.userName }</td>
                                                <td>${detail.columnName }</td>
                                                <td><fmt:formatDate value="${detail.storyboard.airDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${detail.title }</td>
                                                <td><c:choose>
                                                    <c:when test="${detail.storyboard.status == 2}">审核完成</c:when>
                                                    <c:otherwise>${detail.task.name }</c:otherwise>
                                                </c:choose></td>
                                                <td>
                                                    <a class="view-storyboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
                                                    <c:if test="${detail.storyboard.status == 0 &&
                                                    (detail.storyboard.lockerUserId == null || detail.storyboard.lockerUserId == userId)}">
                                                        <a class="edit-storyboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>编辑</a>
                                                    </c:if>
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
        $('.view-storyboard').click(function () {
            var sbId = $(this).parents('tr').attr('id');
            location.href = ctx + '/news/storyboard/view/' + sbId;
        });

        $('.edit-storyboard').click(function () {
            var sbId = $(this).parents('tr').attr('id');
            location.href = ctx + '/news/storyboard/edit/' + sbId;
        });
    });
</script>
</body>
</html>
