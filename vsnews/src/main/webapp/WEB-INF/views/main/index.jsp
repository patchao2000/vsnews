<%@page import="com.videostar.vsnews.util.PropertyFileUtil" %>
<%--<%@page import="org.springframework.beans.factory.config.PropertiesFactoryBean" %>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%
    PropertyFileUtil.init();
%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>VSNews</title>
    <%@ include file="/common/allcss.jsp" %>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
</div>

<%@ include file="/common/alljs.jsp" %>
</body>
</html>
