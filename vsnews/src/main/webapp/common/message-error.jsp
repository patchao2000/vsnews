<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-16
  Time: 下午4:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <div id="error" class="alert alert-danger">${error}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#error').hide('slow');
        }, 5000);
    </script>
</c:if>
