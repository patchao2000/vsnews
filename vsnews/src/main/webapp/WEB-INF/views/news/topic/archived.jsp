<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 15/1/8
  Time: 下午4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.activiti.engine.identity.Group" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <%@ include file="/common/global.jsp"%>
  <%@ include file="/common/meta.jsp" %>
  <title>已存档新闻选题</title>
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
                  <table class='data-table table table-bordered table-striped' style='margin-bottom:0;'>
                    <thead>
                    <tr>
                      <th>申请人</th>
                      <th>被派遣人</th>
                      <th>申请时间</th>
                      <th>标题</th>
                      <th>当前节点</th>
                      <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%--@elvariable id="list" type="java.util.List"--%>
                    <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.TopicTaskDetail"--%>
                    <%--@elvariable id="canRestore" type="java.lang.Boolean"--%>
                    <c:forEach items="${list }" var="detail">
                      <tr id="${detail.topic.id }">
                        <c:set var="task" value="${detail.topic.task }"/>
                        <%--@elvariable id="task" type="org.activiti.engine.task.Task"--%>
                        <td>${detail.userName }</td>
                        <td>${detail.dispatcherName }</td>
                        <td><fmt:formatDate value="${detail.topic.applyTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>${detail.topic.title }</td>
                        <td>
                          <c:choose>
                            <c:when test="${detail.topic.status == 2}">审核完成</c:when>
                            <c:otherwise>${task.name }</c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <a class="viewtopic btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
                          <c:if test="${canRestore == true}">
                            <a class="restoretopic btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>还原</a>
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
<script src="${ctx }/js/common/bootstrap/js/bootstrap-dialog.min.js"></script>
<script type="text/javascript">
  $(document).ready(function () {
    $('.viewtopic').click(function () {
      var topicId = $(this).parents('tr').attr('id');
      location.href = ctx + '/news/topic/view/' + topicId;
    });

    $('.restoretopic').click(function () {
      var topicId = $(this).parents('tr').attr('id');
      var dialog = new BootstrapDialog({
        type: BootstrapDialog.TYPE_WARNING,
        title: '还原选题',
        message: '<div><h3>真要还原该选题吗？</h3></div>',
        buttons: [{
          icon: 'icon-remove',
          label: '还原',
          cssClass: 'btn-danger',
          action: function(){
            $.post(ctx + '/news/topic/restore/' + topicId,
                    function(resp) {
                      if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/topic/list/all';
                      } else {
                        alert('操作失败!');
                      }
                    });
          }
        }, {
          label: '关闭',
          action: function(dialog){
            dialog.close();
          }
        }]
      });
      dialog.realize();
      dialog.open();

    });

  });
</script>
</body>
</html>
