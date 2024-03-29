<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14/11/8
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%--%>
  <%--response.setHeader("Pragma","No-cache");--%>
  <%--response.setHeader("Cache-Control","no-store");--%>
  <%--response.setDateHeader("Expires", 0);--%>
<%--%>--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <%@ include file="/common/global.jsp"%>
  <%@ include file="/common/meta.jsp" %>
  <title>所有新闻串联单模板</title>
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
              <div class='title'>新闻串联单模板</div>
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
                      <th>标题</th>
                      <th>开始时段</th>
                      <th>结束时段</th>
                      <th>当前节点</th>
                      <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%--@elvariable id="list" type="java.util.List"--%>
                    <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.StoryboardTaskDetail"--%>
                    <c:forEach items="${list }" var="detail">
                      <tr id="${detail.template.id }">
                        <td>${detail.userName }</td>
                        <td>${detail.columnName }</td>
                        <td>${detail.template.title }</td>
                        <td>${detail.template.startTC }</td>
                        <td>${detail.template.endTC }</td>
                        <td>${detail.task.name }</td>
                        <td>
                          <%--<a class="viewstoryboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>--%>
                          <c:if test="${detail.task == null}">
                            <a class="editstoryboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>
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
    $('.editstoryboard').click(function () {
        var sbId = $(this).parents('tr').attr('id');
        location.href = ctx + '/news/storyboard/view/template/' + sbId;
    });

    $(document).ready(function () {
    });
</script>
</body>
</html>
