<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-9
  Time: 下午10:47
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
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
                            <div class='title'>${title}</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class="data-table table table-bordered table-striped" style='margin-bottom:0;'>
                                        <thead>
                                        <%--@elvariable id="operation" type="java.lang.Boolean"--%>
                                        <tr>
                                            <th>时间</th>
                                            <th>发送人</th>
                                            <th>接收人</th>
                                            <th>内容</th>
                                            <c:if test="${operation == true}">
                                            <th>操作</th>
                                            </c:if>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="list" type="java.util.List"--%>
                                        <%--@elvariable id="msg" type="com.videostar.vsnews.entity.news.NewsMessage"--%>
                                        <c:forEach items="${list }" var="msg">
                                            <tr id="${msg.id }">
                                                <td><fmt:formatDate value="${msg.sentDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                                <td>${msg.senderId }</td>
                                                <td>${msg.receiverId }</td>
                                                <td>${msg.content }</td>
                                                <c:if test="${operation == true}">
                                                <td><c:if test="${msg.markRead != true}">
                                                    <a class='mark_read btn btn-success btn-xs' href='#'>已读</a>
                                                </c:if>
                                                </td>
                                                </c:if>
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
    var failMessage = '操作失败!', successMessage = '任务完成!';

    <c:if test="${operation == true}">
    $(".mark_read").live("click",function(){
        var id = $(this).parents('tr').attr('id');
        if (id.length > 0) {
            $.ajax({
                type: 'post',
                async: false,
                url: ctx + '/news/message/mark-read/' + id,
                contentType: "application/json; charset=utf-8",
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/message/list/inbox';
                    } else {
                        alert(failMessage);
                    }
                },
                error: function () {
                    alert(failMessage);
                }
            });
        }
    });
    </c:if>
    $(document).ready(function () {
    });
</script>
</body>
</html>
