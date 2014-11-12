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
                                    <table class='data-table table table-bordered table-striped' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <th>栏目</th>
                                            <th>申请人</th>
                                            <th>申请时间</th>
                                            <th>标题</th>
                                            <th>当前节点</th>
                                            <%--<th>状态</th>--%>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.ArticleDetail"--%>
                                        <c:forEach items="${list }" var="detail">
                                            <c:set var="task" value="${detail.article.task }"/>
                                            <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                                            <c:set var="pi" value="${detail.article.processInstance }"/>
                                            <%--@elvariable id="pi" type="org.activiti.engine.runtime.ProcessInstance"--%>
                                            <tr id="${detail.article.id }">
                                                <td>${detail.columnName }</td>
                                                <td>${detail.userName }</td>
                                                <td><fmt:formatDate value="${detail.article.applyTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${detail.article.mainTitle }</td>
                                                <td>
                                                    <%--<c:choose>--%>
                                                        <%--<c:when test="${task != null}">--%>
                                                        <%--<a class="trace" href='#' data-pid="${pi.id }" data-pdid="${pi.processDefinitionId}" title="点击查看流程图">${task.name }</a>--%>
                                                        <%--</c:when>--%>
                                                        <%--<c:otherwise>无/已完成</c:otherwise>--%>
                                                    <%--</c:choose>--%>
                                                    <c:choose>
                                                        <c:when test="${detail.article.status == 2}">审核完成</c:when>
                                                        <c:otherwise>${task.name }</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <%--<td>${detail.article.statusString }</td>--%>
                                                <td>
                                                    <a class="viewArticle btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
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
        $('.handle').click(function () {
            var taskKey = $(this).attr('data-taskKey');
            var articleId = $(this).parents('tr').attr('id');
            var taskId = $(this).parents('tr').attr('data-tid');
            
            if (taskKey == 'modifyForAudit1' || taskKey == 'modifyForAudit2' || taskKey == 'modifyForAudit3') {
                location.href = ctx + '/news/article/reapply/'+articleId+'/'+taskId;
                return;
            }
            else if (taskKey == 'class1Audit' || taskKey == 'class2Audit' || taskKey == 'class3Audit') {
                location.href = ctx + '/news/article/audit/'+articleId+'/'+taskId+'/'+taskKey;
                return;
            }

            alert(taskKey + " ERROR!");
        });

        $('.viewArticle').click(function () {
            var articleId = $(this).parents('tr').attr('id');
            location.href = ctx + '/news/article/view/' + articleId;
        });
    });
</script>
</body>
</html>
