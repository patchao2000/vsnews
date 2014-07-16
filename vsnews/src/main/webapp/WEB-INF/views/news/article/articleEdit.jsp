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
                    <div class='box' style='margin-bottom:0'>
                        <div class='box-header blue-background'>
                            <div class='title'><%=mainTitle%></div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form id="inputForm" action="#" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='title'>标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='title' name='title' placeholder='标题' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='text'>内容：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control ckeditor' id='text' name = 'text' placeholder='内容' rows='7'></textarea>
                                    </div>
                                </div>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button class='btn btn-primary' type='submit'>
                                                <i class='icon-save'></i>
                                                提交
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
</body>
</html>
