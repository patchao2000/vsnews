<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14/11/24
  Time: 下午6:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <%@ include file="/common/global.jsp"%>
  <%@ include file="/common/meta.jsp" %>
  <title>所有日志</title>
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
              <div class='title'>系统日志</div>
              <div class='actions'>
                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                </a>
              </div>
            </div>
            <div class='box-content box-no-padding'>
              <div class='responsive-table'>
                <div class='scrollable-area'>
                  <table class='data-table-reverse table table-bordered table-striped' id='log-table' style='margin-bottom:0;'>
                    <thead>
                    <tr>
                      <th>时间</th>
                      <th>操作人</th>
                      <th>操作</th>
                      <th>附注</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%--@elvariable id="list" type="java.util.List"--%>
                    <%--@elvariable id="detail" type="com.videostar.vsnews.web.system.logDetail"--%>
                    <c:forEach items="${list }" var="detail">
                      <tr>
                        <td><fmt:formatDate value="${detail.log.accessTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>${detail.userName }</td>
                        <td>${detail.log.operation }</td>
                        <td>${detail.log.notes }</td>
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
//  $(document).ready(function () {
//    $('#log-table').dataTable( {
//      "aaSorting": [[ 1, "desc" ]]
//    } );
//  });
</script>
</body>
</html>
