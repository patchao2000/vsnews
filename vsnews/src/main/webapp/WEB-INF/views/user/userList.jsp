<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-2
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>用户列表</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx}/css/_pagination.css" media="all" rel="stylesheet" type="text/css"/>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <p />
            <div class='row'>
                <div class='col-sm-12'>
                <%--<div class='form-actions form-actions-padding-sm'>--%>
                <%--<div class='box'>--%>
                <%--<div class="box-content">--%>
                    <div class="pull-left">
                        <div>
                            <%--<a class="btn red dn" id="delete" href="javascript:;"><i class="icon-trash icon-white"></i> 删除</a>--%>
                            <a class="btn btn-primary thickbox" title='添加新用户' href="/Account/User/Create?TB_iframe=true&height=350&width=500"><i class="icon-plus icon-white"></i> 新增</a>
                        </div>
                    </div>
                    <div class="pull-right">
                        <form action="/Account/User/Index" id="search" method="get">
                            <%--<div class="dataTables_filter">--%>
                                <div class='form-group'>
                                    <input value="" placeholder="用户名" class="form-control" name="LoginName" type="text" />
                                    <div class='input-group-btn'>
                                        <button type='submit' class='btn' type='button'>搜索 <i class="icon-search"></i></button>
                                    </div>
                                </div>
                                <%--<div class='form-group'>--%>
                                    <%--<button type="submit" class="btn">搜索 <i class="icon-search"></i></button>--%>
                                <%--</div>--%>
                            <%--</div>--%>
                        </form>
                    </div>
                </div>
            </div>
            <c:if test="${not empty message}">
                <div id="message" class="alert alert-success">${message}</div>
            </c:if>
            <div class='row'>
                <div class='col-sm-12'>
                    <div class='box bordered-box blue-border' style='margin-bottom:0;'>
                        <div class='box-header blue-background'>
                            <div class='title'>用户列表</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content box-no-padding'>
                            <div class='responsive-table'>
                                <div class='scrollable-area'>
                                    <table class='table' style='margin-bottom:0;'>
                                        <thead>
                                        <tr>
                                            <%--<th>ID</th>--%>
                                            <th>用户名</th>
                                            <th>全名</th>
                                            <th>电子邮件</th>
                                            <th>附注</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%--@elvariable id="page" type="com.videostar.vsnews.util.Page"--%>
                                        <%--@elvariable id="user" type="org.activiti.engine.identity.User"--%>
                                        <c:forEach items="${page.result }" var="user">
                                            <tr>
                                                <td>${user.id }</td>
                                                <td>${user.firstName }</td>
                                                <td>${user.email }</td>
                                                <td>${user.lastName }</td>
                                                <td></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <tags:pagination page="${page}" paginationSize="${page.pageSize}"/>
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
