<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-4
  Time: 下午5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <title>创建选题</title>

    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <%-- <%@ include file="/common/include-base-styles.jsp" %> --%>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
</head>

<body>
<!-- <div class="container"> -->
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function() {
            $('#message').hide('slow');
        }, 5000);
    </script>
</c:if>
<c:if test="${not empty error}">
    <div id="error" class="alert alert-error">${error}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function() {
            $('#error').hide('slow');
        }, 5000);
    </script>
</c:if>
<form:form id="inputForm" action="${ctx}/news/topic/start" method="post"
           class="well col-md-8">
    <h3>创建选题</h3>
    <hr>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="title">标题：</label>
            <textarea id="title" name="title" class="form-control" rows="1"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="content">内容：</label>
            <textarea id="content" name="content" class="form-control" rows="5"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="devices">需要设备：</label>
            <textarea id="devices" name="devices" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-4">
            <button type="submit" class="btn btn-default">提交</button>
        </div>
    </div>
</form:form>
<!-- </div> -->

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
