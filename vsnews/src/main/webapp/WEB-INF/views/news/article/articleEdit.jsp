<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-27
  Time: 下午4:28
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%
        String mainTitle = "编辑文稿";
    %>
    <title><%=mainTitle%></title>

    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/ckeditor/ckeditor.js"></script>

    <script type="text/javascript">
        $(function () {
        });
    </script>
</head>

<body>
<!-- <div class="container"> -->
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#message').hide('slow');
        }, 5000);
    </script>
</c:if>
<c:if test="${not empty error}">
    <div id="error" class="alert alert-error">${error}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#error').hide('slow');
        }, 5000);
    </script>
</c:if>
<form:form id="inputForm" action="#" method="post" class="well col-md-8">
    <h3><%=mainTitle%></h3>
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
            <textarea id="content" name="content" class="form-control" rows="8"></textarea>
            <script>
                // Replace the <textarea id="editor1"> with a CKEditor
                // instance, using default configuration.
                CKEDITOR.replace('content');
            </script>
        </div>
    </div>
    <%--<div class="row">--%>
        <%--<div class="form-group col-md-8">--%>
            <%--<label for="devices">需要设备：</label>--%>
            <%--<textarea id="devices" name="devices" class="form-control" rows="3"></textarea>--%>
        <%--</div>--%>
    <%--</div>--%>
    <div class="row">
        <div class="form-group col-md-4">
            <button type="submit" class="btn btn-default">保存</button>
        </div>
    </div>
</form:form>
<!-- </div> -->
</body>
</html>
