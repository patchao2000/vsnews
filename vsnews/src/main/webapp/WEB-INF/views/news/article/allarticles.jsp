<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-29
  Time: 上午1:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>所有新闻文稿</title>
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
                            <div class='title'>新闻文稿</div>
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
                                            <th>栏目</th>
                                            <th>申请人</th>
                                            <th>申请时间</th>
                                            <th>标题</th>
                                            <th>内容</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.ArticleDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <tr id="${detail.article.id }">
                                                <td>${detail.columnName }</td>
                                                <td>${detail.userName }</td>
                                                <td><fmt:formatDate value="${detail.article.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${detail.article.mainTitle }</td>
                                                <td>${detail.plainContent }</td>
                                                <td>${detail.article.statusString }</td>
                                                <td>
                                                    <a class="viewarticle btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
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
        $('.viewarticle').click(function () {
            var articleId = $(this).parents('tr').attr('id');
            location.href = ctx + '/news/article/view/' + articleId;
        });
    });
</script>
</body>
</html>
