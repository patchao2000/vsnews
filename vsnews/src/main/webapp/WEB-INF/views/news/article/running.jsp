<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-29
  Time: 上午12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>文稿正在运行中的流程实例列表</title>
    <%@ include file="/common/allcss.jsp" %>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
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
                                    <table class="data-table-column-filter table table-bordered table-striped" style='margin-bottom:0;'>
                                        <thead>
                                            <tr>
                                                <th>申请人</th>
                                                <th>申请时间</th>
                                                <th>标题</th>
                                                <th>内容</th>
                                                <th>当前节点</th>
                                                <th>任务创建时间</th>
                                                <th>流程状态</th>
                                                <th>当前处理人</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="article" type="com.videostar.vsnews.entity.news.NewsArticle"--%>
                                        <c:forEach items="${list }" var="article">
                                            <c:set var="task" value="${article.task }" />
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${article.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>

                                            <tr id="${article.id }" tid="${task.id }">
                                                <td>${article.userId }</td>
                                                <td><fmt:formatDate value="${article.applyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${article.mainTitle }</td>
                                                <td>${article.content }</td>
                                                <td>${task.name }</td>
                                                <td><fmt:formatDate value="${task.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                                <td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${article.processDefinition.version }</b></td>
                                                <td>${task.assignee }</td>
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
</body>
</html>
